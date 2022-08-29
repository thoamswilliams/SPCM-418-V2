#include <ansi_c.h>
#include <utility.h>
#include <cvirte.h>	
#include <userint.h>
#include "spcm_AnalogOut.h"

// ----- include the spectrum headers -----
#include "../c_header/dlltyp.h"
#include "../c_header/regs.h"
#include "../c_header/spcm_drv.h"
#include "../c_header/spcerr.h"

// ----- include files of common components -----
#include "../common/info.h"
#include "../common/spcm_lib_card.h"
#include "../common/spcm_lib_data.h"

typedef struct 
    {
    bool  bRun;
    int64 llSamplerate;
    int64 llMemsize;
    E_SPCM_SIGSHAPE eShape;
    } ST_SETTINGS;


ST_SETTINGS      g_stSettingsGUI;
ST_SPCM_CARDINFO g_stCardInfo;

static int g_hMain;

void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel);
void vUpdateSettings (void);
bool bSetupCard (void);


/*****************************************************************************/
/*  Main                                                                     */
/*****************************************************************************/

int main (int argc, char *argv[])
	{
	int hInfoPanel;
	
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
		
	if ((g_hMain = LoadPanel (0, "spcm_AnalogOut.uir", PANEL)) < 0)
		return -1;
	
	// ----- try to open first card
	if(!bSpcMInitCardByIdx (&g_stCardInfo, 0))
		{		
		MessagePopup ("Initialisation", "No Spectrum card found in the system");
		return -1;
		}
	
	// ----- if first card is no analog acquisition card, exit
	if (g_stCardInfo.eCardFunction != AnalogOut)
		{
		MessagePopup ("Initialisation", "This example was done for AWG cards which weren't found in the system");
    	vSpcMCloseCard(&g_stCardInfo);
		return -1;
		}
	
	// ----- setup info -----
    if ((hInfoPanel = LoadPanel (g_hMain, "..\\common\\Info.uir", SP_INFO)) < 0)
    	{
    	vSpcMCloseCard(&g_stCardInfo);
    	return -1;
    	}
    	
    vFillCardInfoPanel (&g_stCardInfo, hInfoPanel);
	DisplayPanel (hInfoPanel);
	SetPanelPos (hInfoPanel, 5, 5);
	
	// ----- init GUI settings -----
	SetCtrlAttribute (g_hMain, PANEL_NUMERIC_MEMSIZE, ATTR_MAX_VALUE, (unsigned int)(g_stCardInfo.llInstMemBytes / g_stCardInfo.lBytesPerSample / g_stCardInfo.lMaxChannels));	
	SetCtrlAttribute (g_hMain, PANEL_NUMERIC_SRATE, ATTR_MAX_VALUE, (unsigned int)(g_stCardInfo.llMaxSamplerate / 1000000));
	
	g_stSettingsGUI.eShape = eSine;
	SetCtrlVal (g_hMain, PANEL_BUTTON_SINE, 1);
	SetCtrlVal (g_hMain, PANEL_BUTTON_RECT, 0);
	SetCtrlVal (g_hMain, PANEL_BUTTON_TRI,  0);
					
	// ----- run the main panel -----
	DisplayPanel (g_hMain);
	RunUserInterface ();
	DiscardPanel (g_hMain);
	
	vSpcMCloseCard (&g_stCardInfo);
	
	return 0;
	}

/*****************************************************************************/
/*	vFillCardInfoPanel                                                       */
/*****************************************************************************/

void vFillCardInfoPanel (ST_SPCM_CARDINFO* pstCardInfo, int hPanel)
    {
    char szBuffer[32];
    
    switch (pstCardInfo->lCardType & TYP_SERIESMASK)
    	{
    	case TYP_M2ISERIES:     sprintf (szBuffer, "M2i.%x",     (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	case TYP_M2IEXPSERIES:  sprintf (szBuffer, "M2i.%x-Exp", (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
  		case TYP_M4IEXPSERIES:  sprintf (szBuffer, "M4i.%x-x8",  (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
  		case TYP_M4XEXPSERIES:  sprintf (szBuffer, "M4x.%x-x4",  (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
  		case TYP_M2PEXPSERIES: 	sprintf (szBuffer, "M2p.%x-x4",  (pstCardInfo->lCardType) & TYP_VERSIONMASK); break;
    	}
    	
    SetCtrlVal (hPanel, SP_INFO_BRDTYPE, szBuffer);
    
    sprintf (szBuffer, "%05d", pstCardInfo->lSerialNumber);
    SetCtrlVal (hPanel, SP_INFO_SN, szBuffer);
    }

/*****************************************************************************/
/*	bDoDataCalculation                                                       */
/*****************************************************************************/

bool bDoDataCalculation (void* pvBuffer)
    {
    void* ppvChannelData[SPCM_MAX_AOCHANNEL];
    int lIdx;
	
	// allocate buffers for each channel
	for (lIdx=0; lIdx < g_stCardInfo.lMaxChannels; lIdx++)
   		{
      	ppvChannelData[lIdx] = malloc (g_stCardInfo.lBytesPerSample * (int32) g_stCardInfo.llSetMemsize);
     	if (!ppvChannelData[lIdx])
     		{
     		MessagePopup ("Driver Error", "Memory allocation error");
     		return false;
     		}
    	}
    	
	// calculate channel data
  	for (lIdx = 0; lIdx < g_stCardInfo.lMaxChannels; lIdx++)
  		bSpcMCalcSignal (&g_stCardInfo, ppvChannelData[lIdx], (uint32) g_stCardInfo.llSetMemsize, 0, g_stSettingsGUI.eShape, 10, 100);
  		
  	// mux it into the output buffer
  	bSpcMMuxData (&g_stCardInfo, pvBuffer, (uint32) g_stCardInfo.llSetMemsize, ppvChannelData);    

	// clean up channel buffers
  	for (lIdx = 0; lIdx < g_stCardInfo.lMaxChannels; lIdx++)
  		free (ppvChannelData[lIdx]);
  	
    return true;
    }

/*****************************************************************************/
/*	bSetupCard                                                               */
/*****************************************************************************/

bool bSetupCard ()
	{
	int64 llChannelMask, llMemInBytes;
	int32 lIdx;
	void* pvBuffer;
	char szBuffer[1024];
	
	llChannelMask = ((int64) 1 << g_stCardInfo.lMaxChannels) - 1;
	
	if (!bSpcMSetupModeRepStdLoops (&g_stCardInfo, llChannelMask, g_stSettingsGUI.llMemsize, 0))
		{
		MessagePopup ("Driver Error", g_stCardInfo.szError);
		return false;
		}
	
	if (!bSpcMSetupClockPLL (&g_stCardInfo, g_stSettingsGUI.llSamplerate, false))
		{
		MessagePopup ("Driver Error", g_stCardInfo.szError);
		return false;
		}
	
	if (!bSpcMSetupTrigSoftware (&g_stCardInfo, true))
		{
		MessagePopup ("Driver Error", g_stCardInfo.szError);
		return false;
		}
	
	// program all output channels to +/- 1 V with no offset
  	for (lIdx = 0; lIdx < g_stCardInfo.lMaxChannels; lIdx++)
  		{
    	if (!bSpcMSetupAnalogOutputChannel (&g_stCardInfo, lIdx, 1000, 0, 0, 0, false, false))
    		{
    		MessagePopup ("Driver Error", g_stCardInfo.szError);
    		return false;
    		}
    	
    	// enable output channel
    	spcm_dwSetParam_i32 (g_stCardInfo.hDrv, SPC_ENABLEOUT0 + lIdx * (SPC_ENABLEOUT1- SPC_ENABLEOUT0), 1);
		}
		
	llMemInBytes = g_stCardInfo.llSetMemsize * g_stCardInfo.lBytesPerSample * g_stCardInfo.lSetChannels;
	pvBuffer = malloc (llMemInBytes);
	if (!pvBuffer)
		{
		MessagePopup ("Driver Error", "Memory allocation error");
    	return false;
		}
		
	if (!bDoDataCalculation (pvBuffer))
		return false;
		
		
	spcm_dwDefTransfer_i64 (g_stCardInfo.hDrv, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, 0, pvBuffer, 0, llMemInBytes);
   
   	spcm_dwSetParam_i32 (g_stCardInfo.hDrv, SPC_M2CMD, M2CMD_DATA_STARTDMA | M2CMD_DATA_WAITDMA);	
		
	// check for error code
 	if (spcm_dwGetErrorInfo_i32 (g_stCardInfo.hDrv, NULL, NULL, szBuffer))
   		{
     	free (pvBuffer);
     	MessagePopup ("Driver Error", szBuffer);
      	return false;
      	}	
		
	free (pvBuffer);

 	return true;
	}

/*****************************************************************************/
/*	vStartCard                                                               */
/*****************************************************************************/
void vStartCard ()
	{
	g_stSettingsGUI.bRun = true;
	SetCtrlAttribute (g_hMain, PANEL_BUTTON_START, ATTR_LABEL_TEXT, "Stop");
	spcm_dwSetParam_i32 (g_stCardInfo.hDrv, SPC_M2CMD, M2CMD_CARD_START | M2CMD_CARD_ENABLETRIGGER);
	SetCtrlAttribute (g_hMain, PANEL_LED, ATTR_ON_COLOR, VAL_GREEN);
	SetCtrlVal (g_hMain, PANEL_LED, 1);
	}
	
/*****************************************************************************/
/*	vStopCard                                                                */
/*****************************************************************************/
void vStopCard ()
	{
	spcm_dwSetParam_i32 (g_stCardInfo.hDrv, SPC_M2CMD, M2CMD_CARD_STOP);
	SetCtrlAttribute (g_hMain, PANEL_BUTTON_START, ATTR_LABEL_TEXT, "Start");
	g_stSettingsGUI.bRun = false;
	SetCtrlVal (g_hMain, PANEL_LED, 0);
	}

/*****************************************************************************/
/*	vUpdateSettings                                                          */
/*****************************************************************************/
void vUpdateSettings ()
	{
	unsigned int dwValue;
	bool bVal = true;

	GetCtrlVal (g_hMain, PANEL_NUMERIC_SRATE, &dwValue);
	g_stSettingsGUI.llSamplerate = 1000000 * dwValue;
	
	GetCtrlVal (g_hMain, PANEL_NUMERIC_MEMSIZE, &dwValue);
	g_stSettingsGUI.llMemsize = dwValue;
	}

/*****************************************************************************/
/*	CVICALLBACK : lCallBackGuiSettingsChanged                                */
/*****************************************************************************/

int CVICALLBACK lCallBackGuiSettingsChanged (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
	{
	unsigned int dwValue;
	
	switch (event)
		{
		case EVENT_COMMIT:
			
			switch (control)
				{
				case PANEL_BUTTON_SINE:
					SetCtrlVal (panel, PANEL_BUTTON_SINE, 1);
					SetCtrlVal (panel, PANEL_BUTTON_RECT, 0);
					SetCtrlVal (panel, PANEL_BUTTON_TRI,  0);
					g_stSettingsGUI.eShape = eSine;
					break;
					
				case PANEL_BUTTON_RECT:
					SetCtrlVal (panel, PANEL_BUTTON_SINE, 0);
					SetCtrlVal (panel, PANEL_BUTTON_RECT, 1);
					SetCtrlVal (panel, PANEL_BUTTON_TRI,  0);
					g_stSettingsGUI.eShape = eRectangle;
					break;
					
				case PANEL_BUTTON_TRI:
					SetCtrlVal (panel, PANEL_BUTTON_SINE, 0);
					SetCtrlVal (panel, PANEL_BUTTON_RECT, 0);
					SetCtrlVal (panel, PANEL_BUTTON_TRI,  1);
					g_stSettingsGUI.eShape = eTriangle;
					break;
				}
		
			if (g_stSettingsGUI.bRun)
				{
				vStopCard ();
				SetCtrlAttribute (g_hMain, PANEL_LED, ATTR_ON_COLOR, VAL_YELLOW);
				SetCtrlVal (g_hMain, PANEL_LED, 1);
				vUpdateSettings ();
				if (bSetupCard ())
					vStartCard ();
				else
					SetCtrlVal (g_hMain, PANEL_LED, 0);
				}
			break;
		}
	
	return 0;
	}

/*****************************************************************************/
/*	CVICALLBACK : lCallBackStartButton                                       */
/*****************************************************************************/

int CVICALLBACK lCallbackStartButton (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
	{
	switch (event)
		{
		case EVENT_COMMIT:
			if (g_stSettingsGUI.bRun)
				vStopCard ();
			else
				{
				vUpdateSettings ();
				if (bSetupCard ())
					vStartCard ();
				}
			break;
		}
	return 0;
	}

/*****************************************************************************/
/*	CVICALLBACK : lCallBackQuitButton                                        */
/*****************************************************************************/

int CVICALLBACK lCallbackQuitButton (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
	{
	switch (event)
		{
		case EVENT_COMMIT:
			vSpcMCloseCard (&g_stCardInfo);
			QuitUserInterface (0);
			break;
		}
		
	return 0;
	}

