//********************************************************************************************************************** 
//*****																											   *****
//*****   	 			LabWindows / CVI Function Generator for MI_MC_MX 60xx or MI_MC_MX 61xx					   *****
//*****																											   *****	
//**********************************************************************************************************************
//*****																											   *****
//***** (c) Spectrum Instrumentation 01/2005 *****												
//*****     Ahrensfelder Weg 13-17																				   *****	
//*****		22927 Grosshansdorf																					   *****	
//*****		Phone:    +49 (0)4102/6956-0																		   *****
//*****		Fax:      +49 (0)4102/6956-66																		   *****
//*****		internet: https://www.spectrum-instrumentation.com																		   *****
//*****		email:    info@spec.de																				   *****
//*****																											   *****
//**********************************************************************************************************************
//*****																											   *****
//*****  Filename 	 : funcGenerator.c     																		   *****	
//*****																											   *****	    
//*****  Description : This module contains the main function, that causes the initialization of the board and 	   *****
//*****		           the GUI. Additionally this module contains all functions and callbacks, to control the GUI. *****
//*****																											   *****
//**********************************************************************************************************************


#include <ansi_c.h>
#include <cvirte.h>		
#include <userint.h>
#include "funcGenerator.h"
#include "boardControl.h"
#include "prototypes.h"
#include "toolbox.h"     

static int panelHandle, brd_selectHandle;

static struct _GUI_SETTINGS stGuiSettings;
static struct _ERRORCODE stErrorCode;
static int    lHandleIndex = -1;

//**********************************************************************************************************************
//*****																										   	   *****
//*****												Main function								   	   			   *****
//*****																										       *****
//**********************************************************************************************************************

int main (int argc, char *argv[])
{
	struct _BOARD_INFO stBoardInfo;
	int lReturnCode;
	int lStatus;
	int hDrv;
	HINSTANCE hDLL;
	
	// ----- load panels -----
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	if ((panelHandle = LoadPanel (0, "funcGenerator.uir", PANEL)) < 0)
		return -1;
	if ((brd_selectHandle = LoadPanel (0, "funcGenerator.uir", BRD_SELECT)) < 0)
		return -1;
	
	// ----- load driver from dll -----
	hDLL = lLoadSpectrumDrv (&lStatus);
	
	if (lStatus < 0) 
	{
		switch (lStatus)
		{
			case -1 : MessagePopup ("SPEasyGenerator","spectrum.dll or spectrum_comp.dll not found");
					  break;
					  
			case -2 : MessagePopup ("SPEasyGenerator","Unable to load functions from dll"); 
					  break;
		}
		
		return 0;
	}
	// ----- get handle of MI60xx or MI61xx -----
	lReturnCode = lGetBoardHandle(&hDrv);
	
	switch (lReturnCode)
	{
		case 0 : // ----- no 60xx or 61xx board found -----
				 MessagePopup ("Generator board not found", "There is no 60xx or 61xx board installed.");		
				 break;
				 
		case 1 : // ----- 60xx or 61xx board found -----
				 stBoardInfo = stInitBoard(hDrv);
				 vInitGui(stBoardInfo);
				 
				 stErrorCode = stControlBoard (SET_INIT_SETUP, &stGuiSettings);
				 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				 
				 vDisplayFrequency ();
				 vDisplayUsedSettings ();
				 DisplayPanel (panelHandle);
				 RunUserInterface ();
				 break;
	}
	
	DiscardPanel (panelHandle);
	DiscardPanel (brd_selectHandle);
	
	// ----- free driver dll -----
	vFreeSpectrumDrv (hDLL);
	
	return 0;
}

//**********************************************************************************************************************
//***** FunctionCall : vDisplayFrequency ()																		   *****
//*****																					   	   			           *****
//***** ReturnCode   : - 																						   *****
//*****																											   *****	
//***** Description  : This function displays the current frequency of all channels.						   	   *****
//**********************************************************************************************************************

void vDisplayFrequency ()
{
	char szIndicator[20];   
	int lState;
	int lChannel;
	
	switch(stGuiSettings.lBoardStatus)
	{
		case START :	
				// ----- board running -----
		
				// ----- display frequencies of all channels -----
				for (lChannel=0;lChannel<stGuiSettings.lChannels;lChannel++)                   
				{	
					if (stGuiSettings.lSwitchCh[lChannel])
					{	
			 		   if (stGuiSettings.dDisplayFreqCh[lChannel] < 1000)
			 		   		sprintf(szIndicator, "%0.2f Hz", stGuiSettings.dDisplayFreqCh[lChannel]);
			 		   else 
			 		   {
			 		   	    GetCtrlVal (panelHandle, PANEL_MENU_FREQ, &lState);
			 		   
			 		   		if ((stGuiSettings.dDisplayFreqCh[lChannel] >= 1000000) && (lState == 7))
			 		   			sprintf(szIndicator, "%0.2f MHz", stGuiSettings.dDisplayFreqCh[lChannel] / 1000000);
			 				else
			 					sprintf(szIndicator, "%0.2f KHz", stGuiSettings.dDisplayFreqCh[lChannel] / 1000);
			 		   }
			 		   
			 		   SetCtrlVal (panelHandle, PANEL_INDICATOR_FREQ_CH0 + lChannel * DELTA_CHANNEL_COMPONENTS, szIndicator);
					}
					else 
					   SetCtrlVal (panelHandle, PANEL_INDICATOR_FREQ_CH0 + lChannel * DELTA_CHANNEL_COMPONENTS, "     ------------"); 
				}
				
				break;
				
		case STOP : 
		
				// ----- board stopped -----
				for (lChannel=0;lChannel<stGuiSettings.lChannels;lChannel++)
					SetCtrlVal (panelHandle, PANEL_INDICATOR_FREQ_CH0 + lChannel * DELTA_CHANNEL_COMPONENTS, "     ------------"); 
					
				break;
				
 	}				
				
}

//**********************************************************************************************************************
//***** FunctionCall : vDisplayUsedSettings ()																	   *****
//*****																					   	   			           *****
//***** ReturnCode   : - 																						   *****
//*****																											   *****	
//***** Description  : This function displays the samplerate and memsize, that is used by the board.               *****
//**********************************************************************************************************************
 
void vDisplayUsedSettings ()
{
	char szTmpBuf[100];
	
	// ----- display used memsize -----
	sprintf (szTmpBuf, "%d Samples", stGuiSettings.lUsedMemsize);
	SetCtrlVal (panelHandle, PANEL_INDICATOR_USED_MEM, szTmpBuf);

	// ----- display used samplerate -----
	sprintf (szTmpBuf, "%d Samples/s", stGuiSettings.lUsedSamplerate);
	SetCtrlVal (panelHandle, PANEL_INDICATOR_USED_SRATE, szTmpBuf);     
} 

//**********************************************************************************************************************
//***** FunctionCall : vDisplayDrvError ()																		   *****
//*****																											   *****
//***** ReturnCode   : -																						   *****
//*****																											   *****
//***** Description  : This function displays the error code, the register that causes the error and the value	   *****
//*****				   that has been written to the faulty register.											   *****
//**********************************************************************************************************************

void vDisplayDrvError ()
{
	char szErrorText[100];
	
	sprintf (szErrorText, "Driver error: %ld in register %ld at value %ld", stErrorCode.lErrorCode, 
			 stErrorCode.lErrorReg, stErrorCode.lErrorValue); 
			 
	MessagePopup ("Driver Error", szErrorText);		
}

//**********************************************************************************************************************
//***** FunctionCall : lGetBoardHandle (&hDrv) 														 			   *****
//*****																											   *****
//*****	ReturnCode   : 0 : board not found 																	       *****
//*****				   1 : board found 																		       *****
//*****																											   *****
//***** Description	 : This function seeks for a MI60xx or MI61xx board and writes the handle to the refered	   *****
//*****				   address of hDrv.																			   *****
//**********************************************************************************************************************

int lGetBoardHandle (int *hDrv)
{
	int lBrdType[MAX_BRDS];
	int lSN[MAX_BRDS];
	int lDrv[MAX_BRDS];
	int lBrdCount;
	char szTmp[100];   
	int i;
	
	// ----- seek for spectrum boards and store information of all founded MI60xx and MI61xx boards -----
	lBrdCount = lSearch4Boards (lBrdType, lSN, lDrv);  
	
	switch (lBrdCount)
	{
		case 0  : // ----- no 60xx or 61xx board found -----
				  return 0;
				
				  break;
				  
		case 1  : // ----- one board found ----- 
				  *hDrv = lDrv[0]; 
				  return 1;
		
				  break;
				  
		default : // ----- more than one board found -----
		
				  // ----- display all founded MI60xx and MI61xx boards, user has to select the board to use -----
				  DisplayPanel (brd_selectHandle); 
				  for(i=0;i<lBrdCount;i++)
				  {
				  	sprintf(szTmp, "MI%X                SN:%05ld", lBrdType[i], lSN[i]);
				 	InsertListItem (brd_selectHandle, BRD_SELECT_BOARDLIST, -1, szTmp,0); 	 
				  }
				  
				  // ----- poll until board is selected -----
				  while (lHandleIndex == -1)
				  {
				  	ProcessSystemEvents();
				  }
				  
				  *hDrv = lDrv[lHandleIndex];
				  HidePanel (brd_selectHandle);
				  
				  return 1;
				  
				  break;
	}
	
	return 0;
}		

//**********************************************************************************************************************
//***** FunctionCall : vInitGui (stBoardInfo) 														 			   *****
//*****																											   *****
//*****	ReturnCode   : - 																	   					   *****
//*****																											   *****
//***** Description  : This function loads the last GUI setup from a file and fills the struct stGuiSettings	   *****
//*****				   with the last settings.																	   *****
//********************************************************************************************************************** 
 
void vInitGui(struct _BOARD_INFO stBoardInfo)
{
	char szIndicator[16];
	int lState;
	int lValAmplitude, lValOffset, lValPhase, lValDivider;
	int lValue;
	int lCtrlIdStart;
	int lCtrlIdEnd;
	int lCtrlId;
	int lSetWaveform = 0;
	int lChannel = 0;
	int lPanelButtonId = 2;
    int lDeltaComponent;
    int lSelectBusType;
    double dValue;
    
   
    // ----- Load Panel Settings -----
    RecallPanelState (panelHandle, "SPEasyGenerator.gss", PANEL); 
    
    // ----- Hide not supported channels -----  
    for (lChannel = 3; lChannel >= stBoardInfo.lMaxChannels; lChannel--)
    	vChHide(lChannel);
	
	
	// ----- get values from GUI components and fill struct stGuiSettings -----	
	
	// ----- check if channel is enabled -----
    for (lChannel = 0; lChannel < stBoardInfo.lMaxChannels; lChannel++)
    {
		GetCtrlVal (panelHandle, PANEL_BUTTON_ENABLED_CH0 + lChannel, &lState);
		
		// ----- dim components when init state of channel is disable -----
		vChDimmed (!lState, lChannel);
		stGuiSettings.lSwitchCh[lChannel] = lState;
	}
	
	// ----- set board to running mode -----
	SetCtrlVal (panelHandle, PANEL_BUTTON_BOARD_STOP, START);
	stGuiSettings.lBoardStatus = START;
	
	// ----- write init waveform for all channels to struct -----
	lChannel = 0;
	lCtrlIdStart = PANEL_LED_SINE_CH0;
	lCtrlIdEnd   = PANEL_LED_TRIANGLE_CH3;
	
	for (lCtrlId = lCtrlIdStart; lCtrlId <= lCtrlIdEnd; lCtrlId++)
	{
		GetCtrlVal (panelHandle, lCtrlId, &lState);	
		
		switch (lState)
		{	
			case ON  :  stGuiSettings.lWaveformCh[lChannel] = lSetWaveform + 1;
						SetCtrlVal (panelHandle, lPanelButtonId, SET);
						break;
		
			case OFF :  SetCtrlVal (panelHandle, lPanelButtonId, RESET);
						
						break;
		}
		
		lSetWaveform++;
		lSetWaveform %= 3;
		
		if (lSetWaveform == 0)
		{
			  lChannel++;
			  lPanelButtonId += 7;
		}
		else lPanelButtonId++;
	}
	
	// ----- write init amplitude, offset, phase and divider for all channels to struct -----
	lDeltaComponent = 0;
	for (lChannel = 0; lChannel < stBoardInfo.lMaxChannels; lChannel++)
	{
		GetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH0 + lDeltaComponent, &lValAmplitude);
		GetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH0    + lDeltaComponent, &lValOffset);
		GetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH0	  + lDeltaComponent, &lValPhase);
		GetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH0   + lDeltaComponent, &lValDivider);
		
		stGuiSettings.lAmplitudeCh[lChannel] = lValAmplitude;
		stGuiSettings.lOffsetCh[lChannel]    = lValOffset;
		stGuiSettings.lPhaseCh[lChannel]	 = lValPhase;
		
		switch (lValDivider)
		{
			case _1	  	: stGuiSettings.lDividerCh[lChannel] = 1;
					  	  break;
					  
		    case _1DIV2	: stGuiSettings.lDividerCh[lChannel] = 2;
		    			  break;
		    
		    case _1DIV4 : stGuiSettings.lDividerCh[lChannel] = 4;
		    			  break;
		    			  
		    case _1DIV8 : stGuiSettings.lDividerCh[lChannel] = 8;
		    			  break;
		}
		
		lDeltaComponent += DELTA_CHANNEL_COMPONENTS;
		
		GetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH0 + lChannel, &lState);
		stGuiSettings.lFilterCh[lChannel] = lState;
	}
	
	stGuiSettings.lChannels = stBoardInfo.lMaxChannels;   

	// ----- hide info indicator fields -----
	SetCtrlVal (panelHandle, PANEL_BUTTON_INFO, OFF); 
	SetCtrlAttribute (panelHandle, PANEL_INDICATOR_USED_MEM,  ATTR_VISIBLE,  OFF);
	SetCtrlAttribute (panelHandle, PANEL_INDICATOR_USED_SRATE, ATTR_VISIBLE, OFF);
	
	// ----- write frequency to struct -----
	GetCtrlVal (panelHandle, PANEL_DIAL_FREQ, &dValue);
	GetCtrlVal (panelHandle, PANEL_MENU_FREQ, &lState);
	stGuiSettings.dFrequency = dValue * pow(10, lState - 1);;
	
	// ----- write max frequency to struct -----
	stGuiSettings.dMaxFrequency = stBoardInfo.lMaxFrequency;
	
	
	// ----- display board information -----
		
	// ------ higher 16 bit of lBoardType is bus type -----
	lSelectBusType = stBoardInfo.lBoardType >> 16;
	
	switch (lSelectBusType)
	{
		case 0 : // ----- MI Board -----
					sprintf (szIndicator, "MI.%x", stBoardInfo.lBoardType & 0xffff);
					break;
					
		case 1 : // ----- MC Board -----
				    sprintf (szIndicator, "MC.%x", stBoardInfo.lBoardType & 0xffff);
				    break;
				    
		case 2 : // ----- MX Board -----
					sprintf (szIndicator, "MX.%x", stBoardInfo.lBoardType & 0xffff);
					break;
	}
	
	// ----- activate tool tips for the components -----
	vActivateToolTips ();
	
	// ----- call function to init the static state variable of this component -----
	lSetUnit (panelHandle, PANEL_MENU_FREQ, EVENT_COMMIT, NULL, 0, 0);
		
	SetCtrlVal (panelHandle, PANEL_INDICATOR_BOARDTYPE, szIndicator);
	
	sprintf (szIndicator, "%05d", stBoardInfo.lSerialNumber);
	SetCtrlVal (panelHandle, PANEL_INDICATOR_SERIALNR, szIndicator);
	
	sprintf (szIndicator, "%d MS/s", stBoardInfo.lMaxSamplerate / 1000 / 1000);
	SetCtrlVal (panelHandle, PANEL_INDICATOR_MAX_SRATE, szIndicator);
	
	sprintf (szIndicator, "%d MByte", stBoardInfo.lMaxMemsize / 1024 / 1024);
	SetCtrlVal (panelHandle, PANEL_INDICATOR_MAX_MEMSIZE, szIndicator);
	
}

//**********************************************************************************************************************
//***** FunctionCall : vActivateToolTips ()																		   *****
//*****												  								   	   			       		   *****
//*****	ReturnCode   : -																						   *****
//*****																											   *****
//***** Description  : This function activates the tool tips for the GUI components.                               *****
//**********************************************************************************************************************

void vActivateToolTips ()
{
	char szText[256];
	int i;
	
	// ----- set tool tips for amplitude knobs -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Amplitude Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_KNOB_AMPLITUDE_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for offset knobs -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Offset Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_KNOB_OFFSET_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}	
	
	// ----- set tool tips for phase knobs -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Phase Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_KNOB_PHASE_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for sine buttons -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Waveform Ch%d: Sine", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_SINE_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for rectangle buttons -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Waveform Ch%d: Rectangle", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_RECTANGLE_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for triangle buttons -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Waveform Ch%d: Triangle", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_TRIANGLE_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for divider menues -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Frequency Divider of Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_MENU_DIVIDER_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for filter menues -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Set Filter of Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_MENU_FILTER_CH0 + i, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}			
			
	// ----- set tool tips for frequency displays -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Current Frequency of Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_INDICATOR_FREQ_CH0 + i*DELTA_CHANNEL_COMPONENTS, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tips for channel enable buttons -----
	for (i=0;i<4;i++)
	{
		sprintf (szText, "Disable Channel %d", i);
		SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH0 + i, CTRL_TOOLTIP_ATTR_TEXT, szText);
	}
	
	// ----- set tool tip for info button -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_INFO, CTRL_TOOLTIP_ATTR_TEXT, "Show Board Settings");
	
	// ----- set tool tip for frequency dialer -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_DIAL_FREQ, CTRL_TOOLTIP_ATTR_TEXT, "Set Frequency for all Channels");
	
	// ----- set tool tip for frequency menu -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_MENU_FREQ, CTRL_TOOLTIP_ATTR_TEXT, "Set Frequency Multiplier");	
	
	// ----- set tool tip for status led -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_LED_STATUS, CTRL_TOOLTIP_ATTR_TEXT, "Green  : Board running\nRed     : Board stopped\nYellow : Calculating");
	
	// ----- set tool tip for reset button -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_RESET, CTRL_TOOLTIP_ATTR_TEXT, "Set to Default Setting");
	
	// ----- set tool tip for stop button -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_BOARD_STOP, CTRL_TOOLTIP_ATTR_TEXT, "Stop board");
	
	// ----- set tool tip for Spectrum label -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_SPECTRUM, CTRL_TOOLTIP_ATTR_TEXT, "(c) Spectrum GmbH\nhttps://www.spectrum-instrumentation.com");
	
	// ----- set tool tip for used memsize display -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_INDICATOR_USED_MEM, CTRL_TOOLTIP_ATTR_TEXT, "This Memsize is written to the\nMemsize Register of the Board");
	
	// ----- set tool tip for used samplerate display -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_INDICATOR_USED_SRATE, CTRL_TOOLTIP_ATTR_TEXT, "This Samplerate is written to the\n Samplerate Register of the Board");
	
	// ----- set tool tip for max samplerate display -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_INDICATOR_MAX_SRATE, CTRL_TOOLTIP_ATTR_TEXT, "Max. available Samplerate, depending\non Max. Channels of the Board");

	// ----- set tool tip for max memsize display -----
	SetCtrlToolTipAttribute (panelHandle, PANEL_INDICATOR_MAX_MEMSIZE, CTRL_TOOLTIP_ATTR_TEXT, "Size of Installed On-Board Memory");
}

//**********************************************************************************************************************
//***** FunctionCall : vChHide (lChannel)																		   *****
//*****												  								   	   			       		   *****
//*****	ReturnCode   : -																						   *****
//*****																											   *****
//***** Description  : This function hides all GUI components of the refered channel.							   *****
//**********************************************************************************************************************

void vChHide (int lChannel)
{
	int lCtrlIdStart;
	int lCtrlIdEnd;
	int lCtrlId;
    int lDelta;
    
    switch (lChannel)
	{
		case CH0 :  // ----- set the ID큦 of the first and last component of channel0 -----
					lCtrlIdStart = PANEL_BUTTON_SINE_CH0;
				    lCtrlIdEnd   = PANEL_LED_CH0;
				    
				    for (lDelta = 0; lDelta < 3; lDelta++)
				    	SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH0 + lDelta, ATTR_VISIBLE, OFF);
				   	
				   	SetCtrlAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH0, ATTR_VISIBLE, OFF);
					SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH0, ATTR_VISIBLE, OFF);
					
				    break;
		
		case CH1 :	// ----- set the ID큦 of the first and last component of channel1 -----
					lCtrlIdStart = PANEL_BUTTON_SINE_CH1;
					lCtrlIdEnd   = PANEL_LED_CH1;
					
					for (lDelta = 0; lDelta < 3; lDelta++)
				    	SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH1 + lDelta, ATTR_VISIBLE, OFF);
					
					SetCtrlAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH1, ATTR_VISIBLE, OFF);
					SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH1, ATTR_VISIBLE, OFF);
					
					break;
		
		case CH2 :	// ----- set the ID큦 of the first and last component of channel2 -----
					lCtrlIdStart = PANEL_BUTTON_SINE_CH2;
					lCtrlIdEnd   = PANEL_LED_CH2;
					
					for (lDelta = 0; lDelta < 3; lDelta++)
				    	SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH2 + lDelta, ATTR_VISIBLE, OFF);
				    	
				    SetCtrlAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH2, ATTR_VISIBLE, OFF);
					SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH2, ATTR_VISIBLE, OFF);
					
					break;
		
		case CH3 :	// ----- set the ID큦 of the first and last component of channel3 -----
					lCtrlIdStart = PANEL_BUTTON_SINE_CH3;
					lCtrlIdEnd   = PANEL_LED_CH3;
					
					for (lDelta = 0; lDelta < 3; lDelta++)
				    	SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH3 + lDelta, ATTR_VISIBLE, OFF);
				    	
				    SetCtrlAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH3, ATTR_VISIBLE, OFF);	
				    SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH3, ATTR_VISIBLE, OFF);
					
					break;
					
	}
	
	// ----- hide all components between lCtrlIdStart and lCtrlIdEnd -----
	for (lCtrlId = lCtrlIdStart;lCtrlId <= lCtrlIdEnd;lCtrlId++)
		SetCtrlAttribute (panelHandle, lCtrlId, ATTR_VISIBLE, OFF); 
}

//**********************************************************************************************************************
//***** FunctionCall : vChDimmed (lState, lChannel)																   *****
//*****												  										   	   			       *****
//***** ReturnCode   : -																						   *****
//*****																											   *****
//***** Description  : If lState is set to SET, this function dims the components of the refered channel.		   *****
//*****				   If lState is set to RESET, the components of the refered channel lights up.			       *****
//**********************************************************************************************************************

void vChDimmed (int lState, int lChannel)
{
	int lCtrlIdStart;
	int lCtrlIdEnd;
	int lCtrlId;
    
    switch (lChannel)
	{
		case CH0 :  // ----- set the ID큦 of the first and last component of channel0 ----- 
					lCtrlIdStart = PANEL_BUTTON_SINE_CH0;
				    lCtrlIdEnd   = PANEL_MENU_DIVIDER_CH0;
				    
				    break;
		
		case CH1 :	// ----- set the ID큦 of the first and last component of channel1 ----- 
					lCtrlIdStart = PANEL_BUTTON_SINE_CH1;
					lCtrlIdEnd   = PANEL_MENU_DIVIDER_CH1;
					
					break;
		
		case CH2 :	// ----- set the ID큦 of the first and last component of channel2 ----- 
					lCtrlIdStart = PANEL_BUTTON_SINE_CH2;
					lCtrlIdEnd   = PANEL_MENU_DIVIDER_CH2;
					
					break;
		
		case CH3 :	// ----- set the ID큦 of the first and last component of channel3 ----- 
					lCtrlIdStart = PANEL_BUTTON_SINE_CH3;
					lCtrlIdEnd   = PANEL_MENU_DIVIDER_CH3;
					
					break;
					
	}

	switch (lState)
	{
		case SET 	: // ----- dim components of lChannel -----
					  for (lCtrlId = lCtrlIdStart;lCtrlId <= lCtrlIdEnd;lCtrlId++)
					 	SetCtrlAttribute (panelHandle, lCtrlId, ATTR_DIMMED, SET); 
					  SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH0 + lChannel, ATTR_DIMMED, SET);
					  
					  break;
				 	  
		case RESET  : // ----- light up components of lChannel -----
					  for (lCtrlId = lCtrlIdStart;lCtrlId <= lCtrlIdEnd;lCtrlId++)
					 	SetCtrlAttribute (panelHandle, lCtrlId, ATTR_DIMMED, RESET); 
					  SetCtrlAttribute (panelHandle, PANEL_MENU_FILTER_CH0 + lChannel, ATTR_DIMMED, RESET);	
					  
				      break;
	}

}

//**********************************************************************************************************************
//*****																										   	   *****
//*****											 	 CVICALLBACKS			  								       *****
//*****																										       *****
//**********************************************************************************************************************


//**********************************************************************************************************************
//*****										 CVICALLBACK lQuitProgram 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lQuitProgram (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		case EVENT_COMMIT:
		
			// ----- save user settings of the GUI to file -----
			SavePanelState (panelHandle, "SPEasyGenerator.gss", PANEL);

			// ----- stop board -----
			stErrorCode = stControlBoard (STOP_BOARD, &stGuiSettings);
			if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
			
			QuitUserInterface (0);
			break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lCh0Enable 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lCh0Enable (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_BUTTON_ENABLED_CH0, &lState);

			switch (lState)
			{
				case 0 : // ----- channel disable -----
						 vChDimmed (SET, CH0);
						 SetCtrlVal (panelHandle, PANEL_LED_CH0, OFF);
						 
						 stGuiSettings.lSwitchCh[0] = OFF;
						 
						 stErrorCode = stControlBoard (SET_CH0_OFF, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH0, CTRL_TOOLTIP_ATTR_TEXT, "Enable Channel 0");
						 
						 break;
						 
				case 1 : // channel enable -----
						 vChDimmed (RESET, CH0);
						 SetCtrlVal (panelHandle, PANEL_LED_CH0, ON);
						 stGuiSettings.lSwitchCh[0] = ON;
						 
						 stErrorCode = stControlBoard (SET_CH0_ON, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH0, CTRL_TOOLTIP_ATTR_TEXT, "Disable Channel 0");
						 
						 break;
			}
			
			SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH0, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_RECTANGLE_CH0, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_TRIANGLE_CH0, ATTR_DIMMED, !lState); 
			
			vDisplayFrequency();
			
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lCh1Enable 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lCh1Enable (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_BUTTON_ENABLED_CH1, &lState);

			switch (lState)
			{
				case 0 : // ----- channel disable -----
						 vChDimmed (SET, CH1);
						 SetCtrlVal (panelHandle, PANEL_LED_CH1, OFF);
						 stGuiSettings.lSwitchCh[1] = OFF;
						 
						 stErrorCode = stControlBoard (SET_CH1_OFF, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH1, CTRL_TOOLTIP_ATTR_TEXT, "Enable Channel 1");
						 
						 break;
						 
				case 1 : // ----- channel enable -----
						 vChDimmed (RESET, CH1);
						 SetCtrlVal (panelHandle, PANEL_LED_CH1, ON);
						 stGuiSettings.lSwitchCh[1] = ON;
						 
						 stErrorCode = stControlBoard (SET_CH1_ON, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH1, CTRL_TOOLTIP_ATTR_TEXT, "Disable Channel 1");
						 
						 break;
			}
			
			SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH1, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_RECTANGLE_CH1, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_TRIANGLE_CH1, ATTR_DIMMED, !lState); 
			
			vDisplayFrequency();
			
			break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lCh2Enable 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lCh2Enable (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;

	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_BUTTON_ENABLED_CH2, &lState);

			switch (lState)
			{
				case 0 : // ----- channel disable -----
						 vChDimmed (SET, CH2);
						 SetCtrlVal (panelHandle, PANEL_LED_CH2, OFF);
						 stGuiSettings.lSwitchCh[2] = OFF;
						 
						 stErrorCode = stControlBoard (SET_CH2_OFF, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH2, CTRL_TOOLTIP_ATTR_TEXT, "Enable Channel 2");
						 
						 break;
						 
				case 1 : // ----- channel enable -----
						 vChDimmed (RESET, CH2);
						 SetCtrlVal (panelHandle, PANEL_LED_CH2, ON);
						 stGuiSettings.lSwitchCh[2] = ON;
						 
						 stErrorCode = stControlBoard (SET_CH2_ON, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH2, CTRL_TOOLTIP_ATTR_TEXT, "Disable Channel 2");
						 
						 break;
			}
			
			SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH2, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_RECTANGLE_CH2, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_TRIANGLE_CH2, ATTR_DIMMED, !lState); 
			
			vDisplayFrequency();
			
			break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lCh3Enable 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lCh3Enable (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;

	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_BUTTON_ENABLED_CH3, &lState);

			switch (lState)
			{
				case 0 : // ----- channel disable -----
						 vChDimmed (SET, CH3);
						 SetCtrlVal (panelHandle, PANEL_LED_CH3, OFF);
						 stGuiSettings.lSwitchCh[3] = OFF;
						 
						 stErrorCode = stControlBoard (SET_CH3_OFF, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH3, CTRL_TOOLTIP_ATTR_TEXT, "Enable Channel 3");
						 
						 break;
						 
				case 1 : // ----- channel enable -----
						 vChDimmed (RESET, CH3);
						 SetCtrlVal (panelHandle, PANEL_LED_CH3, ON);
						 stGuiSettings.lSwitchCh[3] = ON;						 
						 						 
						 stErrorCode = stControlBoard (SET_CH3_ON, &stGuiSettings);   
						 if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
						 
						 SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_ENABLED_CH3, CTRL_TOOLTIP_ATTR_TEXT, "Disable Channel 3");
						 
						 break;
			}
			
			SetCtrlAttribute (panelHandle, PANEL_LED_SINE_CH3, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_RECTANGLE_CH3, ATTR_DIMMED, !lState); 
			SetCtrlAttribute (panelHandle, PANEL_LED_TRIANGLE_CH3, ATTR_DIMMED, !lState); 
			
			vDisplayFrequency(); 
			
			break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetSineCh0 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetSineCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		 
		    // ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH0,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH0,       OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH0, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH0,	   OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH0,        SET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH0,		    ON);
			
			stGuiSettings.lWaveformCh[0] = SINE;		
			
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH0, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
			
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetRectangleCh0 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetRectangleCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
	
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH0, 	RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH0,		  OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH0, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH0,	  OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH0,  SET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH0,      ON);
			
			stGuiSettings.lWaveformCh[0] = RECTANGLE;
			
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH0, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
			
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetTriangleCh0 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetTriangleCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH0,		 RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH0,		   OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH0, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH0,	   OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH0,    SET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH0,	    ON);
			
			stGuiSettings.lWaveformCh[0] = TRIANGLE;
			
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH0, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
			
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetAmplitudeCh0 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetAmplitudeCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;
	
	switch (event)
		{
		
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH0, &lValue);
				stGuiSettings.lAmplitudeCh[0] = lValue;
				
				stErrorCode = stControlBoard (SET_AMPLITUDE_CH0, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetOffsetCh0 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetOffsetCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH0, &lValue);
				stGuiSettings.lOffsetCh[0] = lValue;
				
				stErrorCode = stControlBoard (SET_OFFSET_CH0, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetPhaseCh0 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetPhaseCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_KEYPRESS:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_VAL_CHANGED:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH0, &lValue);
				stGuiSettings.lPhaseCh[0] = lValue;
				
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_PHASE_CH0, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
				}
				
				break;

		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetDividerCh0 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetDividerCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	int lLedColor;
	
	switch (event)
		{
		
		case EVENT_LEFT_CLICK : 
		
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_LOST_FOCUS:		
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
				
				break;
				
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH0, &lState);
				
				// ----- write multiplier for the waveform period to struct -----
				switch (lState)
				{
				
					case _1		: stGuiSettings.lDividerCh[0] = 1;
								  break;
					
					case _1DIV2 : stGuiSettings.lDividerCh[0] = 2;
								  break;
					
					case _1DIV4 : stGuiSettings.lDividerCh[0] = 4;
								  break;
					
					case _1DIV8 : stGuiSettings.lDividerCh[0] = 8;
								  break;
				}
		
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_DIVIDER_CH0, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
					vDisplayFrequency();
				}
				
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetSineCh1 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetSineCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH1,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH1,       OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH1, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH1,	   OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH1,        SET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH1,		    ON);
			
			stGuiSettings.lWaveformCh[1] = SINE;	
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH1, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetRectangleCh1 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetRectangleCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons ----- 
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH1,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH1,		   OFF);
			
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH1,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH1,	   OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH1,   SET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH1,	    ON);
				
			stGuiSettings.lWaveformCh[1] = RECTANGLE;
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH1, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetTriangleCh1 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetTriangleCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH1,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH1,		   OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH1, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH1,	   OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH1,    SET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH1,	    ON);
				
			stGuiSettings.lWaveformCh[1] = TRIANGLE;
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH1, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetAmplitudeCh1 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetAmplitudeCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;
	
	switch (event)
		{
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH1, &lValue);
				stGuiSettings.lAmplitudeCh[1] = lValue;
				
				stErrorCode = stControlBoard (SET_AMPLITUDE_CH1, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetOffsetCh1 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetOffsetCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH1, &lValue);
				stGuiSettings.lOffsetCh[1] = lValue;
				
				stErrorCode = stControlBoard (SET_OFFSET_CH1, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetPhaseCh1 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetPhaseCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_KEYPRESS:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_VAL_CHANGED:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH1, &lValue);
				stGuiSettings.lPhaseCh[1] = lValue;
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_PHASE_CH1, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
				}
				
				break;

		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetDividerCh1 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetDividerCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		
		case EVENT_LEFT_CLICK : 
		
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_LOST_FOCUS:		
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
				
				break;
		
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH1, &lState);
				
				// ----- write multiplier for the waveform period to struct -----
				switch (lState)
				{
				
					case _1		: stGuiSettings.lDividerCh[1] = 1;
								  break;
					
					case _1DIV2 : stGuiSettings.lDividerCh[1] = 2;
								  break;
					
					case _1DIV4 : stGuiSettings.lDividerCh[1] = 4;
								  break;
					
					case _1DIV8 : stGuiSettings.lDividerCh[1] = 8;
								  break;
				}
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_DIVIDER_CH1, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
					vDisplayFrequency();
				}	
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetSineCh2 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetSineCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH2, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH2,      OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH2,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH2,       OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH2,        SET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH2,            ON);
				
			stGuiSettings.lWaveformCh[2] = SINE;		
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH2, &stGuiSettings);	
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetRectangleCh2 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetRectangleCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH2,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH2,           OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH2,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH2,       OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH2,   SET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH2,       ON);
				
			stGuiSettings.lWaveformCh[2] = RECTANGLE;
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH2, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetTriangleCh2 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetTriangleCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH2,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH2,           OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH2, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH2,      OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH2,    SET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH2,        ON);
				
				
			stGuiSettings.lWaveformCh[2] = TRIANGLE;		
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH2, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetAmplitudeCh2 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetAmplitudeCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH2, &lValue);
				stGuiSettings.lAmplitudeCh[2] = lValue;
				
				stErrorCode = stControlBoard (SET_AMPLITUDE_CH2, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetOffsetCh2 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetOffsetCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH2, &lValue);
				stGuiSettings.lOffsetCh[2] = lValue;
				
				stErrorCode = stControlBoard (SET_OFFSET_CH2, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetPhaseCh2 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetPhaseCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_KEYPRESS:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_VAL_CHANGED:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_COMMIT:
				
				GetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH2, &lValue);
				stGuiSettings.lPhaseCh[2] = lValue;
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_PHASE_CH2, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
				}
				
				break;

		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetDividerCh2 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetDividerCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		
		case EVENT_LEFT_CLICK : 
		
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_LOST_FOCUS:		
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
				
				break;
		
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH2, &lState);
				
				// ----- write multiplier for the waveform period to struct -----
				switch (lState)
				{
				
					case _1		: stGuiSettings.lDividerCh[2] = 1;
								  break;
					
					case _1DIV2 : stGuiSettings.lDividerCh[2] = 2;
								  break;
					
					case _1DIV4 : stGuiSettings.lDividerCh[2] = 4;
								  break;
					
					case _1DIV8 : stGuiSettings.lDividerCh[2] = 8;
								  break;
				}
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_DIVIDER_CH2, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
					vDisplayFrequency();
				}
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetSineCh3 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetSineCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH3, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH3,      OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH3,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH3,       OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH3,        SET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH3,            ON);
				
			stGuiSettings.lWaveformCh[3] = SINE;		
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH3, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetRectangleCh3 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetRectangleCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
		    // ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH3,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH3,           OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH3,  RESET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH3,       OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH3,   SET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH3,       ON);
				
			stGuiSettings.lWaveformCh[3] = RECTANGLE;		
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH3, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetTriangleCh3 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetTriangleCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
			
		case EVENT_COMMIT:
		
			// ----- toggle waveform buttons -----
			SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH3,      RESET);
			SetCtrlVal (panelHandle, PANEL_LED_SINE_CH3,           OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH3, RESET);
			SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH3,      OFF);
				
			SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH3,    SET);
			SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH3,        ON);
				
			stGuiSettings.lWaveformCh[3] = TRIANGLE;		
				
			// ----- check if board is in running mode -----
			if (stGuiSettings.lBoardStatus)
			{
				stErrorCode = stControlBoard (SET_WAVEFORM_CH3, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
			}
				
			break;
	
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetAmplitudeCh3 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetAmplitudeCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH3, &lValue);
				stGuiSettings.lAmplitudeCh[3] = lValue;
				
				stErrorCode = stControlBoard (SET_AMPLITUDE_CH3, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetOffsetCh3 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetOffsetCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		case EVENT_VAL_CHANGED:
				GetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH3, &lValue);
				stGuiSettings.lOffsetCh[3] = lValue;
				
				stErrorCode = stControlBoard (SET_OFFSET_CH3, &stGuiSettings);
				if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetPhaseCh3 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetPhaseCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lValue;

	switch (event)
		{
		
		case EVENT_KEYPRESS:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_VAL_CHANGED:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_COMMIT:
		
			    GetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH3, &lValue);
				stGuiSettings.lPhaseCh[3] = lValue;
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_PHASE_CH3, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
				}
				
				break;		

		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetDividerCh3 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lSetDividerCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		
		case EVENT_LEFT_CLICK : 
		
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
		
		case EVENT_LOST_FOCUS:		
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
				
				break;
		
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH3, &lState);
				
				// ----- write multiplier for the waveform period to struct -----
				switch (lState)
				{
				
					case _1		: stGuiSettings.lDividerCh[3] = 1;
								  break;
					
					case _1DIV2 : stGuiSettings.lDividerCh[3] = 2;
								  break;
					
					case _1DIV4 : stGuiSettings.lDividerCh[3] = 4;
								  break;
					
					case _1DIV8 : stGuiSettings.lDividerCh[3] = 8;
								  break;
				}
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_DIVIDER_CH3, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);     
					vDisplayFrequency();
				}
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lBoardStop 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lBoardStop (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	int lChannel;
	
	
	switch (event)
		{
	
		case EVENT_LEFT_CLICK :
		
			// ----- check if board is in stop mode -----
			  if (!stGuiSettings.lBoardStatus)
				SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
			break;
	
		case EVENT_COMMIT:
				
			GetCtrlVal (panelHandle, PANEL_BUTTON_BOARD_STOP, &lState);
				
			switch (lState)
			{
				case START :  stErrorCode = stControlBoard (START_BOARD, &stGuiSettings);
							  if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
							  
							  stGuiSettings.lBoardStatus = START;
								  
							  SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN);
								 
							  SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_BOARD_STOP, CTRL_TOOLTIP_ATTR_TEXT, "Stop Board");		
								 
							  break;
								
				case STOP  :  stErrorCode = stControlBoard (STOP_BOARD, &stGuiSettings);
							  if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
							  
							  stGuiSettings.lBoardStatus = STOP;
								  
							  SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_RED); 
								  
							  SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_BOARD_STOP, CTRL_TOOLTIP_ATTR_TEXT, "Start Board");		
								  
							  break;
			}
				
			vDisplayFrequency();
				
			break;
		
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetFrequency 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetFrequency (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	double dValue;
	double dSetToMaxFreq;

	
	switch (event)
		{
		
		case EVENT_KEYPRESS:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_VAL_CHANGED:
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_YELLOW); 
				
				break;
				
		case EVENT_COMMIT:
				
				GetCtrlVal (panelHandle, PANEL_DIAL_FREQ, &dValue);
				GetCtrlVal (panelHandle, PANEL_MENU_FREQ, &lState);
				
				stGuiSettings.dFrequency = dValue * pow(10, lState - 1);
				
				// ----- if selected frequency > max frequency, the dialer will set to max frequency -----
				if (stGuiSettings.dFrequency > stGuiSettings.dMaxFrequency)
				{
					switch (lState)
					{
						case 5 : // ----- dialer unit is set to x10 KHz -----
								 dSetToMaxFreq = stGuiSettings.dMaxFrequency / 10000.0;
								 SetCtrlVal (panelHandle, PANEL_DIAL_FREQ, dSetToMaxFreq); 
								 break;
								
						case 6 : // ----- dialer unit is set to x100 KHz -----
								 dSetToMaxFreq = stGuiSettings.dMaxFrequency / 100000.0;
								 SetCtrlVal (panelHandle, PANEL_DIAL_FREQ, dSetToMaxFreq); 
								 break;
								
						case 7 : // ----- dialer unit is set to x1 MHz -----
								 dSetToMaxFreq = stGuiSettings.dMaxFrequency / 1000000.0;
								 SetCtrlVal (panelHandle, PANEL_DIAL_FREQ, dSetToMaxFreq); 
								 break;
					}
				}
				
				// ----- check if board is in running mode -----
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (SET_FREQUENCY, &stGuiSettings);				
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
					
					SetCtrlAttribute (panelHandle, PANEL_LED_STATUS, ATTR_ON_COLOR, VAL_GREEN); 
				}
				
				vDisplayFrequency();
				vDisplayUsedSettings();
				
				break;

		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lResetSettings 			  							   *****
//**********************************************************************************************************************

int CVICALLBACK lResetSettings (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lChannel;
	int lDeltaComponent = 0;
	char szDispUsedMemsize[50];
  
	switch (event)
		{
		case EVENT_COMMIT:
				
				// ----- reset the GUI to default settings -----
				for (lChannel = 0; lChannel < 4; lChannel++)
				{
					SetCtrlVal (panelHandle, PANEL_KNOB_AMPLITUDE_CH0   + lDeltaComponent,  1000);
					SetCtrlVal (panelHandle, PANEL_KNOB_OFFSET_CH0      + lDeltaComponent,     0);
					SetCtrlVal (panelHandle, PANEL_KNOB_PHASE_CH0	    + lDeltaComponent,     0);
					SetCtrlVal (panelHandle, PANEL_MENU_DIVIDER_CH0     + lDeltaComponent,     1);
				  	SetCtrlVal (panelHandle, PANEL_BUTTON_SINE_CH0      + lDeltaComponent,   SET);
					SetCtrlVal (panelHandle, PANEL_BUTTON_RECTANGLE_CH0 + lDeltaComponent, RESET);
					SetCtrlVal (panelHandle, PANEL_BUTTON_TRIANGLE_CH0  + lDeltaComponent, RESET);
					
					stGuiSettings.lAmplitudeCh[lChannel] = 1000;
					stGuiSettings.lOffsetCh[lChannel]    =    0;
					stGuiSettings.lPhaseCh[lChannel]	 =    0;
					stGuiSettings.lDividerCh[lChannel]   =    1;
					stGuiSettings.lWaveformCh[lChannel]  = SINE;
		
					lDeltaComponent += DELTA_CHANNEL_COMPONENTS;
				}
				
				lDeltaComponent = 0;
				for (lChannel = 0; lChannel < 4; lChannel++)
				{
					SetCtrlVal (panelHandle, PANEL_LED_SINE_CH0      + lDeltaComponent,  ON);
					SetCtrlVal (panelHandle, PANEL_LED_RECTANGLE_CH0 + lDeltaComponent, OFF);
					SetCtrlVal (panelHandle, PANEL_LED_TRIANGLE_CH0  + lDeltaComponent, OFF);
					
					lDeltaComponent += 3;
					
					SetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH0 + lChannel, AUTO_FILTER);
					stGuiSettings.lFilterCh[lChannel] = AUTO_FILTER;
				}
				
				SetCtrlAttribute (panelHandle, PANEL_DIAL_FREQ, ATTR_MAX_VALUE, 1000.0);
			    SetCtrlAttribute (panelHandle, PANEL_DIAL_FREQ, ATTR_INCR_VALUE,   1.0);
			    
				SetCtrlVal (panelHandle, PANEL_MENU_FREQ, 4);
				lSetUnit (panelHandle, PANEL_MENU_FREQ, EVENT_COMMIT, NULL, 0, 0);
				
				SetCtrlVal (panelHandle, PANEL_DIAL_FREQ, 500.0);
				stGuiSettings.dFrequency = 500000.0;
				
				if (stGuiSettings.lBoardStatus)
				{
					stErrorCode = stControlBoard (RESET_BOARD, &stGuiSettings);
					if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
				}
				
				vDisplayFrequency ();
				vDisplayUsedSettings ();
				
				break;
		}
		
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetUnit 												   *****
//**********************************************************************************************************************

int CVICALLBACK lSetUnit (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	static int lLastState = -1;
	int lState;
	int lStateDif;
	double dMaxVal;
	double dIncrVal;
	double dDialerVal;
	
	switch (event)
		{
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_MENU_FREQ, &lState);
				
				// ----- set max values of the dialer -----
				switch (lState)
				{
					case 5 :  // ----- frequency unit is set to x10 KHz -----
							  dMaxVal  = stGuiSettings.dMaxFrequency / 10000.0;
							  dIncrVal = 1.0;
							  break;
					
					case 6 :  // ----- frequency unit is set to x100 KHz -----
							  dMaxVal  = stGuiSettings.dMaxFrequency / 100000.0;
							  dIncrVal = 1.0;
							  break;
					
					case 7 :  // ----- frequency unit is set to MHz -----
							  dMaxVal  = stGuiSettings.dMaxFrequency / 1000000.0;
							  dIncrVal = 0.1;
							  break;  
							  
					default : // ----- otherwise the max dialer value is 1000.0 -----
							  dMaxVal  = 1000.0;
							  dIncrVal = 1.0;
							  break;
				}
				
				SetCtrlAttribute (panelHandle, PANEL_DIAL_FREQ, ATTR_MAX_VALUE, dMaxVal);
				SetCtrlAttribute (panelHandle, PANEL_DIAL_FREQ, ATTR_INCR_VALUE, dIncrVal);
				
				if (lLastState == -1)
					lLastState = lState;
					
				else
				{
				
					if (lState > lLastState)
					{
						dDialerVal = stGuiSettings.dFrequency / pow(10, lState - 1); 
						if (dDialerVal < 1.0)
						{
							dDialerVal = 1.0;
							stGuiSettings.dFrequency = pow(10, lState - 1); 
							
							// ----- check if board is in running mode -----
							if (stGuiSettings.lBoardStatus)
							{
								stErrorCode = stControlBoard (SET_FREQUENCY, &stGuiSettings);
								if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
							}
						}
					}
					else
					{
						lStateDif = lLastState - lState;
						dDialerVal = (stGuiSettings.dFrequency / pow(10, lLastState - 1))  * pow(10, lStateDif); 
					
						if (dDialerVal > 1000.0) 
						{
							
							dDialerVal = 1000.0;
							stGuiSettings.dFrequency = 1000.0 * pow(10, lState - 1);
							
							// ----- check if board is in running mode -----
							if (stGuiSettings.lBoardStatus)
							{
								stErrorCode = stControlBoard (SET_FREQUENCY, &stGuiSettings);
								if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
							}
						}
						
					}	
				
					SetCtrlVal (panelHandle, PANEL_DIAL_FREQ, dDialerVal);
					
					lLastState = lState;
					vDisplayFrequency();
				}
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lBoardSelect 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lBoardSelect (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	
	switch (event)
		{
		case EVENT_COMMIT:
				
				// ----- get the index of the selected board handle -----
				GetCtrlIndex(brd_selectHandle, BRD_SELECT_BOARDLIST, &lHandleIndex);
				
				break;
		}
	return 0;
}

//**********************************************************************************************************************
//*****										 CVICALLBACK lSetBoardInfo 			  							       *****
//**********************************************************************************************************************

int CVICALLBACK lSetBoardInfo (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;

	switch (event)
		{
		case EVENT_COMMIT:
				GetCtrlVal (panelHandle, PANEL_BUTTON_INFO, &lState); 
				SetCtrlAttribute (panelHandle, PANEL_INDICATOR_USED_MEM,  ATTR_VISIBLE, lState);
				SetCtrlAttribute (panelHandle, PANEL_INDICATOR_USED_SRATE, ATTR_VISIBLE, lState);
				if (lState)
			    	SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_INFO, CTRL_TOOLTIP_ATTR_TEXT, "Hide Board Settings");
				else 
					SetCtrlToolTipAttribute (panelHandle, PANEL_BUTTON_INFO, CTRL_TOOLTIP_ATTR_TEXT, "Show Board Settings");				    	
			break;
		}
	return 0;
}

int CVICALLBACK lSetFilterCh0 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH0, &lState);
			
			stGuiSettings.lFilterCh[0] = lState;
			
			stErrorCode = stControlBoard (SET_FILTER_CH0, &stGuiSettings);
			if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
			
			break;
		}
	return 0;
}

int CVICALLBACK lSetFilterCh1 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH1, &lState);
			
			stGuiSettings.lFilterCh[1] = lState;
			
			stErrorCode = stControlBoard (SET_FILTER_CH1, &stGuiSettings);
			if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
			
			break;
		}
	return 0;
}

int CVICALLBACK lSetFilterCh2 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH2, &lState);
			
			stGuiSettings.lFilterCh[2] = lState;
			
			stErrorCode = stControlBoard (SET_FILTER_CH2, &stGuiSettings);
			if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
			
			break;
		}
	return 0;
}

int CVICALLBACK lSetFilterCh3 (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int lState;
	
	switch (event)
		{
		case EVENT_COMMIT:
			GetCtrlVal (panelHandle, PANEL_MENU_FILTER_CH3, &lState);
			
			stGuiSettings.lFilterCh[3] = lState;
			
			stErrorCode = stControlBoard (SET_FILTER_CH3, &stGuiSettings);
			if (stErrorCode.lErrorCode != SUCCESS) vDisplayDrvError ();
			
			break;
		}
	return 0;
}
