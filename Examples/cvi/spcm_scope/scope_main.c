/*****************************************************************************/
/*                                                                           */
/*  spcm_Scope                                                               */
/*  This Example gets data from an M2i card and shows it using a CVI Graph   */
/*                                                                           */
/*****************************************************************************/

#include <ansi_c.h>
#include <utility.h>
#include <cvirte.h>		
#include <userint.h>

#include <scope_main.h>


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


/*****************************************************************************/
/*  Main                                                                     */
/*****************************************************************************/

int main (int argc, char *argv[])
    {
	int i = 		0;
	int hInfoPanel;
	bool bOk = 		false;

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
/*	Starts card setup and data acquisition									 */
/*****************************************************************************/

int CVICALLBACK lGetData(int panel, int control, int event, void *callbackData, int eventaData1, int eventData2)
	{
	int lChColor[4] = 			{VAL_GREEN, VAL_RED, VAL_BLUE, VAL_YELLOW};
	int lSamples = 				8192;	
	int i;
	int lBitsPerSample ;
	int32 lChPerModule;
	int lChEnable;
	short nErr;
	void* pvBuffer = 			NULL;
	uint64 qwMemInBytes;
	int lVoltRange = 			1000; // +/- 1V
	short** ppnChannelData = 	NULL;
	
	
	switch(event)
		{
		case EVENT_COMMIT:
		
			// ----- read input form, read card parameters, set parameters according to input
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_CLOCK, &g_stClockDef.lSamplerate);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_OUTPUT, &g_stClockDef.lClockOutput);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_TERMINATION, &g_stClockDef.lClockTermination);
			GetCtrlVal(g_stClockDef.hPanel, SP_CLOCK_CLOCKEXTERNAL, &g_stClockDef.lExternalClock);
			
			for (i=0; i<g_pstCardInfo->lSetChannels; i++)
				{
				bSpcMSetupInputChannel(g_pstCardInfo, i, lVoltRange, g_stClockDef.lClockTermination, 0, false);
				}

			// ----- activate up to four channels on card
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_MODULES, &g_pstCardInfo->lModulesCount);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_CHPERMODULE, &lChPerModule);
			if(g_pstCardInfo->lModulesCount == 1)
				{
				if(lChPerModule == 1)
					lChEnable = CHANNEL0;
				else
					lChEnable = CHANNEL0 | CHANNEL1;
				}
			else
				{
				if(lChPerModule == 1)
					lChEnable = CHANNEL0 | CHANNEL1;
				else
					lChEnable = CHANNEL0 | CHANNEL1 | CHANNEL2 |CHANNEL3;
				}
			
			// ----- set receive mode, channels, amount of samples and samples after trigger
			bSpcMSetupModeRecStdSingle(g_pstCardInfo, lChEnable, lSamples, lSamples/2);

			// ----- set clock mode
			if(g_stClockDef.lExternalClock == 0)
				{
				// ----- set internal PLL and clock output
				bSpcMSetupClockPLL(g_pstCardInfo, g_stClockDef.lSamplerate, g_stClockDef.lClockOutput);
				}
			else
				{
				// ----- set external clock speed, termination and divider
				bSpcMSetupClockExternal(g_pstCardInfo, g_stClockDef.lExtRange, g_stClockDef.lClockTermination, 1);
				}


			// ----- start the board -----
			spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_TIMEOUT, 5000);
			nErr = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER | M2CMD_CARD_WAITREADY);
			if(nErr == ERR_TIMEOUT)
				{
				nSpcMErrorMessageStdOut (g_pstCardInfo, "... Timeout", false);
				return -1;
				}

			// ----- get resolution and number of activated channels
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_BYTESPERSAMPLE, &g_pstCardInfo->lBytesPerSample);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_MIINST_BITSPERSAMPLE, &lBitsPerSample);
			spcm_dwGetParam_i32(g_pstCardInfo->hDrv, SPC_CHCOUNT, &g_pstCardInfo->lSetChannels);

			// ----- compute size and allocate buffer
			qwMemInBytes = lSamples * g_pstCardInfo->lBytesPerSample * g_pstCardInfo->lSetChannels;
			pvBuffer = (void*) malloc ((int)qwMemInBytes);
			if(!pvBuffer)
				{
				nSpcMErrorMessageStdOut (g_pstCardInfo, "... Memory allocation error", false);
				return -1;
				}
			memset(pvBuffer, 0, qwMemInBytes);

			// ----- start transfer
       	    spcm_dwDefTransfer_i64 (g_pstCardInfo->hDrv, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pvBuffer, 0, qwMemInBytes);
           	nErr = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA);
           	if (nErr)
           		{
           		nSpcMErrorMessageStdOut (g_pstCardInfo, "... Transfer start failed", false);
           		return -1;
           		}

            // ----- allocate buffers for splitted channel data, demux channel data
            // ----- if two modules are active data is sorted mod0ch0, mod1ch0, mod0ch1, ... 
            ppnChannelData = (short**) malloc (g_pstCardInfo->lSetChannels * sizeof(short*));
    		for(i=0; i< g_pstCardInfo->lSetChannels; i++)
    			{
    			ppnChannelData[i] = (short*)malloc(lSamples*sizeof(short));	
    			if(!ppnChannelData[i])
    				{
					// ----- not enough memory, free allocated memory and exit
					for(--i; i >= 0; i--)
						free(ppnChannelData[i]);
					free(ppnChannelData);
					free(pvBuffer);
					nSpcMErrorMessageStdOut (g_pstCardInfo, "... Memory allocation error", false);
					return -1;
					}	
				}
            bSpcMDemuxAnalogDataToInt16 (g_pstCardInfo, pvBuffer, lSamples, ppnChannelData);
            	
			// ----- plot demultiplexed data
			DeleteGraphPlot (g_hMain,PANEL_GRAPH, -1, VAL_IMMEDIATE_DRAW);
			SetCtrlAttribute (g_hMain, PANEL_GRAPH, ATTR_YAXIS_GAIN, lVoltRange/1000 * 1/pow(2, lBitsPerSample-1));
			SetCtrlAttribute (g_hMain, PANEL_GRAPH, ATTR_XAXIS_OFFSET, (double)-lSamples/2);
			for(i=0; i<g_pstCardInfo->lSetChannels; i++)
				PlotY (g_hMain, PANEL_GRAPH, ppnChannelData[i], lSamples, VAL_SHORT_INTEGER, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, lChColor[i]);
			
			// ----- free allocated memory
			free(pvBuffer);
			for(i=0; i<g_pstCardInfo->lSetChannels; i++)
				if(ppnChannelData[i])
					free(ppnChannelData[i]);
	
			free(ppnChannelData);
			break;
		}

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
/*	vFillClockDef: fill the clock definition from the driver                 */
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
/*	vFillCardInfoPanel                                                       */
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
