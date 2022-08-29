// ******************************************************************
// Interface to spcm_win32.dll and some basic initialisation routines
// ******************************************************************


#include <ansi_c.h>
#include <userint.h>
#include <utility.h>


#include "..\c_header\dlltyp.h"
#include "..\c_header\regs.h"
#include "..\c_header\spcerr.h"
#include "..\c_header\spcm_drv.h"

#define SPCDRVINTERFACE
#include "clockdef.h"
#include "SpcMDriver.h"
#include "Info.h"



// ----- handle for Spectrum driver interface -----
int g_hSpcDrv = 0;



// ******************************************************************
// internal helper functions
// ******************************************************************

void vPrintfBrdType (char* szTmp, int lBrdType);





// ******************************************************************
// ReadSystemInfo: Check for installed cards and read information
// of driver and cards
// ******************************************************************

char bInitAndReadSystem (struct _ST_SYSTEM_INFO* pstSystemInfo)
{
    short 	i;
    char	szDriverName[100];
	int32   lTmp;
	drv_handle hTmp;
	

    // ----- clean up the structure ------
    pstSystemInfo->lCardsFound = 0;
    pstSystemInfo->lDriverVersion = 0;
    pstSystemInfo->lKernelVersion = 0;

    
	// ----- try to open all cards -----
	for (i = 0; i < MAXBRD; i++)
	{
		sprintf (szDriverName, "spcm%d", i);
		pstSystemInfo->stCards[i].hDrv = spcm_hOpen (szDriverName);
		if (!pstSystemInfo->stCards[i].hDrv)
			break;
			
		pstSystemInfo->lCardsFound++;		
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_GETDRVVERSION, 	&pstSystemInfo->lDriverVersion);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_GETKERNELVERSION, 	&pstSystemInfo->lKernelVersion);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCITYP,          	&pstSystemInfo->stCards[i].lBrdType);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_FNCTYPE,          	&pstSystemInfo->stCards[i].lCardFunction);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCISERIALNO,     	&pstSystemInfo->stCards[i].lSerialNumber);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCIMEMSIZE,      	&pstSystemInfo->stCards[i].lMemsize);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCIVERSION,      	&pstSystemInfo->stCards[i].lVersionBase);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCIMODULEVERSION,  &pstSystemInfo->stCards[i].lVersionModule);
        spcm_dwGetParam_i32 (pstSystemInfo->stCards[i].hDrv, SPC_PCIFEATURES,     	&pstSystemInfo->stCards[i].lFeatures);
		
	}
	return (pstSystemInfo->lCardsFound != 0);
}



// ******************************************************************
// vFillClockDef: fill the clock definition from the driver
// ******************************************************************

void vFillClockDef (struct _ST_CARD_INFO* pstCardInfo, struct _ST_CLOCK_DEF* pstClockDef)
{
    pstClockDef->lMinClock = 1000;                                                     		
    spcm_dwGetParam_i32 (pstCardInfo->hDrv, SPC_MIINST_MAXADCLOCK, &pstClockDef->lMaxClock);
    
    pstClockDef->lExtRangeMask = EXRANGE_LOW | EXRANGE_HIGH;   
    pstClockDef->lSamplerate = pstClockDef->lMaxClock;                                                
    pstClockDef->lExternalClock = 0;                                                   
    pstClockDef->lClockOutput = 0;                                                     
    pstClockDef->lClockTermination = 0;                                                
    pstClockDef->lReferenceClock = 0;                                                  
    pstClockDef->lExtRange = EXRANGE_LOW;                                           
}



// ******************************************************************
// vCloseAllCards: closes all cards that are opened
// ******************************************************************

void vCloseAllCards (struct _ST_SYSTEM_INFO* pstSystemInfo)
{
	int i;
	
	for (i = 0; i < pstSystemInfo->lCardsFound; i++)
		spcm_vClose (pstSystemInfo->stCards[i].hDrv);
	
}



// ******************************************************************
// vDisplaySystemInfo: Popup with information
// ******************************************************************

void vDisplaySystemInfo (struct _ST_SYSTEM_INFO* pstSystemInfo)
{
    char szBuffer[1024], szTmp[256];
    int i, j;
    
    sprintf (szBuffer, "");
    
    sprintf (szTmp, "Driver DLL Version: %d.%02db%d\n", (pstSystemInfo->lDriverVersion >> 24) & 0xff, (pstSystemInfo->lDriverVersion >> 16) & 0xff, pstSystemInfo->lDriverVersion & 0xffff);
    strcat (szBuffer, szTmp);
    sprintf (szTmp, "Kernel Driver Version: %d.%02db%d\n", (pstSystemInfo->lKernelVersion >> 24) & 0xff, (pstSystemInfo->lKernelVersion >> 16) & 0xff, pstSystemInfo->lKernelVersion & 0xffff);
    strcat (szBuffer, szTmp);
    
    sprintf (szTmp, "Number of cards found: %d\n", pstSystemInfo->lCardsFound);
    strcat (szBuffer, szTmp);
    
    for (i=0; i<pstSystemInfo->lCardsFound; i++)
    {
        sprintf (szTmp, "\nBoard#%d\n", i);
        strcat (szBuffer, szTmp);

        vPrintfBrdType (szTmp, pstSystemInfo->stCards[i].lBrdType);
        strcat (szBuffer, "   Type: ");
        strcat (szBuffer, szTmp);
        strcat (szBuffer, "\n");
        
        sprintf (szTmp, "   Serial Number:%05d\n", pstSystemInfo->stCards[i].lSerialNumber);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Memory Size:%d MBytes\n", pstSystemInfo->stCards[i].lMemsize / 1024 / 1024);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Version Base: V%d.%d\n", (pstSystemInfo->stCards[i].lVersionBase >> 16), pstSystemInfo->stCards[i].lVersionBase & 0xffff);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Version Module: V%d.%d\n", (pstSystemInfo->stCards[i].lVersionModule >> 16), pstSystemInfo->stCards[i].lVersionModule & 0xffff);
        strcat (szBuffer, szTmp);

        // ----- features prining -----
        strcat (szBuffer, "   Features: ");
        if (!pstSystemInfo->stCards[i].lFeatures)
            strcat (szBuffer, "none ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_MULTI)
            strcat (szBuffer, "multi ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_GATE)
            strcat (szBuffer, "gate ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_ABA)
            strcat (szBuffer, "aba ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_DIGITAL)
            strcat (szBuffer, "digital ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_TIMESTAMP)
            strcat (szBuffer, "time ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_STARHUB5)
            strcat (szBuffer, "star-hub5 ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_STARHUB16)
            strcat (szBuffer, "star-hub16 ");
        if (pstSystemInfo->stCards[i].lFeatures & SPCM_FEAT_BASEXIO)
            strcat (szBuffer, "basexio ");
        strcat (szBuffer, "\n");
    }
    
    MessagePopup ("System Hardware and Driver Information", szBuffer);
}




// ******************************************************************
// vPrintfBrdType: helper function to generate board name
// ******************************************************************

void vPrintfBrdType (char* szTmp, int lBrdType)
{
    switch (lBrdType & TYP_SERIESMASK)
    {
        case TYP_MCSERIES:      sprintf (szTmp, "MC.%x",  lBrdType & TYP_VERSIONMASK); break;
        case TYP_MXSERIES:      sprintf (szTmp, "MX.%x",  lBrdType & TYP_VERSIONMASK); break;
        case TYP_MISERIES:      sprintf (szTmp, "MI.%x",  lBrdType & TYP_VERSIONMASK); break;
        case TYP_M2ISERIES:     sprintf (szTmp, "M2i.%x", lBrdType & TYP_VERSIONMASK); break;
        case TYP_M2IEXPSERIES:  sprintf (szTmp, "M2i.%x-Exp", lBrdType & TYP_VERSIONMASK); break;
    }
}    



// ******************************************************************
// FillCardInfoPanel
// ******************************************************************

void vFillCardInfoPanel (struct _ST_CARD_INFO* pstCardInfo, int hPanel)
{
    char szBuffer[32];
    
    vPrintfBrdType (szBuffer, pstCardInfo->lBrdType);
    SetCtrlVal (hPanel, SP_INFO_BRDTYPE, szBuffer);
    
    sprintf (szBuffer, "%05d", pstCardInfo->lSerialNumber);
    SetCtrlVal (hPanel, SP_INFO_SN, szBuffer);
}



// ******************************************************************
// bCheckAndDisplayErrorInfo: read out error info and display it
// ******************************************************************

char bCheckAndDisplayErrorInfo (struct _ST_CARD_INFO* pstCardInfo)
{
    char szTitle[100], szBoard[20], szErrorMessage[ERRORTEXTLEN];

    // ----- check for error and leave function if not -----
    if (!spcm_dwGetErrorInfo_i32 (pstCardInfo->hDrv, NULL, NULL, szErrorMessage))
        return 0;

    // ----- print information -----
    vPrintfBrdType (szBoard, pstCardInfo->lBrdType);
    sprintf (szTitle, "%s sn %05d Driver Error", szBoard, pstCardInfo->lSerialNumber);
   
    MessagePopup (szTitle, szErrorMessage);
        
    return 1;
}





