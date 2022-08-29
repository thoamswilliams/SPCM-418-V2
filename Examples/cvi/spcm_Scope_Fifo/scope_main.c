/*****************************************************************************/
/*                                                                           */
/*  spcm_Scope_Fifo                                                          */
/*  This Example aquires data from an M2i card using the fifo transfer mode  */
/*  and shows it using a CVI Graph                                           */
/*                                                                           */
/*****************************************************************************/

#include <formatio.h>
#include <ansi_c.h>
#include <utility.h>
#include <cvirte.h>		
#include <userint.h>

#include "scope_main.h"


// ----- include the spectrum headers -----
#include "../c_header/dlltyp.h"
#include "../c_header/regs.h"
#include "../c_header/spcm_drv.h"
#include "../c_header/spcerr.h"



// ----- include files of common components -----
#include "../common/clockdef.h"
#include "../common/clock.h"
#include "../common/info.h"
#include "../common/spcm_lib_card.h"
#include "../common/spcm_lib_data.h"


// ----- global definitions for sub components -----
struct _ST_CLOCK_DEF 	g_stClockDef;

ST_SPCM_CARDINFO g_stCardInfo;
ST_SPCM_CARDINFO *g_pstCardInfo = &g_stCardInfo;

static int g_hMain;

void vFillClockDef (ST_SPCM_CARDINFO* pstCardInfo, struct _ST_CLOCK_DEF* pstClockDef);
void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel);
int CVICALLBACK vDemuxData(void*);

struct stThreadData
	{
	int32 lSamples;
	short** ppnDemuxedData;
	void* pvMuxedData;
	}; 



// ******************************************************************
// 		Main
// ******************************************************************

int main (int argc, char *argv[])
    {
	int i = 		0;
	int hInfoPanel;
	bool bOk = 		false;
	int functionId;

	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */

	if ((g_hMain = LoadPanel (0, "scope_main.uir", PANEL)) < 0)
		return -1;

	// ----- try to open first card
	if(!bSpcMInitCardByIdx(g_pstCardInfo, 0))
		{		
		MessagePopup ("Initialisation", "No Spectrum card found in the system");
		return -1;
		}

	// ----- if first card is no analog acquisition card, exit
	if (g_pstCardInfo->eCardFunction != AnalogIn)
	    {
		MessagePopup ("Initialisation", "This example was done for analog acquistion cards which weren't found in the system");
    	vSpcMCloseCard(g_pstCardInfo);
		return -1;
	    }
		
    // ----- Setup clock panel -----                                                   
    if ((g_stClockDef.hPanel = LoadPanel (g_hMain, "..\\common\\Clock.uir", SP_CLOCK)) < 0)
    	{
    	vSpcMCloseCard(g_pstCardInfo);
    	return -1;
    	}
    vFillClockDef (g_pstCardInfo, &g_stClockDef);
    vClockSetupWrite (&g_stClockDef);                                                  
	DisplayPanel (g_stClockDef.hPanel);
	SetPanelPos (g_stClockDef.hPanel, 15, 5);
	
    
    // ----- setup info -----
    if ((hInfoPanel = LoadPanel (g_hMain, "..\\common\\Info.uir", SP_INFO)) < 0)
    	{
    	vSpcMCloseCard(g_pstCardInfo);
    	return -1;
    	}
    vFillCardInfoPanel (g_pstCardInfo, hInfoPanel);
	DisplayPanel (hInfoPanel);
	SetPanelPos (hInfoPanel, 15, 800 - 225);
    

	// ----- run the main panel
	DisplayPanel (g_hMain);
	RunUserInterface ();
	DiscardPanel (g_hMain);

	vSpcMCloseCard(g_pstCardInfo);
	return 0;
    }


/*****************************************************************************/
/*	Start Button 															 */
/*	Starts card setup and data acquisition using FIFO mode					 */
/*****************************************************************************/

int CVICALLBACK lGetData(int panel, int control, int event, void *callbackData, int eventaData1, int eventData2)
	{
	int32 lSamples = 			32768;
	int32 lSegmentSize = 		1024;
	int i;
	int lBitsPerSample;
	int32 lChPerModule;
	int32 lAvailBytes;
	int32 lBytePos =			0;
	int lChEnable =				0;
	uint64 qwMemInBytes =		0;
	uint32 dwTotalBytes = 		0;
	uint32 dwError = 			ERR_OK;
	int lVoltRange = 			1000; // +/- 1V
	uint32 dwDataNotify =		4096;
	void* pvBuffer = 			NULL;
	short** ppnChannelData = 	NULL;
	int lFunctionID = 			1;
	int lChColor[4] =			{VAL_GREEN, VAL_RED, VAL_BLUE, VAL_YELLOW};
	struct stThreadData	stThreadData;
	int* alXArray;

	switch(event)
		{
		case EVENT_COMMIT:

			spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_RESET);
			
			// setup array for x axis plot
			alXArray = (int*) malloc (lSamples * sizeof(int));
			for(i=0; i< lSamples; i++)
				alXArray[i] = i;

			// ----- read input form, read card parameters, set parameters according to input
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_CLOCK, &g_stClockDef.lSamplerate);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_OUTPUT, &g_stClockDef.lClockOutput);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_TERMINATION, &g_stClockDef.lClockTermination);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_CLOCKEXTERNAL, &g_stClockDef.lExternalClock);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_BYTESPERSAMPLE, &g_pstCardInfo->lBytesPerSample);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_BITSPERSAMPLE, &lBitsPerSample);
			
			// ----- activate up to four channels on card
			SetCtrlVal (g_hMain, PANEL_STATUS, "Starting Setup");
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_MODULES, &g_pstCardInfo->lModulesCount);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_CHPERMODULE, &lChPerModule);
			if(g_pstCardInfo->lModulesCount == 1)
				{
				if(lChPerModule == 1)
					{
					lChEnable = CHANNEL0;
					g_pstCardInfo->lSetChannels = 1;
					}
				else
					{
					lChEnable = CHANNEL0 | CHANNEL1;
					g_pstCardInfo->lSetChannels = 2;
					}
				}
			else
				{
				if(lChPerModule == 1)
					{
					lChEnable = CHANNEL0 | CHANNEL1;
					g_pstCardInfo->lSetChannels = 2;
					}
					
				else
					{
					lChEnable = CHANNEL0 | CHANNEL1 | CHANNEL2 |CHANNEL3;
					g_pstCardInfo->lSetChannels = 4;
					}
				}

			// set software trigger, no trigger output
    		bSpcMSetupTrigSoftware (g_pstCardInfo, false);
	
			// set receive mode
			if(!bSpcMSetupModeRecFIFOSingle(g_pstCardInfo, lChEnable, 32, lSegmentSize, lSamples/lSegmentSize))
				{
				nSpcMErrorMessageStdOut (g_pstCardInfo, "... Setup Fifo mode error", true);
				return -1;
				}

			// set voltage range
			for (i=0; i<g_pstCardInfo->lSetChannels; i++)
				{
				bSpcMSetupInputChannel(g_pstCardInfo, i, lVoltRange, g_stClockDef.lClockTermination, 0, false);
				}

			// set clock mode
			if(g_stClockDef.lExternalClock == 0)
				{
				// set internal PLL and clock output
				bSpcMSetupClockPLL(g_pstCardInfo, g_stClockDef.lSamplerate, g_stClockDef.lClockOutput);
				}
			else
				{
				// set external clock speed, termination and divider
				bSpcMSetupClockExternal(g_pstCardInfo, g_stClockDef.lExtRange, g_stClockDef.lClockTermination, 1);
				}

			// allocate memory for samples
			SetCtrlVal (g_hMain, PANEL_STATUS, "Allocating");
			qwMemInBytes = lSamples * g_pstCardInfo->lSetChannels * g_pstCardInfo->lBytesPerSample;
			if(pvBuffer)
				free(pvBuffer);
			pvBuffer = malloc((int)qwMemInBytes*sizeof(uint8));
			memset(pvBuffer, 0, (int)qwMemInBytes*sizeof(uint8));
			
			// clear old graph, setup x and y axis
			DeleteGraphPlot (g_hMain,PANEL_GRAPH, -1, VAL_IMMEDIATE_DRAW);
			SetCtrlAttribute (g_hMain, PANEL_GRAPH, ATTR_YAXIS_GAIN, lVoltRange/1000 * 1/pow(2, lBitsPerSample-1));
			SetAxisScalingMode (g_hMain, PANEL_GRAPH, VAL_BOTTOM_XAXIS, VAL_MANUAL, 0, lSamples);

			// setup data structure for demux thread
			stThreadData.pvMuxedData = pvBuffer;
			stThreadData.ppnDemuxedData = NULL;
			
			// setup transfer and start card
			dwError = spcm_dwDefTransfer_i64 (g_pstCardInfo->hDrv, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, dwDataNotify, pvBuffer, 0, qwMemInBytes);
			dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_SAMPLERATE, g_stClockDef.lSamplerate);
			dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER|M2CMD_DATA_WAITDMA | M2CMD_DATA_STARTDMA);
			if(dwError)
				{
				nSpcMErrorMessageStdOut (g_pstCardInfo, "... Start error", true);
				return -1;
				}
			SetCtrlVal (g_hMain, PANEL_STATUS, "Started");

			// we acquire data in a loop. As we defined a notify size of 4k we’ll get the data in >=4k chuncks
			SetCtrlVal (g_hMain, PANEL_STATUS, "Receiving");
			while (!dwError)
				{

				// read out the available bytes
				dwError = spcm_dwGetParam_i32 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_USER_LEN, &lAvailBytes);
				dwTotalBytes += (uint32)lAvailBytes;
				stThreadData.lSamples = dwTotalBytes/g_pstCardInfo->lSetChannels/g_pstCardInfo->lBytesPerSample ;
				
				// here is the right position to do something with the data
				// demux in extra thread
				SetCtrlVal (g_hMain, PANEL_STATUS, "Demultiplexing");
				dwError = CmtScheduleThreadPoolFunction (DEFAULT_THREAD_POOL_HANDLE, vDemuxData, &stThreadData, &lFunctionID);
				if(dwError)
					return -1;

				// wait for demux thread to finish
				CmtWaitForThreadPoolFunctionCompletion (DEFAULT_THREAD_POOL_HANDLE, lFunctionID, 0);

				// ----- plot new samples from demultiplexed data
				SetCtrlVal (g_hMain, PANEL_STATUS, "Plotting");
				for(i=0; i<g_pstCardInfo->lSetChannels; i++)
					PlotXY (g_hMain, PANEL_GRAPH, alXArray+(lBytePos/g_pstCardInfo->lSetChannels/g_pstCardInfo->lBytesPerSample), stThreadData.ppnDemuxedData[i]+(lBytePos/g_pstCardInfo->lSetChannels/g_pstCardInfo->lBytesPerSample), lAvailBytes/g_pstCardInfo->lSetChannels/g_pstCardInfo->lBytesPerSample , VAL_INTEGER, VAL_SHORT_INTEGER, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, lChColor[i]);
				
				// now we free the number of bytes
				dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_CARD_LEN, lAvailBytes);
				dwError = spcm_dwGetParam_i32 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_USER_POS, &lBytePos);

				// wait for the next buffer or quit loop if all requested samples have arrived
				if(lBytePos != 0)
					dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_DATA_WAITDMA);
				else
					{
					spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_STOP|M2CMD_CARD_FLUSHFIFO|M2CMD_DATA_STOPDMA);
					break;	
					}
				}            	


			// ----- free allocated memory
			free(pvBuffer);
			for(i=0; i<g_pstCardInfo->lSetChannels; i++)
				if(stThreadData.ppnDemuxedData[i])
					free(stThreadData.ppnDemuxedData[i]);
	
			free(stThreadData.ppnDemuxedData);
			free(alXArray);
			SetCtrlVal (g_hMain, PANEL_STATUS, "Done");
			break;
		}
	
	return 0;
	}


/*****************************************************************************/
/*	vDemuxData	 															 */
/*	executed as thread														 */
/*****************************************************************************/

int CVICALLBACK vDemuxData(void *pvData)
	{
	int i;
	struct stThreadData *pstThreadData = pvData;
	
	// free memory
	if(pstThreadData->ppnDemuxedData)
		{
		for(i=0; i< g_pstCardInfo->lSetChannels; i++)
			if(pstThreadData->ppnDemuxedData[i])
				free(pstThreadData->ppnDemuxedData[i]);
		free(pstThreadData->ppnDemuxedData);
		}
		
	
	// ----- allocate buffers for splitted channel data, demux channel data
	// ----- if two modules are active data is sorted mod0ch0, mod1ch0, mod0ch1, ... 
	pstThreadData->ppnDemuxedData = (short**) malloc (g_pstCardInfo->lSetChannels * sizeof(short*));
	for(i=0; i< g_pstCardInfo->lSetChannels; i++)
		{
		pstThreadData->ppnDemuxedData[i] = (short*)malloc(pstThreadData->lSamples * sizeof(short));
		memset(pstThreadData->ppnDemuxedData[i], 0, pstThreadData->lSamples * sizeof(short));
		if(!pstThreadData->ppnDemuxedData[i])
			{
			// ----- not enough memory, free allocated memory and exit
			for(--i; i >= 0; i--)
				free(pstThreadData->ppnDemuxedData[i]);
			free(pstThreadData->ppnDemuxedData);
			free(pstThreadData->pvMuxedData);
			nSpcMErrorMessageStdOut (g_pstCardInfo, "... Memory allocation error", false);
			return -1;
			}	
		}
	bSpcMDemuxAnalogDataToInt16 (g_pstCardInfo, pstThreadData->pvMuxedData, pstThreadData->lSamples, pstThreadData->ppnDemuxedData);
	
	return 0;
	}

/*****************************************************************************/
/*	Quit Button 															 */
/*****************************************************************************/

int CVICALLBACK vQuit (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
	switch (event)
		{
		case EVENT_COMMIT:
			QuitUserInterface (0);
			break;
		}
	return 0;
    }

/*****************************************************************************/
/* 		vFillClockDef: fill the clock definition from the driver             */
/*****************************************************************************/

void vFillClockDef (ST_SPCM_CARDINFO* pstCardInfo, struct _ST_CLOCK_DEF* pstClockDef)
    {
    pstClockDef->lMinClock = 1000;                                                     		
    spcm_dwGetParam_i32 (pstCardInfo->hDrv, SPC_MIINST_MAXADCLOCK, &pstClockDef->lMaxClock);
    
    pstClockDef->lExtRangeMask = EXRANGE_LOW | EXRANGE_HIGH;   
    pstClockDef->lSamplerate = KILO(100);                                                
    pstClockDef->lExternalClock = 0;                                                   
    pstClockDef->lClockOutput = 0;                                                     
    pstClockDef->lClockTermination = 0;                                                
    pstClockDef->lReferenceClock = 0;                                                  
    pstClockDef->lExtRange = EXRANGE_LOW;                                           
    }

/*****************************************************************************/
/* 		vFillCardInfoPanel:                                                  */
/*****************************************************************************/

void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel)
    {
    char szBuffer[32];
    
    switch (pstCardInfo->lCardType & TYP_SERIESMASK)
    	{
    	case TYP_M2ISERIES: 	sprintf (szBuffer, "M2i.%x", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M2IEXPSERIES: 	sprintf (szBuffer, "M2i.%x-Exp", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
        case TYP_M3ISERIES: 	sprintf (szBuffer, "M3i.%x", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M3IEXPSERIES: 	sprintf (szBuffer, "M3i.%x-Exp", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M4IEXPSERIES: 	sprintf (szBuffer, "M4i.%x-x8", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M4XEXPSERIES: 	sprintf (szBuffer, "M4x.%x-x4", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M2PEXPSERIES: 	sprintf (szBuffer, "M2p.%x-x4", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	}
    	
    SetCtrlVal (hPanel, SP_INFO_BRDTYPE, szBuffer);
    
    sprintf (szBuffer, "%05d", pstCardInfo->lSerialNumber);
    SetCtrlVal (hPanel, SP_INFO_SN, szBuffer);
    }
