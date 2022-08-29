/*****************************************************************************/
/*                                                                           */
/*  spcm_DigitalOut                                                          */
/*  This Example outputs a digital sine signal                               */
/*                                                                           */
/*****************************************************************************/

#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
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
ST_SPCM_CARDINFO g_stCardInfo;
ST_SPCM_CARDINFO* g_pstCardInfo = &g_stCardInfo;
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

	// create clock panel                                                  
    if ((g_stClockDef.hPanel = LoadPanel (g_hMain, "..\\common\\Clock.uir", SP_CLOCK)) < 0)
    	{
    	vSpcMCloseCard(g_pstCardInfo);
    	return -1;
    	}
    vFillClockDef (g_pstCardInfo, &g_stClockDef);
    vClockSetupWrite (&g_stClockDef);                                                  
	DisplayPanel (g_stClockDef.hPanel);
	SetPanelPos (g_stClockDef.hPanel, 15, 5);
	
	
	// create level selection panel
	if ((g_stLevelsDef.hPanel = LoadPanel (g_hMain, "..\\common\\72Levels.uir", SP_LEVEL)) < 0)
		{
		vSpcMCloseCard(g_pstCardInfo);
		return -1;
		}
	
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
	SetPanelPos (g_hInfo, 15, 800 - 225);
	
	// create trigger panel
	if ((g_stTrigger.hPanel = LoadPanel (g_hMain, "..\\common\\TrOut.uir", SP_TROUT)) <0 )
		{
		vSpcMCloseCard(g_pstCardInfo);
		return -1;
		}	
	g_stTrigger.lMemsize = 	8192;
	g_stTrigger.lModeMask = TROUT_MODE_SINGLESHOT | TROUT_MODE_CONTINOUS;
	g_stTrigger.lMode = 	TROUT_MODE_SINGLESHOT; 
	vTrigOutSetupWrite(&g_stTrigger);
	DisplayPanel(g_stTrigger.hPanel);
	SetPanelPos (g_stTrigger.hPanel, 200, 5);
	
	DisplayPanel (g_hMain);
	RunUserInterface ();
	DiscardPanel (g_hMain);
	
	vSpcMCloseCard(g_pstCardInfo);
	
	return 0;
	}

/*****************************************************************************/
/*	Quit Button																 */
/*****************************************************************************/

int CVICALLBACK vQuit (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
	{
	switch (event)
		{
		case EVENT_COMMIT:
			spcm_dwSetParam_i32(g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_STOP);
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
	int32 	lLoops = 			4;	// just a random value, anything except 0 is fine (0 is allowed for unlimited replay but breaks signal generation for this example)
	uint64 	qwMemInBytes;
	void* 	pvBuffer;
	int 	i;
	char	szBuffer[64];
	bool 	bOk;
	uint32	dwError;

	switch (event)
		{
		case EVENT_COMMIT:
			
			SetCtrlVal (g_hMain, PANEL_STATUS, "Starting Setup");
						
			// if start button is pressed, the card will be closed at end of this funtion, therefore reopen if
			// handle == NULL
			// no error handling here because the execution should only reach this point if the opening and error checking in 
			// main() succeeded
			if(!(g_pstCardInfo->hDrv))
				bSpcMInitCardByIdx (g_pstCardInfo, 0);
			
			spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_RESET);

			// set clock mode
			vClockSetupRead();
			if(g_stClockDef.lExternalClock)
				bOk = bSpcMSetupClockExternal(g_pstCardInfo, g_stClockDef.lExtRange, g_stClockDef.lClockTermination, 1);
			else
				bOk = bSpcMSetupClockPLL(g_pstCardInfo, g_stClockDef.lSamplerate, g_stClockDef.lClockOutput);
			
			if(!bOk)
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Clock mode setup error\n", false);
			
			// set replay mode
			switch(g_stTrigger.lMode)
				{
				case TROUT_MODE_SINGLESHOT:
					bOk = bSpcMSetupModeRepStdSingle (g_pstCardInfo, (1 << g_stLevelsDef.lMaxChannel) - 1, g_stTrigger.lMemsize);
					break;
				case TROUT_MODE_CONTINOUS:
					bOk = bSpcMSetupModeRepStdLoops(g_pstCardInfo, (1 << g_stLevelsDef.lMaxChannel) - 1, g_stTrigger.lMemsize, 0);
				}
			if(!bOk)			
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Mode Setup error\n", false);
			
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
			
			// set each digital out
			vLevelsSetupRead();
			dwError = spcm_dwGetParam_i32 (g_pstCardInfo->hDrv, SPC_READCHGROUPING, &g_pstCardInfo->uCfg.stDIO.lGroups);
			g_pstCardInfo->uCfg.stDIO.lGroups = g_pstCardInfo->lMaxChannels / g_pstCardInfo->uCfg.stDIO.lGroups;
			for (i=0; i < g_pstCardInfo->uCfg.stDIO.lGroups; i++)
				{
				// set stoplevel to low, define low and high levels, single-ended mode
				if(!bSpcMSetupDigitalOutput (g_pstCardInfo, i, SPCM_STOPLVL_HOLDLAST, g_stLevelsDef.lLowLevel[i], g_stLevelsDef.lHighLevel[i], false))
					return nSpcMErrorMessageStdOut (g_pstCardInfo, "Digital output setup error\n", false);
				}				

			// buffer for data transfer
        	qwMemInBytes = g_pstCardInfo->llSetMemsize * g_pstCardInfo->lMaxChannels / 8;
        	pvBuffer = malloc ((int)qwMemInBytes * sizeof(uint8));
        	if (!pvBuffer)
            	return nSpcMErrorMessageStdOut (g_pstCardInfo, "Memory allocation error\n", false);
			memset(pvBuffer, 0, qwMemInBytes * sizeof(uint8));
			
			// generate digital data
 			if(!bSpcMCalcSignal (g_pstCardInfo, pvBuffer, (uint32) g_pstCardInfo->llSetMemsize, g_pstCardInfo->lMaxChannels / 8, eSine, 1, 1))
				return nSpcMErrorMessageStdOut (g_pstCardInfo, "Data calculation error\n", false); 				

            // we define the buffer for transfer and start the DMA transfer
            SetCtrlVal (g_hMain, PANEL_STATUS, "Starting Transfer");
			spcm_dwDefTransfer_i64 (g_pstCardInfo->hDrv, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, 0, pvBuffer, 0, qwMemInBytes);
    	    spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA);

	        // check for error code
    	    if (spcm_dwGetErrorInfo_i32 (g_pstCardInfo->hDrv, NULL, NULL, szBuffer))
        	    {
            	free (pvBuffer);
	            return nSpcMErrorMessageStdOut (g_pstCardInfo, szBuffer, false);
    	        }
        	SetCtrlVal (g_hMain, PANEL_STATUS, "Transfer done");
				
	        // We'll start and wait until the card has finished or until a timeout occurs (continuous and single restart will have timeout)
    	    SetCtrlVal (g_hMain, PANEL_STATUS, "Starting Card");
    	    spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_TIMEOUT, 5000);
	        if (spcm_dwSetParam_i32 (g_pstCardInfo->hDrv, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER | M2CMD_CARD_WAITREADY) == ERR_TIMEOUT)
    	        {
        	    free(pvBuffer);
            	SetCtrlVal (g_hMain, PANEL_STATUS, "Timeout");
            	return nSpcMErrorMessageStdOut (g_pstCardInfo, "... Timeout\n", false);
            	}
		
            SetCtrlVal (g_hMain, PANEL_STATUS, "Output finished");
			free(pvBuffer);
		}
	return 0;
	}


/*****************************************************************************/
//  vFillClockDef: fill the clock definition from the driver                 */
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
/*	FillCardInfoPanel                                                        */
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
