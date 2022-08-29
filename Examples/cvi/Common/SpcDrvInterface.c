// ******************************************************************
// Interface to spectrum.dll and some basic initialisation routines
// ******************************************************************


#include <ansi_c.h>
#include <userint.h>
#include <utility.h>


#define SPCDRVINTERFACE
#include "SpcDrvInterface.h"
#include "Info.h"

#include "..\c_header\regs.h"
#include "..\c_header\spcerr.h"

// ----- handle for Spectrum driver interface -----
int g_hSpcDrv = 0;



// ******************************************************************
// internal helper functions
// ******************************************************************

void vPrintfBrdType (char* szTmp, int lBrdType);




// ******************************************************************
// InitSpcDrvInterface: make the link to the driver and load all
// the functions we need.
// ******************************************************************

char bInitSpcDrvInterface (void)
{
    int lStatus;

    // ----- load the driver entries from the DLL -----
    g_hSpcDrv = LoadExternalModule ("..\\c_header\\spectrum.lib");
    if (g_hSpcDrv < 0)
        return -1;  // DLL not found 

    // ----- Load functions from DLL -----
    SpcInitPCIBoards = (SPCINITPCIBOARDS*) GetExternalModuleAddr (g_hSpcDrv, "SpcInitPCIBoards", &lStatus);
    SpcInitBoard =     (SPCINITBOARD*)     GetExternalModuleAddr (g_hSpcDrv, "SpcInitBoard", &lStatus);
    SpcSetParam =      (SPCSETPARAM*)      GetExternalModuleAddr (g_hSpcDrv, "SpcSetParam", &lStatus);
    SpcGetParam =      (SPCGETPARAM*)      GetExternalModuleAddr (g_hSpcDrv, "SpcGetParam", &lStatus);
    SpcSetData =       (SPCSETDATA*)       GetExternalModuleAddr (g_hSpcDrv, "SpcSetData", &lStatus);
    SpcGetData =       (SPCGETDATA*)       GetExternalModuleAddr (g_hSpcDrv, "SpcGetData", &lStatus);
    
    return 1;
}



// ******************************************************************
// FreeSpcDrvInterface: free the dll
// ******************************************************************

void vFreeSpcDrvInterface (void)
{
    if (g_hSpcDrv)
        UnloadExternalModule (g_hSpcDrv);
    g_hSpcDrv = 0;
}



// ******************************************************************
// ReadSystemInfo: Check for installed cards and read information
// of driver and cards
// ******************************************************************

char bInitAndReadSystem (struct _ST_SYSTEM_INFO* pstSystemInfo)
{
    short nCount, nPCIBusVersion, i;
    int   lVersionTmp;
    
    // ----- clean up the structure ------
    pstSystemInfo->lCardsFound = 0;
    pstSystemInfo->lDriverVersion = 0;
    pstSystemInfo->lKernelVersion = 0;
    pstSystemInfo->nInitError = (*SpcInitPCIBoards) (&nCount, &nPCIBusVersion);
    
    if (!pstSystemInfo->nInitError)
    {
    
        (*SpcGetParam) (0, SPC_GETDRVVERSION, &pstSystemInfo->lDriverVersion);
        (*SpcGetParam) (0, SPC_GETKERNELVERSION, &pstSystemInfo->lKernelVersion);
        
        // ----- read out information form each card that was found -----
        pstSystemInfo->lCardsFound = nCount;
        for (i=0; i<pstSystemInfo->lCardsFound; i++)
        {
            pstSystemInfo->stCards[i].lIdx = i;
            (*SpcGetParam) (i, SPC_PCITYP,          &pstSystemInfo->stCards[i].lBrdType);
            (*SpcGetParam) (i, SPC_PCISERIALNO,     &pstSystemInfo->stCards[i].lSerialNumber);
            (*SpcGetParam) (i, SPC_PCIMEMSIZE,      &pstSystemInfo->stCards[i].lMemsize);
            (*SpcGetParam) (i, SPC_PCIVERSION,      &lVersionTmp);
            pstSystemInfo->stCards[i].lVersionBase = (lVersionTmp >> 8) & 0xff;
            pstSystemInfo->stCards[i].lVersionModule = lVersionTmp & 0xff;
            (*SpcGetParam) (i, SPC_PCIFEATURES,     &pstSystemInfo->stCards[i].lFeatures);
            
        }
        
        return 1;   // init ok;
    }
    
    return 0;       // init failed
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
        
        sprintf (szTmp, "   Serial Number: %05d\n", pstSystemInfo->stCards[i].lSerialNumber);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Memory Size: %d MBytes\n", pstSystemInfo->stCards[i].lMemsize / 1024 / 1024);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Version Base: V%d\n", pstSystemInfo->stCards[i].lVersionBase);
        strcat (szBuffer, szTmp);
        sprintf (szTmp, "   Version Module: V%d\n", pstSystemInfo->stCards[i].lVersionModule);
        strcat (szBuffer, szTmp);

        // ----- features prining -----
        strcat (szBuffer, "   Features: ");
        if (!pstSystemInfo->stCards[i].lFeatures)
            strcat (szBuffer, "none ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_MULTI)
            strcat (szBuffer, "multi ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_GATE)
            strcat (szBuffer, "gate ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_SYNC)
            strcat (szBuffer, "sync ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_DIGITAL)
            strcat (szBuffer, "digital ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_TIMESTAMP)
            strcat (szBuffer, "time ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_STARHUB)
            strcat (szBuffer, "star-hub ");
        if (pstSystemInfo->stCards[i].lFeatures & PCIBIT_XIO)
            strcat (szBuffer, "extra-i/o ");
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
        case TYP_MCSERIES: sprintf (szTmp, "MC.%x", lBrdType & TYP_VERSIONMASK); break;
        case TYP_MXSERIES: sprintf (szTmp, "MX.%x", lBrdType & TYP_VERSIONMASK); break;
        case TYP_MISERIES: sprintf (szTmp, "MI.%x", lBrdType & TYP_VERSIONMASK); break;
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
    int lErrorCode, lErrorReg, lErrorValue;
    char szTitle[100], szBoard[20], szMessage[100];

    // ----- check for error and leave function if not -----
    (*SpcGetParam) (pstCardInfo->lIdx, SPC_LASTERRORCODE, &lErrorCode);
    if (!lErrorCode)
        return 0;

    (*SpcGetParam) (pstCardInfo->lIdx, SPC_LASTERRORREG,   &lErrorReg);
    (*SpcGetParam) (pstCardInfo->lIdx, SPC_LASTERRORVALUE, &lErrorValue);
    
    
    // ----- print information -----
    vPrintfBrdType (szBoard, pstCardInfo->lBrdType);
    sprintf (szTitle, "%s sn %05d Driver Error", szBoard, pstCardInfo->lSerialNumber);
    
    switch (lErrorCode)
    {
        case ERR_FNCNOTSUPPORTED:
            sprintf (szMessage, "Function not supported by hardware at Register %d at Value %d", lErrorReg, lErrorValue);
            break;

        case ERR_REG:
            sprintf (szMessage, "Register %d not valid for Board", lErrorReg);
            break;

        case ERR_VALUE:
            sprintf (szMessage, "Value %d not in valid range for Register %d", lErrorValue, lErrorReg);
            break;
        
        default:
            sprintf (szMessage, "Unknown Error Code %d in Register %d at Value %d", lErrorCode, lErrorReg, lErrorValue);
            break;
    }
    
    MessagePopup (szTitle, szMessage);
    
        
    return 1;
}



// ******************************************************************
// CheckForFirstSupportedCard: Serach for the first occurance of this
// card family member
// ******************************************************************

char bCheckForFirstSupportedCard (struct _ST_SYSTEM_INFO* pstSystemInfo, short* pnBrdIdx, int lBrdMask, int lBrdType)
{
    for (*pnBrdIdx = 0; *pnBrdIdx < pstSystemInfo->lCardsFound; (*pnBrdIdx)++)
        if ((pstSystemInfo->stCards[*pnBrdIdx].lBrdType & lBrdMask) == lBrdType)
            break;
            
    // ----- check wheather we found something that we support -----       
    if (*pnBrdIdx == pstSystemInfo->lCardsFound)
    {
        MessagePopup ("Example Error", "No card was found in system that is supported by this example");
        vFreeSpcDrvInterface();
        
        return 0;
    }
    
    return 1;
}
