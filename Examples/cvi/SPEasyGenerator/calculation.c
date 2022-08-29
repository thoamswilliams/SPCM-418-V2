//********************************************************************************************************************** 
//*****																					 (c) Spectrum GmbH 01/2005 *****
//*****																											   *****
//*****   	 			LabWindows / CVI Function Generator for MI_MC_MX 60xx or MI_MC_MX 61xx					   *****
//*****																											   *****	
//**********************************************************************************************************************
//*****																											   ***** 
//*****  Filename 	 : calculation.c     																		   *****	
//*****																											   *****	    
//*****  Description : This module contains all functions to calculate the samplerate, the memsize and the data,   *****
//*****				   to setup the board.																		   *****
//*****																											   *****
//**********************************************************************************************************************


#include <ansi_c.h>
#include <boardControl.h>

// ----- include the spectrum headers -----
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"

#define PI 					 3.141592

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
	

//*********************************************************************************************************************
//***** FunctionCall : lGetBlockSize (lPeriod) 																	  *****  																
//*****																											  *****
//***** ReturnCode   : 0 		  : No matching blocksize found												      *****							     
//*****				   lBlockSize : Matching blocksize found 													  *****
//*****																											  *****
//***** Description  : This function seeks for a matching blocksize that fits to the refered period.              *****
//*********************************************************************************************************************

int lGetBlockSize (int lPeriod)
{
	int lBlockSize;
	int i;
	
	
	lBlockSize = lPeriod;

	for(i=0;i<100;i++)
	{
		if (lBlockSize % 32 == 0) return lBlockSize;
		lBlockSize += lPeriod;
	}
	
	return 0;
}
		   
//*********************************************************************************************************************
//***** FunctionCall : vGetCalcData (&stCalcData, &stBoardInfo, stGuiSettings)      						      *****  																
//*****																											  *****
//***** ReturnCode   : -																						  *****
//*****																											  *****
//***** Description  : This function calculates the samplerate, memsize, blocksize and the number of samples per  *****
//*****				   period. The values will be written to the struct stCalcData for later use.				  *****
//*********************************************************************************************************************

void vGetCalcData (struct _CALC_DATA *stCalcData, struct _BOARD_INFO *stBoardInfo, struct _GUI_SETTINGS *stGuiSettings)
{
	double dFreq;   
	double dSamplerateCalc;
	double dDelta;
	double dOptimumDelta;
	long   lSamplerateReadBoard;
	int lPeriod;
	int lSetPeriod;
	int lBlockSize = 0;
	int hDrv;      
	
	
	dFreq = stGuiSettings->dFrequency;
	hDrv  = stBoardInfo->hDrv;

	dOptimumDelta = stGuiSettings->dMaxFrequency;
 
	// ----- set number of samples per period -----
	for(lSetPeriod = PERIOD_START; lSetPeriod >= PERIOD_MIN; lSetPeriod -= PERIOD_MIN)
	{
		if (stGuiSettings->dFrequency < stBoardInfo->lMaxSamplerate / lSetPeriod)
		{
		 	lPeriod = lSetPeriod;
			break;
		}
						
		if (lSetPeriod <= PERIOD_MIN) 
		{
			// ----- max frequency reached -----
			lPeriod = PERIOD_MIN;
			dFreq = stBoardInfo->lMaxSamplerate / lPeriod; 
		}
	}
  
	
	// ----- calculate optimal samplerate and memsize ----- 
	while ((lPeriod <= PERIOD_MAX))
	{
		dSamplerateCalc = dFreq * lPeriod;

		if (dSamplerateCalc >= 1000) // ignore samplerates below 1000
		{
			if (dSamplerateCalc > stBoardInfo->lMaxSamplerate)
				break;
			
			// ----- set samplerate to register -----
			SpcSetParam (hDrv, SPC_SAMPLERATE, (long)dSamplerateCalc);       
			
			// ----- get samplerate from register -----
			SpcGetParam (hDrv, SPC_SAMPLERATE, &lSamplerateReadBoard);

			dDelta = fabs (dFreq - ((double)lSamplerateReadBoard/(double)lPeriod));
			
			if (dDelta < dOptimumDelta)
			{
				lBlockSize = lGetBlockSize (lPeriod);
				
				if (lBlockSize > 0)
				{
				 	dOptimumDelta       = dDelta;
					stCalcData->lSamplerate = lSamplerateReadBoard;
					stCalcData->lPeriod     = lPeriod;
				}
			}

			if (dDelta == 0) 
				break;
		}
		lPeriod += 1;
	}

	stCalcData->lBlockSize = lBlockSize;
	stCalcData->lMemsize   = 8 * lBlockSize;

}
				  
//*********************************************************************************************************************
//***** FunctionCall : pnCalculateSampleData (&stCalcData, stGuiSettings, &stBoardInfo, lChannel)      			  *****  																
//*****																											  *****
//***** ReturnCode   : pnData																					  *****
//*****																											  *****
//***** Description  : This function calculates the phase shifted waveform data, that will be written to the      *****
//*****				   board memory.																		      *****
//*********************************************************************************************************************

short* pnCalculateSampleData (struct _CALC_DATA *stCalcData, struct _GUI_SETTINGS *stGuiSettings, struct _BOARD_INFO *stBoardInfo, 
					          int lChannel)
{
	int lSamplesPerPeriod, lBlockSize;
	int lIndexBlock, lIndexMemsize;
	int lCalcStart;
	double dMultipl, dRange; 
	short *pnData;
	int i, idx1, idx2;
			   
	lBlockSize        = stCalcData->lBlockSize * stGuiSettings->lDividerCh[lChannel];			 
	lSamplesPerPeriod = stCalcData->lPeriod * stGuiSettings->lDividerCh[lChannel];        
	
	
	// ----- set resolution for 8 bit or 14 bit samples -----
	if (stBoardInfo->lBytesPerSample == 1)
		 dRange =  127.0;
	else dRange = 8191.0;

	// ----- allocate memory -----
	pnData = (short*) malloc (2 * stCalcData->lMemsize);  
	
	
	
	// ----- calculate phase shift for the sample data -----
	
	
	// ----- calculate the beginning point of the waveform calculation, to get the phase shifted sample data -----
	dMultipl = (double)stGuiSettings->lPhaseCh[lChannel] / 360.0;
	
	if (stGuiSettings->lPhaseCh[lChannel] < 0)
		lCalcStart = (1 + dMultipl) * lSamplesPerPeriod;
	else 
		lCalcStart = dMultipl * lSamplesPerPeriod;
		
	
	// ----- calculate phase shifted waveform -----
	for (i=0;i<2;i++)
	{
		if (i)
		{
			idx2 = 0;
		}
		else
		{
			idx1 = 0;
			idx2 = lCalcStart;
		}
		
		
		for (idx1; (idx1 < lBlockSize) && (idx2 < lBlockSize); idx1++)
		{
			switch(stGuiSettings->lWaveformCh[lChannel])
			{
				case SINE 		: pnData[idx1] = (short) (dRange * sin (2.0 * PI * idx2 / lSamplesPerPeriod)); 
								  break;
								  
				case RECTANGLE  : pnData[idx1] = (short) ((idx2%lSamplesPerPeriod) < lSamplesPerPeriod/2 ? dRange : - dRange);
								  break;
				
				case TRIANGLE   : if ((idx2%lSamplesPerPeriod >= 0) && (idx2%lSamplesPerPeriod <= lSamplesPerPeriod/4))
								  	pnData[idx1] = (short) 4*dRange/lSamplesPerPeriod * (idx2%lSamplesPerPeriod);
							 	  else
							  	  {
							  		if ((idx2%lSamplesPerPeriod > lSamplesPerPeriod/4) && (idx2%lSamplesPerPeriod < 3*lSamplesPerPeriod/4))
							  			pnData[idx1] = (short) -4*dRange/lSamplesPerPeriod * (idx2%lSamplesPerPeriod) + 2*dRange;
							  		else
							  		{	
							  			pnData[idx1] = (short)  4*dRange/lSamplesPerPeriod * (idx2%lSamplesPerPeriod) - 4*dRange;
							  			if (pnData[idx1] < -dRange) pnData[idx1] = -dRange;     
							  		
							  		}	
							  		
							  	  }
							  	  break;
			}
			idx2++;
		}
	}
	
	// ----- fill the whole memory with sample blocks -----
	lIndexMemsize = lBlockSize;
	lIndexBlock = 0;
	for (;lIndexMemsize<stCalcData->lMemsize;lIndexMemsize++)
	{
		pnData[lIndexMemsize] = pnData[lIndexBlock];
		lIndexBlock++;
		lIndexBlock %= lBlockSize;
	}

	return pnData;
}









