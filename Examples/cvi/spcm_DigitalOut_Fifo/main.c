/*****************************************************************************/
/*                                                                           */
/*  spcm_DigitalOut                                                          */
/*  This Example outputs a digital sine signal using the fifo transfer mode  */
/*                                                                           */
/*****************************************************************************/

#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
#include <wtypes.h>
#include "main.h"

#include "../common/spcm_lib_card.h"
#include "../common/spcm_lib_data.h"
#include "../common/info.h"
#include "../common/clock.h"
#include "../common/clockdef.h"
#include "../common/TrOut.h"
#include "../common/TrOutDef.h"
#include "../common/72Levels.h"
#include "../common/72LevelDef.h"


static int g_hMain, g_hLevel, g_hInfo, g_hTrigger;
bool g_bStop = 						false;
ST_SPCM_CARDINFO g_stCardInfo;
ST_SPCM_CARDINFO* g_pstCardInfo = 	&g_stCardInfo;
struct _ST_CLOCK_DEF g_stClockDef;
struct _ST_72LEVELS_DEF g_stLevelsDef;
struct _ST_TROUT_DEF g_stTrigger;


void vFillClockDef (ST_SPCM_CARDINFO* pstCardInfo, struct _ST_CLOCK_DEF* pstClockDef);
void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel);

/*****************************************************************************/
/*  Main                                                                     */
/*****************************************************************************/

int main (int argc, char *argv[])
	{
	char szBuffer[64];
	int i;
	
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	
	if ((g_hMain = LoadPanel (0, "main.uir", PANEL)) < 0)
		return -1;
		
    // init card number 0 (the first card in the system), get some information and print it
    if (!bSpcMInitCardByIdx (g_pstCardInfo, 0))
        {
        MessagePopup ("Initialisation", "No spectrum cards were found in your system.");
        return nSpcMErrorMessageStdOut (g_pstCardInfo, "Error: Could not open card\n", true);
		}
		
    // check whether we support this card type in the example
    if ((g_pstCardInfo->eCardFunction != AnalogOut) && (g_pstCardInfo->eCardFunction != DigitalOut) && (g_pstCardInfo->eCardFunction != DigitalIO))
        {
        MessagePopup ("Initialisation", "This example was done for Digital IO cards which weren't found in the system");
        return nSpcMErrorMessageStdOut (g_pstCardInfo, "Error: Card function not supported by this example\n", false);		
		}

	// create level selection panel
	if ((g_stLevelsDef.hPanel = LoadPanel (g_hMain, "..\\common\\72Levels.uir", SP_LEVEL)) < 0)
		{
		vSpcMCloseCard(g_pstCardInfo);
		return -1;
		}
	

	// create clock panel                                                  
    if ((g_stClockDef.hPanel = LoadPanel (g_hMain, "..\\common\\Clock.uir", SP_CLOCK)) < 0)
    	{
    	vSpcMCloseCard(g_pstCardInfo);
    	return -1;
    	}
    vFillClockDef (g_pstCardInfo, &g_stClockDef);
    vClockSetupWrite (&g_stClockDef);
	SetCtrlAttribute(g_stClockDef.hPanel, SP_CLOCK_CLOCK, ATTR_DIMMED, 1);
	DisplayPanel (g_stClockDef.hPanel);
	SetPanelPos (g_stClockDef.hPanel, 20, 5);
	
	
	// set output levels to default
    for (i=0; i<8; i++)
    	{
        g_stLevelsDef.lLowLevel[i] = 0;
        g_stLevelsDef.lHighLevel[i] = 3300;
     	}
    g_stLevelsDef.lMaxChannel = 16; 
	vLevelsSetupWrite (&g_stLevelsDef);
	DisplayPanel(g_stLevelsDef.hPanel);
	SetPanelPos (g_stLevelsDef.hPanel, 36, 210);
	SetPanelAttribute(g_stLevelsDef.hPanel, ATTR_DIMMED, 0);


	// create info panel
	if ((g_hInfo = LoadPanel (g_hMain, "..\\common\\Info.uir", SP_INFO)) < 0)
		{
		vSpcMCloseCard(g_pstCardInfo);
		return -1;
		}
	vFillCardInfoPanel(g_pstCardInfo, g_hInfo);
	DisplayPanel(g_hInfo);
	SetPanelPos (g_hInfo, 20, 800 - 225);
	
	// create trigger panel, dim unused input fields
	if ((g_stTrigger.hPanel = LoadPanel (g_hMain, "..\\common\\TrOut.uir", SP_TROUT)) <0 )
		{
		vSpcMCloseCard(g_pstCardInfo);
		return -1;
		}	
	g_stTrigger.lModeMask = TROUT_MODE_SINGLESHOT | TROUT_MODE_CONTINOUS;
	g_stTrigger.lMode = 	TROUT_MODE_SINGLESHOT; 
	vTrigOutSetupWrite(&g_stTrigger);
	SetCtrlAttribute(g_stTrigger.hPanel, SP_TROUT_MODE, ATTR_DIMMED, 1);
	SetCtrlAttribute(g_stTrigger.hPanel, SP_TROUT_MEMSIZE, ATTR_DIMMED, 1);
	DisplayPanel(g_stTrigger.hPanel);
	SetPanelPos (g_stTrigger.hPanel, 200, 5);
	
	DisplayPanel (g_hMain);
	RunUserInterface ();
	DiscardPanel (g_hMain);
	
	// clean up and close the driver
	vSpcMCloseCard(g_pstCardInfo);
	
	return 0;
	}


/*****************************************************************************/
/*	Quit Button																 */
/*****************************************************************************/

int CVICALLBACK vQuit (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
	{
	switch (event)
		{
		case EVENT_COMMIT:
			QuitUserInterface(0);
			break;
		}
	return 0;
	}

	

/*****************************************************************************/
/*	Start Button															 */
/*	Starts card setup and output											 */
/*****************************************************************************/

int CVICALLBACK vStart (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
	{
	uint64 	qwMemInBytes;
	void* 	pvBuffer = 				NULL;
	int 	i;
	char	szBuffer[64];
	bool 	bOk;
	int64	llHWBufSize =      		KILO_B(64);
	int64	llSWBufSize =     		KILO_B(128);
	uint32	dwError = 				ERR_OK;
    int64 	llBufferFillPromille;
    bool  	bStarted = 				false;
    int64 	llAvailUser = 			0;
    int64 	llUserPos;
	int64	llNotifySize =     		KILO_B(8);
	int64	llTransferredBytes =	0;
	short	nWaitCnt = 				64;

	switch (event)
		{
		case EVENT_COMMIT:

			g_bStop = false;
			
			SetCtrlVal (g_hMain, PANEL_STATUS, "Starting Setup");
			
			// reset card
			spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_RESET);
			
			// set clock mode
			vClockSetupRead();
			g_stClockDef.lSamplerate = KILO(100); // use 100 kSamples to avioid HW overrun and timeout
			if(g_stClockDef.lExternalClock)
				bOk = bSpcMSetupClockExternal(g_pstCardInfo, g_stClockDef.lExtRange, g_stClockDef.lClockTermination, 1);
			else
				bOk = bSpcMSetupClockPLL(g_pstCardInfo, g_stClockDef.lSamplerate, g_stClockDef.lClockOutput);
			
			if(!bOk)
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Clock mode setup error\n", false);

			// set trigger mode
			vTrigOutSetupRead();
			switch(g_stTrigger.lTriggermode)
				{
				case TM_SOFTWARE:
					// software trigger
					bOk = bSpcMSetupTrigSoftware(g_pstCardInfo, g_stTrigger.lOutput);
					break;
				case TM_TTLPOS:
					// ttl trigger, postive edge
					bOk = bSpcMSetupTrigExternal(g_pstCardInfo, SPC_TM_POS, g_stTrigger.lTermination, 0, true, 0);
					break;
				case TM_TTLNEG:
					// ttl trigger, negative edge
					bOk = bSpcMSetupTrigExternal(g_pstCardInfo, SPC_TM_NEG, g_stTrigger.lTermination, 0, true, 0);
					break;
				}
			if(!bOk)
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Trigger mode setup error\n", false);				
			
			// set replay mode, endless output, 8bit enabled
			bOk = bSpcMSetupModeRepFIFOSingle(g_pstCardInfo, 0xff, 0, 0);

			if(!bOk)			
				{
				SetCtrlVal (g_hMain, PANEL_STATUS, "Error");
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Mode Setup error\n", true);
				}

			// set each digital out
			vLevelsSetupRead();
			spcm_dwGetParam_i32 (g_pstCardInfo->hDrv, SPC_READCHGROUPING, &g_pstCardInfo->uCfg.stDIO.lGroups);
			g_pstCardInfo->uCfg.stDIO.lGroups = g_pstCardInfo->lMaxChannels / g_pstCardInfo->uCfg.stDIO.lGroups;
			for (i=0; i < g_pstCardInfo->uCfg.stDIO.lGroups; i++)
				{
				// set stoplevel to low, define low and high levels, single-ended mode
				if(!bSpcMSetupDigitalOutput (g_pstCardInfo, i, SPCM_STOPLVL_LOW, g_stLevelsDef.lLowLevel[i], g_stLevelsDef.lHighLevel[i], false))
					return nSpcMErrorMessageStdOut (g_pstCardInfo, "Digital output setup error\n", false);
				}				

		    // allocate and setup the fifo buffer and fill it once with data
		    pvBuffer = VirtualAlloc (NULL, (uint32) llSWBufSize, MEM_COMMIT, PAGE_READWRITE);
		    if (!pvBuffer)
		        return nSpcMErrorMessageStdOut (g_pstCardInfo, "Memory allocation error\n", false);
		    for (i=0; i<llSWBufSize; i++)
                ((int8*)pvBuffer)[i] = (int8) i;


		    // starting with firmware version V9 we can program the hardware buffer size to reduce the latency
		    if (g_pstCardInfo->lCtrlFwVersion >= 9)
		        {
		        spcm_dwSetParam_i64 (g_pstCardInfo->hDrv, SPC_DATA_OUTBUFSIZE, llHWBufSize);
		        spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_WRITESETUP);
		        }

		    spcm_dwDefTransfer_i64 (g_pstCardInfo->hDrv, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, (uint32) llNotifySize, pvBuffer, 0, llSWBufSize);
		    spcm_dwSetParam_i64 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_CARD_LEN, llSWBufSize);

		    // now buffer is full of data and we start the transfer (output is not started yet), timeout is 1 second
		    SetCtrlVal (g_hMain, PANEL_STATUS, "Starting DMA");
		    spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_TIMEOUT, 1000);
		    dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA);
	        
	        SetCtrlVal (g_hMain, PANEL_STATUS, "Transferring data to card, right click to stop");
	        SetCtrlAttribute(g_hMain, PANEL_QUITBUTTON, ATTR_DIMMED, 1);
	        while (!dwError && !g_bStop)
		        {
				// check for events (e.g. user clicked or pressed key) every 64th loop
				// this slows down the reaction of the user interface a little but significantly improves transfer speed
		        if(nWaitCnt == 0)
		        	{
		        	ProcessSystemEvents();
		        	nWaitCnt = 63;
		        	}
		        else
		        	nWaitCnt--;
		        
		        spcm_dwGetParam_i64 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_USER_LEN, &llAvailUser);
		        spcm_dwGetParam_i64 (g_pstCardInfo->hDrv, SPC_FILLSIZEPROMILLE, &llBufferFillPromille);


		        // we recalculate the amount of data that is free and set this part available for card again
		        // inhere we only take pieces of notify size
		        if (llAvailUser >= llNotifySize)
		            {
		            llTransferredBytes += llNotifySize;
		            spcm_dwGetParam_i64 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_USER_POS, &llUserPos);
		    		for (i=0; i<llNotifySize; i++)
                		(((int8*)pvBuffer)+ llUserPos)[i] = (int8) i;
		            
		            dwError = spcm_dwSetParam_i64 (g_pstCardInfo->hDrv, SPC_DATA_AVAIL_CARD_LEN, llNotifySize);
		            }

		        // we start the output as soon as we have a sufficient amount of data on card 
		        // inhere we start if the hardware buffer is completely full
		        if (!bStarted && !dwError && (llBufferFillPromille == 1000))
		            {
		            SetCtrlVal (g_hMain, PANEL_STATUS, "Output active, right click to stop");
		            SetCtrlVal (g_hMain, PANEL_LED, 1);
					dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER);
		            bStarted = true;
		            }

		        // wait for the next buffer to be free
		        if (!dwError)
		            dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_DATA_WAITDMA);

		        } // end while loop
		    
			SetCtrlVal (g_hMain, PANEL_LED, 0);
			SetCtrlVal (g_hMain, PANEL_STATUS, "Stopped");
			SetCtrlAttribute(g_hMain, PANEL_QUITBUTTON, ATTR_DIMMED, 0);

		    // show runtime errors
		    if (dwError && !g_pstCardInfo->bSetError)
		        printf ("\nEnd with Runtime Error Code:%d\n-> %s\n\n", dwError, pszSpcMTranslateRuntimeError (dwError, szBuffer));
			
			dwError = spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_STOP);
		    
			// free buffer
		    VirtualFree (pvBuffer, (uint32) llSWBufSize, MEM_RELEASE);

		} // end case

	return 0;
	}

/*****************************************************************************/
/*  vFillClockDef: fill the clock definition from the driver                 */
/*****************************************************************************/

void vFillClockDef (ST_SPCM_CARDINFO* pstCardInfo, struct _ST_CLOCK_DEF* pstClockDef)
    {
    pstClockDef->lMinClock = 1000;                                                     		
    spcm_dwGetParam_i32 (pstCardInfo->hDrv, SPC_MIINST_MAXADCLOCK, &pstClockDef->lMaxClock);
    
    pstClockDef->lExtRangeMask = EXRANGE_LOW | EXRANGE_HIGH;   
    pstClockDef->lSamplerate = KILO (100);                                                
    pstClockDef->lExternalClock = 0;                                                   
    pstClockDef->lClockOutput = 0;                                                     
    pstClockDef->lClockTermination = 0;                                                
    pstClockDef->lReferenceClock = 0;                                                  
    pstClockDef->lExtRange = EXRANGE_LOW;                                           
    }

/*****************************************************************************/
/*  FillCardInfoPanel                                                        */
/*****************************************************************************/

void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel)
    {
    char szBuffer[32];
    
    switch (pstCardInfo->lCardType & TYP_SERIESMASK)
    	{
    	case TYP_M2ISERIES: 	sprintf (szBuffer, "M2i.%x", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M2IEXPSERIES: 	sprintf (szBuffer, "M2i.%x-Exp", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	}
    	
    SetCtrlVal (hPanel, SP_INFO_BRDTYPE, szBuffer);
    
    sprintf (szBuffer, "%05d", pstCardInfo->lSerialNumber);
    SetCtrlVal (hPanel, SP_INFO_SN, szBuffer);
    }


/*****************************************************************************/
/*  vMainCD                                                                  */
/*	if right mouse key clicked or key pressed, exit output loop              */
/*****************************************************************************/

int CVICALLBACK vMainCB (int panel, int event, void *callbackData, int eventData1, int eventData2)
    {
	switch (event)
		{
		case EVENT_RIGHT_CLICK:
		case EVENT_KEYPRESS:
			g_bStop = true;
			break;
		}
	return 0;
    }
