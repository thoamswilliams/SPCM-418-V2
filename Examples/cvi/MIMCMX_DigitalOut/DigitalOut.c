#include <ansi_c.h>
#include <utility.h>
#include <cvirte.h>     
#include <userint.h>


// ----- include headers for panels and sub-panels -----
#include "DigitalOut.h"
#include "../Common/TrOut.h"
#include "../Common/Clock.h"


// ----- include the spectrum headers -----
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"


// ----- include headers for common functions -----
#include "../Common/SpcDrvInterface.h"
#include "../Common/TrOutDef.h"
#include "../Common/ClockDef.h"
#include "../Common/Info.h"

#include "72Levels.h"
#include "72LevelDef.h"



// ----- setup structures from different sub panels -----
struct _ST_SYSTEM_INFO g_stSystemInfo;
struct _ST_TROUT_DEF g_stTrigOut;
struct _ST_CLOCK_DEF g_stClockDef;
struct _ST_72LEVELS_DEF g_stLevelsDef;



// ******************************************************************
// Prototypes
// ******************************************************************

void vStartOutput(void);



static int g_hMain;
static short g_nIdx;



// ******************************************************************
// Main Task
// ******************************************************************

int main (int argc, char *argv[])
{
    int hInfoPanel, i;
    
    
    if (InitCVIRTE (0, argv, 0) == 0)
        return -1;  /* out of memory */
        
        
    // ----- init driver -----      
    if (!bInitSpcDrvInterface())
        return -1;

    // ----- read card details and display information -----
    bInitAndReadSystem (&g_stSystemInfo);
    vDisplaySystemInfo (&g_stSystemInfo);

    
    // ----- search for 1st card that the example supports -----
    if (!bCheckForFirstSupportedCard (&g_stSystemInfo, &g_nIdx, 0xFF00, 0x7200))
        return 0;
    
    
    // ----- load the main panel -----
    if ((g_hMain = LoadPanel (0, "DigitalOut.uir", PANEL)) < 0)
        return -1;
                                      
    // ----- Setup Info Panel -----
    hInfoPanel = LoadPanel (g_hMain, "..\\Common\\Info.uir", SP_INFO);
    vFillCardInfoPanel (&g_stSystemInfo.stCards[g_nIdx], hInfoPanel);
   
    
    
    // ----- Setup Trigger Output -----
    g_stTrigOut.hPanel = LoadPanel (g_hMain, "..\\Common\\TrOut.uir", SP_TROUT);
    
    g_stTrigOut.lModeMask = TROUT_MODE_SINGLESHOT | TROUT_MODE_CONTINOUS;
    if (g_stSystemInfo.stCards[g_nIdx].lFeatures & PCIBIT_MULTI)
        g_stTrigOut.lModeMask |= TROUT_MODE_MULTI;
    if (g_stSystemInfo.stCards[g_nIdx].lFeatures & PCIBIT_GATE)
        g_stTrigOut.lModeMask |= TROUT_MODE_GATE;
        
    // ----- default settings -----
    g_stTrigOut.lTriggermode = TM_SOFTWARE;
    g_stTrigOut.lTermination = 0;
    g_stTrigOut.lOutput = 0;
    g_stTrigOut.lMemsize = 8192;
    g_stTrigOut.lSegmentsize = 1024;
    g_stTrigOut.lMode = TROUT_MODE_SINGLESHOT;

    vTrigOutSetupWrite (&g_stTrigOut);
    
    

    
    // ----- Setup clock panel -----
    g_stClockDef.hPanel = LoadPanel (g_hMain, "..\\Common\\Clock.uir", SP_CLOCK);
    
    g_stClockDef.lMinClock = 1000;
    switch (g_stSystemInfo.stCards[g_nIdx].lBrdType & 0x000072f0)
    {
        case 0x7210: g_stClockDef.lMaxClock = 10000000; break;
        case 0x7220: g_stClockDef.lMaxClock = 40000000; break;
    }
    
    // ----- define the different external ranges. See hardware manual for details -----
    g_stClockDef.lExtRangeMask = EXRANGE_SINGLE | EXRANGE_BURST_S | EXRANGE_BURST_M;
    
    // ----- default settings -----
    g_stClockDef.lSamplerate = 1000000;
    g_stClockDef.lExternalClock = 0;
    g_stClockDef.lClockOutput = 0;
    g_stClockDef.lClockTermination = 0;
    g_stClockDef.lReferenceClock = 0;
    g_stClockDef.lExtRange = EXRANGE_SINGLE;
    
    vClockSetupWrite (&g_stClockDef);
    

    
    // ----- Setup levels panel -----
    g_stLevelsDef.hPanel = LoadPanel (g_hMain, "72Levels.uir", SP_LEVEL);

    switch (g_stSystemInfo.stCards[g_nIdx].lBrdType & 0x0000ffff)
    {
        case 0x7210:
        case 0x7220:
            g_stLevelsDef.lMaxChannel = 16;
            break;
            
        default:
            g_stLevelsDef.lMaxChannel = 32;
            break;
    }
    
    // ----- default settings -----
    for (i=0; i<8; i++)
    {
        g_stLevelsDef.lLowLevel[i] = 0;
        g_stLevelsDef.lHighLevel[i] = 3300;
    }
    vLevelsSetupWrite (&g_stLevelsDef);
    
    
    // ----- display panel position sub panels -----
    DisplayPanel (g_hMain);
    
    DisplayPanel (g_stTrigOut.hPanel);
    SetPanelPos (g_stTrigOut.hPanel, 85, 5);
    
    DisplayPanel (hInfoPanel);
    SetPanelPos (hInfoPanel, 5, 5);
    
    DisplayPanel (g_stClockDef.hPanel);
    SetPanelPos (g_stClockDef.hPanel, 85, 210);
    
    DisplayPanel (g_stLevelsDef.hPanel);
    SetPanelPos (g_stLevelsDef.hPanel, 25, 415);                     
    
    RunUserInterface ();
    
    
    
    // ----- clean up -----
    DiscardPanel (g_stLevelsDef.hPanel);
    DiscardPanel (hInfoPanel);
    DiscardPanel (g_stTrigOut.hPanel);
    DiscardPanel (g_stClockDef.hPanel);
    DiscardPanel (g_hMain);
    
    // ----- free the driver dll -----
    vFreeSpcDrvInterface();
    
    return 0;
}



// ******************************************************************
// Quit Button
// ******************************************************************

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



// ******************************************************************
// Start Button
// ******************************************************************

int CVICALLBACK vStartCallback (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
        {
        case EVENT_COMMIT:
            vStartOutput();
            break;
        }
    return 0;
}



// ******************************************************************
// Stop Button
// ******************************************************************

int CVICALLBACK vStopCallback (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    switch (event)
        {
        case EVENT_COMMIT:
            (*SpcSetParam) (g_nIdx, SPC_COMMAND, SPC_STOP);
            break;
        }
    return 0;
}



// ******************************************************************
// Status timer: this function is permanently checking for
// status and controls the look of the buttons
// ******************************************************************

int CVICALLBACK vPollStatusTimer (int panel, int control, int event,
        void *callbackData, int eventData1, int eventData2)
{
    int lStatus;
    char bRunning;
    
    switch (event)
        {
        case EVENT_TIMER_TICK:
            (*SpcGetParam) (g_nIdx, SPC_STATUS, &lStatus);
            switch (lStatus)
            {
                case SPC_RUN:
                    SetCtrlVal (g_hMain, PANEL_STATUS, "Waiting for Trigger...");
                    bRunning = 1;
                    break;
                    
                case SPC_TRIGGER:
                    SetCtrlVal (g_hMain, PANEL_STATUS, "Output running...");
                    bRunning = 1;
                    break;
                    
                case SPC_READY:
                    SetCtrlVal (g_hMain, PANEL_STATUS, "Idle");
                    bRunning = 0;
                    break;
            }
            
            // enable/disable buttons
            SetInputMode (g_hMain, PANEL_START, !bRunning);
            SetInputMode (g_hMain, PANEL_STOP,   bRunning);
            break;
        }
    return 0;
}



// ******************************************************************
// vStartOutput: setup the card, generate data and start the output
// ******************************************************************
// If changing to 8 bit mode the data types and memory allocation
// founction have to be adopted to use char instead of short
// ******************************************************************

void vStartOutput ()
{
    int lChannels, lChEnable;
    short* pnData[2];
    char* pbyData[2];
    int i, j, k, lErrorCode;

    
    // ----- get settings from the sub panels first ----
    vLevelsSetupRead();
    vClockSetupRead();
    vTrigOutSetupRead();
    

    // ----- static setup of the output channels for example, all channels are enabled -----
    switch (g_stSystemInfo.stCards[g_nIdx].lBrdType & 0x0000ffff)
    {
        case 0x7210:                // one 16 bit channel
        case 0x7220:
            lChannels = 1;              
            lChEnable = MOD0_16BIT;
            break;

        default:
            lChannels = 2;          // two 16 bit channels
            lChEnable = MOD0_16BIT | MOD1_16BIT;
            break;
    }        


    // ----- mode settings -----
    (*SpcSetParam) (g_nIdx, SPC_SINGLESHOT,     (g_stTrigOut.lMode == TROUT_MODE_SINGLESHOT));        // singleshot mode
    (*SpcSetParam) (g_nIdx, SPC_OUTONTRIGGER,   1);                                                   // set to 1 for singleshot and continous mode
    (*SpcSetParam) (g_nIdx, SPC_MULTI,          (g_stTrigOut.lMode == TROUT_MODE_MULTI));             // no Multiple Recording (option must be installed on board to use it)
    (*SpcSetParam) (g_nIdx, SPC_GATE,           (g_stTrigOut.lMode == TROUT_MODE_GATE));              // no Gated Sampling (option must be installed on board to use it)



    // ----- trigger settings -----
    (*SpcSetParam) (g_nIdx, SPC_MEMSIZE,        g_stTrigOut.lMemsize);            // memsize for recording
    (*SpcSetParam) (g_nIdx, SPC_POSTTRIGGER,    g_stTrigOut.lSegmentsize);        // posttrigger = segment size
    (*SpcSetParam) (g_nIdx, SPC_TRIGGEROUT,     g_stTrigOut.lOutput);             // enable trigger output
    (*SpcSetParam) (g_nIdx, SPC_TRIGGER110OHM0, g_stTrigOut.lTermination);        // trigger input termination not used (internal trigger)
    (*SpcSetParam) (g_nIdx, SPC_TRIGGER110OHM1, g_stTrigOut.lTermination);        // trigger input termination not used (internal trigger)
    (*SpcSetParam) (g_nIdx, SPC_TRIGGERMODE,    g_stTrigOut.lTriggermode);       


    
    // ----- select channels and mode for output -----
    (*SpcSetParam) (g_nIdx, SPC_DIFFMODE,       0);                               // Single-ended 
    (*SpcSetParam) (g_nIdx, SPC_CHENABLE,       lChEnable);                       // Enable the channels and width as selected before

    
    
    // ----- clock settings -----
    (*SpcSetParam) (g_nIdx, SPC_SAMPLERATE,     g_stClockDef.lSamplerate);        // samplerate for replay set to 1 MHz
    (*SpcSetParam) (g_nIdx, SPC_EXTERNALCLOCK,  g_stClockDef.lExternalClock);     // clock source = internal clock
    (*SpcSetParam) (g_nIdx, SPC_REFERENCECLOCK, g_stClockDef.lReferenceClock);    // reference clock settings
    (*SpcSetParam) (g_nIdx, SPC_EXTERNRANGE,    g_stClockDef.lExtRange);          // range for external clock
    (*SpcSetParam) (g_nIdx, SPC_CLOCKOUT,       g_stClockDef.lClockOutput);       // enable the clock output
    (*SpcSetParam) (g_nIdx, SPC_CLOCK110OHM,    g_stClockDef.lClockTermination);  // clock input termination not used  (internal clock is used)



    // ----- Setup the enable mask -----
    (*SpcSetParam) (g_nIdx, SPC_BITENABLE, 0xFFFFFFFF);          // IMPORTANT NOTE: All output bits are enabled.
                                                                 //                 The outputs are disabled by default !!!!


    // ----- behavior of the outputs after replay -----    
    (*SpcSetParam) (g_nIdx, SPC_STOPLEVEL0,     0);              // After the replay all outputs of module0 will be tristate
    (*SpcSetParam) (g_nIdx, SPC_STOPLEVEL1,     0);              // After the replay all outputs of module1 will be tristate



    // ----- logic level setup -----
    for (j=0; j<8; j++)
    {
        (*SpcSetParam) (g_nIdx, SPC_LOWLEVEL0 + j,  g_stLevelsDef.lLowLevel[j]); 
        (*SpcSetParam) (g_nIdx, SPC_HIGHLEVEL0 + j, g_stLevelsDef.lHighLevel[j]);
    }


                                                                 
    // ----- allocate memory for data -----
    for (j=0; j<lChannels; j++)
        {
        pnData[j] = (short*) malloc (g_stTrigOut.lMemsize * sizeof (short));
        if (!pnData[j])
            {
            printf ("Memory allocation error !\n");
            return;
            }
        }



    // ----- generate sample data (simple counter) -----
    for (j=0; j < lChannels; j++)
        for (k=0; k < (g_stTrigOut.lMemsize); k++)
            pnData[j][k] = (short) k;



    // ----- write test data to board (depending on board version) -----
    for (j=0; j<lChannels; j++)
        (*SpcSetData) (g_nIdx, j, 0, g_stTrigOut.lMemsize, (short*) pnData[j]);
    

    // ----- check for errors -----
    if (bCheckAndDisplayErrorInfo (&g_stSystemInfo.stCards[g_nIdx]))
        return;
    

    // ----- start the board (polling mode) -----
    (*SpcSetParam) (g_nIdx, SPC_COMMAND, SPC_START);         // start and check for errors
    
    
    
    // ----- free the data arrays ----
    for (j=0; j < lChannels; j++)
        free (pnData[j]);   

}


