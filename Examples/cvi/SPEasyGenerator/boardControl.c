//********************************************************************************************************************** 
//*****																					 (c) Spectrum GmbH 01/2005 *****
//*****																											   *****
//*****   	 			LabWindows / CVI Function Generator for MI_MC_MX 60xx or MI_MC_MX 61xx					   *****
//*****																											   *****	
//**********************************************************************************************************************
//*****																											   ***** 
//*****  Filename 	 : boardControl.c     																		   *****	
//*****																											   *****	    
//*****  Description : This module contains all functions to initialize and control the board.   				   *****												
//*****																											   *****
//**********************************************************************************************************************

#include <stdio.h>
#include <windows.h> 


#include <utility.h>
#include <ansi_c.h>		
#include <userint.h>
#include "boardControl.h"
#include "prototypes.h"

// ----- include the spectrum headers -----
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"



// ----- define the Spectrum driver functions -----
typedef short (SPCINITPCIBOARDS) (short* pnCount, short* pnPCIVersion);
typedef short (SPCINITBOARD)     (short nNr, short nTyp);
typedef short (SPCSETPARAM)      (short nNr, int lReg, int lValue);
typedef short (SPCGETPARAM)      (short nNr, int lReg, int* plValue);
typedef short (SPCSETDATA)       (short nNr, short nCh, int lStart, int lLen, void* pvData);
typedef short (SPCGETDATA)       (short nNr, short nCh, int lStart, int lLen, void* pvData);

// ----- global function adresses to acess the Spectrum driver -----
SPCINITPCIBOARDS* SpcInitPCIBoards;
SPCINITBOARD*     SpcInitBoard;
SPCSETPARAM*      SpcSetParam;
SPCGETPARAM*      SpcGetParam;
SPCSETDATA*       SpcSetData;
SPCGETDATA*       SpcGetData;


static struct _BOARD_INFO stBoardInfo;
	   

//**********************************************************************************************************************
//***** Function to load the driver from the DLL  												  	 			   *****
//**********************************************************************************************************************

HINSTANCE lLoadSpectrumDrv (int *plStatus)
{
	HINSTANCE hDLL;	
	
	hDLL      = NULL; 
	*plStatus = 1;		

	// ----- try to open spectrum_comp.dll -----
	hDLL = LoadLibrary ("spectrum_comp.dll");
		
	if (!hDLL)
	{
		// ----- if spectrum_comp.dll is not found, try to open spectrum.dll -----
		hDLL = LoadLibrary ("spectrum.dll");
				
		if (!hDLL)
		{
			// ----- no dll was found -----
			*plStatus = -1;
			return NULL;
		}		
	}	
	
	// ----- get driver functions from the dll -----
	SpcInitPCIBoards = (SPCINITPCIBOARDS*) GetProcAddress (hDLL, "SpcInitPCIBoards");
	if (!SpcInitPCIBoards) *plStatus = -2;
	SpcInitBoard 	 = (SPCINITBOARD*)     GetProcAddress (hDLL, "SpcInitBoard");
	if (!SpcInitBoard) *plStatus = -2;
	SpcSetParam 	 = (SPCSETPARAM*)	   GetProcAddress (hDLL, "SpcSetParam");
	if (!SpcSetParam) *plStatus = -2;
	SpcGetParam 	 = (SPCGETPARAM*)	   GetProcAddress (hDLL, "SpcGetParam");
	if (!SpcGetParam) *plStatus = -2;
	SpcSetData 		 = (SPCSETDATA*)	   GetProcAddress (hDLL, "SpcSetData");
	if (!SpcSetData) *plStatus = -2;
	SpcGetData 		 = (SPCGETDATA*)	   GetProcAddress (hDLL, "SpcGetData");
	if (!SpcGetData) *plStatus = -2;
		
	if (*plStatus == -2)
	{
		FreeLibrary (hDLL);
		return NULL;
	}
		
	return hDLL;
}

//**********************************************************************************************************************
//***** Function to free the driver DLL  												  	 			           *****
//**********************************************************************************************************************

void vFreeSpectrumDrv (HINSTANCE hDLL)
{
	FreeLibrary (hDLL);
}	

//**********************************************************************************************************************
//***** FunctionCall : vSetFilter (lChannel, lWaveform, dFreq)  												   *****
//*****											 										   		                   *****
//***** ReturnCode   : -  			 																			   *****
//*****																											   *****
//***** Descritpion  : This function sets the filter for the refered channel. 			       					   *****
//**********************************************************************************************************************

void vSetFilter (int lChannel, int lWaveform, double dFreq)
{
	int hDrv;
	
	hDrv = stBoardInfo.hDrv;
	
	switch (lWaveform)
	{
		case RECTANGLE : if (dFreq > 1000000)
							 SpcSetParam (hDrv, SPC_FILTER0 + lChannel*100, 3);
						 else
						 {
						 	if (dFreq > 1000)
								SpcSetParam (hDrv, SPC_FILTER0 + lChannel*100, 2);
							else
							  	SpcSetParam (hDrv, SPC_FILTER0 + lChannel*100, 1);
						 }
					     break;
						 
		case SINE	   : SpcSetParam (hDrv, SPC_FILTER0 + lChannel*100, 3);
						 break;
			
		case TRIANGLE  : SpcSetParam (hDrv, SPC_FILTER0 + lChannel*100, 3);
						 break;
	}
}

//**********************************************************************************************************************
//***** FunctionCall : stSetBoard (&stGuiSettings)																   *****
//*****											 										   		                   *****
//***** ReturnCode   : stErrorCode 																				   *****
//*****																											   *****
//***** Descritpion  : This function stops the board, sets a new setup to the board and starts it.			       *****
//*****				   If a driver error occured, the error values will be set to the stErrorCode struct.		   *****
//*****				   Otherwise the values of stErrorCode will be 0.										       *****
//**********************************************************************************************************************

struct _ERRORCODE stSetBoard (struct _GUI_SETTINGS *stGuiSettings)
{
	struct _ERRORCODE stErrorCode;
	struct _CALC_DATA stCalcData;
	short* pnData[4];
	short* pnTmpData;
	char*  pcTmpData;
	int hDrv, lChannel, lErrorCode;	
	int i,m,n;
	
	
	hDrv = stBoardInfo.hDrv;

	stErrorCode.lErrorCode  = 0;
	stErrorCode.lErrorReg   = 0;
	stErrorCode.lErrorValue = 0;

	
	// ----- stop board -----
	SpcSetParam (hDrv, SPC_COMMAND, SPC_STOP);      
	
	// ----- get samplerate, memsize, blocksize and period -----
	vGetCalcData (&stCalcData, &stBoardInfo, stGuiSettings);
	
    // ----- get phase shifted waveform data for all channels -----
	for(lChannel=0;lChannel<stGuiSettings->lChannels;lChannel++)
	{
		pnData[lChannel] = pnCalculateSampleData (&stCalcData, stGuiSettings, &stBoardInfo, lChannel);
		
		// ----- write frequency to stGuiSettings to use this information in the GUI -----
		stGuiSettings->dDisplayFreqCh[lChannel] = (double)stCalcData.lSamplerate / (double)(stCalcData.lPeriod * stGuiSettings->lDividerCh[lChannel]);
		
		// ----- set filter for all channels ----- 
		if (stGuiSettings->lFilterCh[lChannel] == AUTO_FILTER)
			vSetFilter (lChannel, stGuiSettings->lWaveformCh[lChannel], stGuiSettings->dFrequency);	    
	    
	}
	
	// ----- set memsize and samplerate to board -----
	SpcSetParam (hDrv, SPC_MEMSIZE,    stCalcData.lMemsize);	
    SpcSetParam (hDrv, SPC_SAMPLERATE, stCalcData.lSamplerate);
	
	
	// ----- write used memsize and samplerate to stGuiSettings to use this information in the GUI -----
	stGuiSettings->lUsedMemsize    = stCalcData.lMemsize;	
	stGuiSettings->lUsedSamplerate = stCalcData.lSamplerate;
	
	
	// ----- discern between 8 bit or 14 bit board ----- 
	if (stBoardInfo.lBytesPerSample == 1)
	{
		
		// ----- 8 bit per sample -----
		
		// ----- allocate memory (1 byte for each sample) -----
		pcTmpData = (char*) malloc (2 * stCalcData.lMemsize);   
		
		switch (stBoardInfo.lChPerMod)
    	{
    		case 1: // ----- one channel per modul -----
    				for (m=0; m<stBoardInfo.lMod; m++)
    				{
    					for (i=0; i<stCalcData.lMemsize; i++)
    					{
    						// ----- convert short samples to byte samples -----
    						pcTmpData[i] = (char)pnData[m][i];
    					}
    					
    					// ----- write data to board -----
            			SpcSetData (hDrv, (short) m, 0, stCalcData.lMemsize, pcTmpData);  
					}
					
					break;
				
   			case 2:	// ----- two channels per modul -----
   					for(m=0; m<stBoardInfo.lMod; m++)
    				{
    					for (i=0; i<stCalcData.lMemsize; i++)	
        				{
        					// ----- convert short samples to byte samples and multiplex to pcTmpData -----
        					pcTmpData[2*i]   = (char)pnData[2*m][i];    
      						pcTmpData[2*i+1] = (char)pnData[2*m+1][i];  
        				}
        				
        				// ----- write data to board -----
						SpcSetData (hDrv, (short) m, 0, 2 * stCalcData.lMemsize, pcTmpData);        								
					}
					
    				break;
    	}
		
		
	}
	else
	{
		
		// ----- 14 bit per sample -----
		
		// ----- allocate memory (2 bytes for each sample) -----
		pnTmpData = (short*) malloc (2 * 2 * stCalcData.lMemsize);   
		
		switch (stBoardInfo.lChPerMod)
    	{
    		case 1: // ----- one channel per modul -----
    				for (m=0; m<stBoardInfo.lMod; m++)
					{    				
    					// ----- write data to board -----
            			SpcSetData (hDrv, (short) m, 0, stCalcData.lMemsize, pnData[m]);    
					}
					
					break;
				
   			case 2:	// ----- two channels per modul -----
   					for(m=0; m<stBoardInfo.lMod; m++)
    				{
    					for (i=0; i<stCalcData.lMemsize; i++)	
        				{
        					// ----- multiplex data to pnTmpData ----- 
        					pnTmpData[2*i]   = pnData[2*m][i];    
      						pnTmpData[2*i+1] = pnData[2*m+1][i];  
        				}
        				
						// ----- write data to board -----        								
						SpcSetData (hDrv, (short) m, 0, 2 * stCalcData.lMemsize, pnTmpData);        								
									        							
    				}
    			
    				break;
    	}
	}
	

	// ----- start board -----
    lErrorCode = SpcSetParam (hDrv, SPC_COMMAND, SPC_START);     
	
	// ----- check for driver errors -----
	if (lErrorCode != SUCCESS)
	{
		SpcGetParam (hDrv, SPC_LASTERRORCODE,  &stErrorCode.lErrorCode);
    	SpcGetParam (hDrv, SPC_LASTERRORREG,   &stErrorCode.lErrorReg);
        SpcGetParam (hDrv, SPC_LASTERRORVALUE, &stErrorCode.lErrorValue);
	}

    // ----- free allocated memory -----
    for(n=0;n<stGuiSettings->lChannels;n++)
    	free (pnData[n]); 
    
    if (stBoardInfo.lBytesPerSample == 1)
		 free (pcTmpData);
	else free (pnTmpData);
	
	return stErrorCode;
}

//**********************************************************************************************************************
//***** FunctionCall : lSearch4Boards (lMI6X_BrdType, lMI6X_SN, lMI6X_hDrv) 									   *****
//*****												  													   		   *****
//***** ReturnCode   : lMI6XFound						   			   											   *****
//*****																											   *****
//***** Description  : This function seeks for all spectrum boards in the system. If a MI60xx or a MI61xx          *****
//*****				   board is found, the board type, serial number and handle will be stored in the		       *****
//*****				   corresponding refered address. The return value is the number of the counted MI60xx 		   *****
//*****				   and MI61xx boards.																		   *****
//**********************************************************************************************************************

int lSearch4Boards(int lMI6X_BrdType[], int lMI6X_SN[], int lMI6X_hDrv[])
{
	short nCount, nVersion;
	int lBrdType[MAX_BRDS];
	int lSN[MAX_BRDS];
	int lMI6XFound = 0;
	int i;
	
	// ----- get number of spectrum boards in the system -----
	SpcInitPCIBoards (&nCount, &nVersion);
	
	for(i=0;(i < MAX_BRDS) && (i < nCount);i++)
	{
		SpcGetParam(i, SPC_PCITYP, &lBrdType[i]); 
		SpcGetParam(i, SPC_PCISERIALNR, &lSN[i]);
		
		if (((lBrdType[i] & 0xffff) > 0x6000) && ((lBrdType[i] & 0xffff) < 0x6200))
		{
			// ----- found MI60xx or MI61xx board -----
			lMI6X_BrdType[lMI6XFound] = lBrdType[i]; // store board type 
			lMI6X_SN[lMI6XFound]      = lSN[i];		 // store serial number
			lMI6X_hDrv[lMI6XFound]    = i;			 // store handle
			lMI6XFound++;							 // increase the number of founded MI60xx or MI61xx boards
		}
	}
	
	return lMI6XFound;
}

//**********************************************************************************************************************
//***** FunctionCall : stInitBoard (hDrv)																		   *****
//*****																									   		   *****
//***** ReturnCode	 : stBoardInfo		 																		   *****
//*****																											   *****
//***** Description  : This function fills and returns the struct stBoardInfo with all information about the   	   *****
//*****				   board with the handle hDrv.													   			   *****
//**********************************************************************************************************************

struct _BOARD_INFO stInitBoard (int hDrv)
{	  
	stBoardInfo.hDrv = hDrv;
	
	SpcGetParam (hDrv, SPC_PCITYP, 		      &stBoardInfo.lBoardType);
	SpcGetParam (hDrv, SPC_PCISERIALNO,    &stBoardInfo.lSerialNumber);
	SpcGetParam (hDrv, SPC_PCIMEMSIZE, 	     &stBoardInfo.lMaxMemsize);
	SpcGetParam (hDrv, SPC_PCISAMPLERATE, &stBoardInfo.lMaxSamplerate);
	
	switch (stBoardInfo.lBoardType)
	{
		// ----- 60er boards -----
		case TYP_MI6030:
		case TYP_MC6030:
		case TYP_MX6030:
			 	stBoardInfo.lMaxChannels 	= 		 1; // number of channels
				stBoardInfo.lMod			= 		 1; // number of modules
				stBoardInfo.lChPerMod		= 		 1; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		 2; // 14 bit board
				stBoardInfo.lChEnable       = 		 1; //  1 channel enable (0001)
				stBoardInfo.lMaxFrequency   = 10000000; // max. frequency 10 MHz 
				break;
		
		case TYP_MI6010:
		case TYP_MC6010:
		case TYP_MX6010:
				stBoardInfo.lMaxChannels	= 		 1; // number of channels
				stBoardInfo.lMod			= 		 1; // number of modules
				stBoardInfo.lChPerMod		= 		 1; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		 2; // 14 bit board
				stBoardInfo.lChEnable       =  		 1; //  1 channels enable (0001)
				stBoardInfo.lMaxFrequency   = 20000000; // max. frequency 20 MHz  
				break;
		
		case TYP_MI6011:
		case TYP_MC6011:
		case TYP_MX6011:
				stBoardInfo.lMaxChannels	= 		2; // number of channels
				stBoardInfo.lMod			= 		1; // number of modules
				stBoardInfo.lChPerMod		= 		2; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		2; // 14 bit board
				stBoardInfo.lChEnable       = 		3; //  2 channels enable (0011)
				stBoardInfo.lMaxFrequency   = 1500000; // max. frequency 1.5 MHz  
				break;
		
		case TYP_MI6021:
		case TYP_MI6033:
		
		case TYP_MC6021:
		case TYP_MC6033:
		
		case TYP_MX6021:
		case TYP_MX6033:
				stBoardInfo.lMaxChannels	= 		2; // number of channels
				stBoardInfo.lMod			= 		1; // number of modules
				stBoardInfo.lChPerMod		= 		2; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		2; // 14 bit board
				stBoardInfo.lChEnable       = 		3; //  2 channels enable (0011)
				stBoardInfo.lMaxFrequency   = 5000000; // max. frequency 5 MHz 
				break;
			
		case TYP_MI6031:
		case TYP_MC6031:
				stBoardInfo.lMaxChannels	= 		 2; // number of channels
				stBoardInfo.lMod			= 		 2; // number of modules
				stBoardInfo.lChPerMod		= 		 1; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		 2; // 14 bit board
				stBoardInfo.lChEnable       = 		 3; //  2 channels enable (0011)
				stBoardInfo.lMaxFrequency   = 10000000; // max. frequency 10 MHz 
				break;
		
		case TYP_MI6012:
		case TYP_MC6012:
				stBoardInfo.lMaxChannels	=  		4; // number of channels
				stBoardInfo.lMod			=  		2; // number of modules
				stBoardInfo.lChPerMod		=  	    2; // number of channels per modul
				stBoardInfo.lBytesPerSample = 	    2; // 14 bit board
				stBoardInfo.lChEnable       = 	   15; //  4 channels enable (1111)
				stBoardInfo.lMaxFrequency   = 1500000; // max. frequency 1.5 MHz 
				break;
				
		case TYP_MI6022:
		case TYP_MI6034:
		
		case TYP_MC6022:
		case TYP_MC6034:
				stBoardInfo.lMaxChannels	=  		4; // number of channels
				stBoardInfo.lMod			=  		2; // number of modules
				stBoardInfo.lChPerMod		=  		2; // number of channels per modul
				stBoardInfo.lBytesPerSample =  		2; // 14 bit board
				stBoardInfo.lChEnable       = 	   15; //  4 channels enable (1111)
				stBoardInfo.lMaxFrequency   = 5000000; // max. frequency 5 MHz
				break;
		
	
		// -----61er boards -----
		case TYP_MI6110:
		case TYP_MC6110:
		case TYP_MX6110:
				stBoardInfo.lMaxChannels	= 		 2; // number of channels
				stBoardInfo.lMod			= 		 1; // number of modules
				stBoardInfo.lChPerMod		= 		 2; // number of channels per modul
				stBoardInfo.lBytesPerSample = 		 1; // 8 bit board
				stBoardInfo.lChEnable       = 		 3; // 2 channels enable (0011) 
				stBoardInfo.lMaxFrequency   = 10000000; // max. frequency 10 MHz 
				break;
			
		case TYP_MI6111:
		case TYP_MC6111:
				stBoardInfo.lMaxChannels	=  		 4; // number of channels
				stBoardInfo.lMod			=  		 2; // number of modules
				stBoardInfo.lChPerMod		=  		 2; // number of channels per modul
				stBoardInfo.lBytesPerSample =  	     1; // 8 bit board
				stBoardInfo.lChEnable       = 		15; // 4 channels enable (1111)
				stBoardInfo.lMaxFrequency   = 10000000; // max. frequency 10 MHz 
				break;
		
	}
	
	// ----- get max samplerate, if all channels are enabled -----
	SpcSetParam (hDrv, SPC_CHENABLE,    stBoardInfo.lChEnable);
	SpcSetParam (hDrv, SPC_SAMPLERATE,  stBoardInfo.lMaxSamplerate); 
	SpcGetParam (hDrv, SPC_SAMPLERATE, &stBoardInfo.lMaxSamplerate); 
	
	return stBoardInfo;
}

//**********************************************************************************************************************
//***** FunctionCall : stControlBoard (lEvent, &stGuiSettings) 													   *****
//*****																											   *****
//***** ReturnCode	 : stErrorCode																				   *****
//*****																											   *****
//***** Description	 : This function executes the instruction, that is given to the board by lEvent.      	       *****
//*****				   The refered struct stGuiSettings contains all settings made by the GUI.                     *****
//*****		           If an error occured while setting the board, the function returns a struct with all     	   *****
//*****				   driver error values. If there is no driver error, the struct values will be 0.		       *****
//**********************************************************************************************************************

struct _ERRORCODE stControlBoard (int lEvent, struct _GUI_SETTINGS *stGuiSettings)
{
	int hDrv;
	int i;
	struct _ERRORCODE stErrorCode;
	
	
	stErrorCode.lErrorCode  = 0;
	stErrorCode.lErrorReg   = 0;
	stErrorCode.lErrorValue = 0;
	
	hDrv = stBoardInfo.hDrv;
	
	switch (lEvent)
	{
		case SET_INIT_SETUP    : for(i=0;i < stGuiSettings->lChannels;i++)
								 {
								 	if (stGuiSettings->lSwitchCh[i])
								 	{
								 		 SpcSetParam (hDrv, SPC_AMP0  + i*100, stGuiSettings->lAmplitudeCh[i]); // set amplitude for all enabled channels
								 		 SpcSetParam (hDrv, SPC_OFFS0 + i*100, stGuiSettings->lOffsetCh[i]);    // set offset for all enabled channels
								 	}
								 	else 
								 	{
								 		SpcSetParam (hDrv, SPC_AMP0  + i*100, 0);  // set amplitude to 0 for all disabled channels
										SpcSetParam (hDrv, SPC_OFFS0 + i*100, 0);  // set offset to 0 for all disabled channels
									}
									if (stGuiSettings->lFilterCh[i] != AUTO_FILTER)
									SpcSetParam (hDrv, SPC_FILTER0 + i*100, stGuiSettings->lFilterCh[i]); 
								 }
								 
								 SpcSetParam (hDrv, SPC_CHENABLE, stBoardInfo.lChEnable);	    // enable channels
								 
						         SpcSetParam (hDrv, SPC_PLL_ENABLE,	 	   	   1);				// internal PLL enabled for clock
								 SpcSetParam (hDrv, SPC_EXTERNALCLOCK,	       0);				// internal clock
								 SpcSetParam (hDrv, SPC_EXTERNOUT,		       0);				// no clock output
								 SpcSetParam (hDrv, SPC_TRIGGERMODE, TM_SOFTWARE);				// software trigger is used
								 SpcSetParam (hDrv, SPC_TRIGGEROUT,		       0);				// no trigger output
								 SpcSetParam (hDrv, SPC_SINGLESHOT,			   0);				// continuous 
								 SpcSetParam (hDrv, SPC_OUTONTRIGGER,	       1);				// no OutonTrigger
								 SpcSetParam (hDrv, SPC_PATTERNENABLE,         0);				// no pattern output
		
								 return stSetBoard (stGuiSettings); 
								 break;
								 
		case RESET_BOARD	   : SpcSetParam (hDrv, SPC_COMMAND, SPC_STOP);
								 for(i=0;i < stGuiSettings->lChannels;i++)
								 {
								 	if (stGuiSettings->lSwitchCh[i])
								 	{
								 		SpcSetParam (hDrv, SPC_AMP0  + i*100, stGuiSettings->lAmplitudeCh[i]); // set amplitude for all enabled channels
								 		SpcSetParam (hDrv, SPC_OFFS0 + i*100, stGuiSettings->lOffsetCh[i]);    // set offset for all enabled channels
								 	}
								 	else
								 	{
								 		SpcSetParam (hDrv, SPC_AMP0  + i*100, 0);  // set amplitude to 0 for all disabled channels
								 		SpcSetParam (hDrv, SPC_OFFS0 + i*100, 0);  // set offset to 0 for all disabled channels 							    
								 	}
								 }
								 
								 SpcSetParam (hDrv, SPC_CHENABLE, stBoardInfo.lChEnable); // enable channels
								 
								 return stSetBoard (stGuiSettings); 
								 break;
								 
		case START_BOARD	   : for(i=0;i < stGuiSettings->lChannels;i++)
								 {
								 	if (stGuiSettings->lSwitchCh[i] == ON)
								 	{
								 		 SpcSetParam (hDrv, SPC_AMP0  + i*100, stGuiSettings->lAmplitudeCh[i]); 
								 		 SpcSetParam (hDrv, SPC_OFFS0 + i*100, stGuiSettings->lOffsetCh[i]);
								 	}
								 	else
								 	{
								 		SpcSetParam (hDrv, SPC_AMP0  + i*100, 0);
								 		SpcSetParam (hDrv, SPC_OFFS0 + i*100, 0);
									}								 	
								 }
		
								 SpcSetParam (hDrv, SPC_COMMAND, SPC_START); 
		
								 return stSetBoard (stGuiSettings);  
								 break;							    
								 
		case STOP_BOARD		   : SpcSetParam (hDrv, SPC_COMMAND, SPC_STOP);  
								 break;
								 
        case SET_CH0_ON        : SpcSetParam (hDrv, SPC_AMP0, stGuiSettings->lAmplitudeCh[0]);
        						 SpcSetParam (hDrv, SPC_OFFS0, stGuiSettings->lOffsetCh[0]);
								 break;
		
		case SET_CH0_OFF	   : SpcSetParam (hDrv, SPC_AMP0, 0);
								 SpcSetParam (hDrv, SPC_OFFS0, 0);
								 break;
		
		case SET_CH1_ON		   : SpcSetParam (hDrv, SPC_AMP1, stGuiSettings->lAmplitudeCh[1]);
								 SpcSetParam (hDrv, SPC_OFFS1, stGuiSettings->lOffsetCh[1]);
								 break;
								 
		case SET_CH1_OFF	   : SpcSetParam (hDrv, SPC_AMP1, 0);
								 SpcSetParam (hDrv, SPC_OFFS1, 0);
								 break;

	    case SET_CH2_ON		   : SpcSetParam (hDrv, SPC_AMP2, stGuiSettings->lAmplitudeCh[2]);
	    						 SpcSetParam (hDrv, SPC_OFFS2, stGuiSettings->lOffsetCh[2]);
	    						 break;
	    						 
	    case SET_CH2_OFF       : SpcSetParam (hDrv, SPC_AMP2, 0);
	    						 SpcSetParam (hDrv, SPC_OFFS2, 0);
	    						 break;
	    						 
	    case SET_CH3_ON		   : SpcSetParam (hDrv, SPC_AMP3, stGuiSettings->lAmplitudeCh[3]);
	    						 SpcSetParam (hDrv, SPC_OFFS3, stGuiSettings->lOffsetCh[3]);
	    						 break;
		
	    case SET_CH3_OFF       : SpcSetParam (hDrv, SPC_AMP3, 0);
	    						 SpcSetParam (hDrv, SPC_OFFS3, 0);
	    						 break;
	    						 
		case SET_AMPLITUDE_CH0 : SpcSetParam (hDrv, SPC_AMP0, stGuiSettings->lAmplitudeCh[0]);
								 break;
				 				 
		case SET_AMPLITUDE_CH1 : SpcSetParam (hDrv, SPC_AMP1, stGuiSettings->lAmplitudeCh[1]);
								 break;
								 
		case SET_AMPLITUDE_CH2 : SpcSetParam (hDrv, SPC_AMP2, stGuiSettings->lAmplitudeCh[2]);
								 break;
								 
		case SET_AMPLITUDE_CH3 : SpcSetParam (hDrv, SPC_AMP3, stGuiSettings->lAmplitudeCh[3]);
								 break;
								 
		case SET_OFFSET_CH0	   : SpcSetParam (hDrv, SPC_OFFS0, stGuiSettings->lOffsetCh[0]);
								 break;
								 
		case SET_OFFSET_CH1	   : SpcSetParam (hDrv, SPC_OFFS1, stGuiSettings->lOffsetCh[1]);
								 break;
								 
		case SET_OFFSET_CH2	   : SpcSetParam (hDrv, SPC_OFFS2, stGuiSettings->lOffsetCh[2]);
								 break;
								 
		case SET_OFFSET_CH3	   : SpcSetParam (hDrv, SPC_OFFS3, stGuiSettings->lOffsetCh[3]);
								 break;
								 
		case SET_FILTER_CH0    : if (stGuiSettings->lFilterCh[0] == AUTO_FILTER)
									vSetFilter (0, stGuiSettings->lWaveformCh[0], stGuiSettings->dFrequency);
								 else
								 	SpcSetParam (hDrv, SPC_FILTER0, stGuiSettings->lFilterCh[0]);
								 break;
								 
		case SET_FILTER_CH1	   : if (stGuiSettings->lFilterCh[1] == AUTO_FILTER)
									vSetFilter (1, stGuiSettings->lWaveformCh[1], stGuiSettings->dFrequency);
								 else
								 	SpcSetParam (hDrv, SPC_FILTER1, stGuiSettings->lFilterCh[1]);
								 break;
								 
		case SET_FILTER_CH2	   : if (stGuiSettings->lFilterCh[2] == AUTO_FILTER)
									vSetFilter (2, stGuiSettings->lWaveformCh[2], stGuiSettings->dFrequency);
								 else
								 	SpcSetParam (hDrv, SPC_FILTER2, stGuiSettings->lFilterCh[2]);
								 break;
								 
		case SET_FILTER_CH3	   : if (stGuiSettings->lFilterCh[3] == AUTO_FILTER)
									vSetFilter (3, stGuiSettings->lWaveformCh[3], stGuiSettings->dFrequency);
								 else
								 	SpcSetParam (hDrv, SPC_FILTER3, stGuiSettings->lFilterCh[3]);
								 break;
								
		case SET_PHASE_CH0	   : 
		case SET_PHASE_CH1	   : 
		case SET_PHASE_CH2	   : 
		case SET_PHASE_CH3	   : 
		case SET_WAVEFORM_CH0  : 
		case SET_WAVEFORM_CH1  : 
		case SET_WAVEFORM_CH2  : 
		case SET_WAVEFORM_CH3  : 
		case SET_DIVIDER_CH0   : 
		case SET_DIVIDER_CH1   : 
		case SET_DIVIDER_CH2   : 
		case SET_DIVIDER_CH3   : 
								 
		case SET_FREQUENCY	   :  return stSetBoard (stGuiSettings);
								  break;
								 
		
	}
	
	// ----- check for driver errors -----
	SpcGetParam (hDrv, SPC_LASTERRORCODE,  &stErrorCode.lErrorCode);
	
	if (stErrorCode.lErrorCode != SUCCESS)
	{
		SpcGetParam (hDrv, SPC_LASTERRORREG,   &stErrorCode.lErrorReg);
        SpcGetParam (hDrv, SPC_LASTERRORVALUE, &stErrorCode.lErrorValue);
    }
    
	return stErrorCode;
}

