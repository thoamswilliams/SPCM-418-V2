#include <ansi_c.h>
#include <utility.h>
#include <cvirte.h>		
#include <userint.h>
#include "MI_DataAcquisition.h"



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



static int panelHandle;
static int bInitDone = 0;

int lChColor[8] = {VAL_RED, VAL_GREEN, VAL_BLUE, VAL_CYAN, VAL_MAGENTA, VAL_YELLOW, VAL_WHITE, VAL_LT_GRAY};

int main (int argc, char *argv[])
{
	int DriverId;
	int Status;
	
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
		
		
		
	// ----- load the driver entries from the DLL -----
	DriverId = LoadExternalModule ("..\\c_header\\spectrum.lib");
	if (DriverId < 0)
		return -1;	// DLL not found 

	// ----- Load functions from DLL -----
	SpcInitPCIBoards = (SPCINITPCIBOARDS*) GetExternalModuleAddr (DriverId, "SpcInitPCIBoards", &Status);
	SpcInitBoard =     (SPCINITBOARD*)     GetExternalModuleAddr (DriverId, "SpcInitBoard", &Status);
	SpcSetParam =      (SPCSETPARAM*)      GetExternalModuleAddr (DriverId, "SpcSetParam", &Status);
	SpcGetParam =      (SPCGETPARAM*)      GetExternalModuleAddr (DriverId, "SpcGetParam", &Status);
	SpcSetData =       (SPCSETDATA*)       GetExternalModuleAddr (DriverId, "SpcSetData", &Status);
	SpcGetData =       (SPCGETDATA*)       GetExternalModuleAddr (DriverId, "SpcGetData", &Status);

	
	if ((panelHandle = LoadPanel (0, "MI_DataAcquisition.uir", PANEL)) < 0)
		return -1;
	DisplayPanel (panelHandle);
	RunUserInterface ();
	DiscardPanel (panelHandle);
	
	// ----- free the driver dll -----
	UnloadExternalModule (DriverId);
	
	return 0;
}



// ----- InitBoard function -----

int CVICALLBACK vInitBoard (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	short 	nCount, nPCIBusVersion;
	int		lType, lSN, lMemory, lSamplerate;
	char	szText[200];
	
	switch (event)
		{
		case EVENT_COMMIT:
			(*SpcInitPCIBoards) (&nCount, &nPCIBusVersion);
			(*SpcGetParam) (0, SPC_PCITYP, &lType);
			(*SpcGetParam) (0, SPC_PCISERIALNO, &lSN);
			(*SpcGetParam) (0, SPC_PCIMEMSIZE, &lMemory);
			(*SpcGetParam) (0, SPC_PCISAMPLERATE, &lSamplerate);
			
			// ----- check whether the example works with the board type -----
			switch (lType & 0xff00)
			{
				case 0x2000:
				case 0x3000:
				case 0x3100:
				case 0x4000:
				case 0x4500:
					bInitDone = 1;
					sprintf (szText, "%d Board(s) found\nType = MI.%04x\nSerial No = %05d\nMemory = %d MB\nSpeed = %.2f MS/s", nCount, lType, lSN, (int) (lMemory/1024/1024), (double) lSamplerate / 1000000.0);
					MessagePopup ("CVI example initialisation", szText);
					break;
					
				default:
					sprintf (szText, "%d Board(s) found\nType = MI.%04x\nSerial No = %05d\nMemory = %d MB\nSpeed = %.2f MS/s\n\n!!! This board is not supported by the example !!!", nCount, lType, lSN, (int) (lMemory/1024/1024), (double) lSamplerate / 1000000.0);
					MessagePopup ("CVI example initialisation", szText);
					break;
			}
			
			
			
			// ----- set the y scaling of the graph coresponding to the board -----
			switch (lType & 0xff00)
			{
				// ----- 8 bit A/D -----
				case 0x2000:
					SetAxisScalingMode (panelHandle, PANEL_WAVEFORM, VAL_LEFT_YAXIS, VAL_MANUAL, -128, 128);
					break;
			
				// ----- 12 bit A/D -----
				case 0x3000:
				case 0x3100:
					SetAxisScalingMode (panelHandle, PANEL_WAVEFORM, VAL_LEFT_YAXIS, VAL_MANUAL, -2048, 2048);
					break;
				
				// ----- 14 bit A/D -----
				case 0x4000:
					SetAxisScalingMode (panelHandle, PANEL_WAVEFORM, VAL_LEFT_YAXIS, VAL_MANUAL, -8192, 8192);
					break;

				// ----- 16 bit A/D -----
				case 0x4500:
					SetAxisScalingMode (panelHandle, PANEL_WAVEFORM, VAL_LEFT_YAXIS, VAL_MANUAL, -32768, 32768);
					break;
			}
			
			break;
		}
	return 0;
}



// ----- AcquireData -----

int CVICALLBACK vAcquireData (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	short 	nErr;
	char	szError[100];
	int		lErrorCode, lErrorReg, lErrorValue;
	int		lMemsize, lStatus;
	int		lModules, lChPerMod, lBytesPerSample, lChannels, lChEnable;
	int		i, j, k;
	short*	pnData[8];
	char*	pbyData[8];
	short*	pnTmp;
	char*	pbyTmp;
	
	lMemsize = 1024;
	
	switch (event)
		{
		case EVENT_COMMIT:
			if (!bInitDone)
				MessagePopup ("CVI example error", "please init board first");
				
				
			// the data acquisition starts here 
			// --------------------------------
			// as this is an universal example, it will acquire all channels and it will only
			// change a very few settings of the board. Please refer to the manual for further
			// settings and possiblities
			else
				{
				
				// ----- read our some internal settings to determine the board characteristics -----
				nErr = (*SpcGetParam) (0, SPC_MIINST_MODULES,	&lModules);
				nErr = (*SpcGetParam) (0, SPC_MIINST_CHPERMODULE,	&lChPerMod);			
				nErr = (*SpcGetParam) (0, SPC_MIINST_BYTESPERSAMPLE, &lBytesPerSample);
				
				lChannels = lModules*lChPerMod;
				switch (lChannels)
				{
					case 1: lChEnable = 1; break;    
					case 2: lChEnable = 3; break;    		
					case 4: lChEnable = 15; break;    					
					case 8: lChEnable = 255; break;    
				}
					
				for (i=0; i<lChannels; i++)
				{
					nErr = (*SpcSetParam) (0, SPC_AMP0+100*i,	1000);			// +/- 1V input range
					nErr = (*SpcSetParam) (0, SPC_50OHM0+100*i,1);				// 50 Ohm input impedance
				}

				nErr = (*SpcSetParam) (0, SPC_CHENABLE,			lChEnable);		// Enable channels for recording
				nErr = (*SpcSetParam) (0, SPC_POSTTRIGGER,		lMemsize/2);	// Trigger event in middle of data
				nErr = (*SpcSetParam) (0, SPC_MEMSIZE,			lMemsize);		// samples to acquire

				nErr = (*SpcSetParam) (0, SPC_PLL_ENABLE,		1);				// Internal PLL enabled for clock
				nErr = (*SpcSetParam) (0, SPC_EXTERNALCLOCK,	0);				// Internal clock used
				nErr = (*SpcSetParam) (0, SPC_SAMPLERATE,		100000);		// Samplerate: 100 kS/s
				nErr = (*SpcSetParam) (0, SPC_EXTERNOUT,		0);				// No clock output
				nErr = (*SpcSetParam) (0, SPC_TRIGGERMODE,		TM_SOFTWARE);	// Software trigger is used
				nErr = (*SpcSetParam) (0, SPC_PULSEWIDTH,		0);				// Not used for software mode
				nErr = (*SpcSetParam) (0, SPC_TRIGGEROUT,		0);				// No trigger output

				// ----- start the board -----
				nErr = (*SpcSetParam) (0, SPC_COMMAND,	SPC_START);		// Use SPC_STARTANDWAIT for interrupt mode

				// ----- driver error: request error and end program -----
				if (nErr != ERR_OK)
					{
					nErr = (*SpcGetParam) (0, SPC_LASTERRORCODE,	&lErrorCode);
					nErr = (*SpcGetParam) (0, SPC_LASTERRORREG,	&lErrorReg);
					nErr = (*SpcGetParam) (0, SPC_LASTERRORVALUE,	&lErrorValue);

					sprintf (szError, "Driver error: %ld in register %ld at value %ld\n", lErrorCode, lErrorReg, lErrorValue);
					MessagePopup ("CVI example driver error", szError);
					
					break;
					}
					
				// ----- Wait for Status Ready (Could be deleted if interrupt mode is used) -----
				do
					{
					nErr = (*SpcGetParam) (0, SPC_STATUS,		&lStatus);		
					}
				while (lStatus != SPC_READY);



				// ----- clear the waveform display -----
				DeleteGraphPlot (panelHandle, PANEL_WAVEFORM, -1, VAL_DELAYED_DRAW);

				
				
				// ----- alloc memory for data -----
				for (i=0; i<lChannels; i++)
					pnData[i] = (short*) malloc (lBytesPerSample * lMemsize);
				pnTmp = (short*) malloc (lBytesPerSample * lMemsize * lChPerMod);
				
				
				
				// ----- set the 8 bit data pointers to the same adress -----
				for (i=0; i<lChannels; i++)
					pbyData[i] = (char*) pnData[i];
				pbyTmp = (char*) pnTmp;
				
					
				// ----- the data handling depends on the data type that this board uses: 8 bit or 16 bit -----
				switch (lBytesPerSample)
				{
					// ----- all 8 bit boards -----
					case 1:
					
						// ----- read data and split it in the channels -----
						for (i=0; i<lModules; i++)
						{
						
							nErr = SpcGetData (0, i, 0, lChPerMod * lMemsize, (void*) pbyTmp);
							for (j=0; j<lMemsize; j++)
								for (k=0; k<lChPerMod; k++)
									pbyData[i*lChPerMod + k][j] = pbyTmp[lChPerMod * j + k];
						}
									
						// ----- plot all channels -----
						for (i=0; i<lChannels; i++)
							PlotY (panelHandle, PANEL_WAVEFORM, pbyData[i], lMemsize, VAL_CHAR, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, lChColor[i]);
						break;
				
					// ----- all 12, 14 and 16 bit boards have 16 bit data -----
					case 2:
						for (i=0; i<lModules; i++)
						{
						
							nErr = SpcGetData (0, i, 0, lChPerMod * lMemsize, (void*) pnTmp);
							for (j=0; j<lMemsize; j++)
								for (k=0; k<lChPerMod; k++)
									pnData[i*lChPerMod + k][j] = pnTmp[lChPerMod * j + k];
						}
									
						// ----- plot all channels -----
						for (i=0; i<lChannels; i++)
							PlotY (panelHandle, PANEL_WAVEFORM, pnData[i], lMemsize, VAL_SHORT_INTEGER, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, lChColor[i]);
				
						break;
				}



				// ----- free memory -----
				for (i=0; i<lChannels; i++)
					free (pnData[i]);
				}
			break;
		}
	return 0;
}



// ----- Quit -----

int CVICALLBACK vQuit (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	switch (event)
		{
		case EVENT_COMMIT:
			QuitUserInterface (0);
			break;
		}
	return 0;
}
