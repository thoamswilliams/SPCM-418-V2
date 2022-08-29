// ******************************************************************
// TrOut.c
// ******************************************************************
// Handles trigger settings for output cards
// ******************************************************************


#include <cvirte.h>     
#include <userint.h>

#include "TrOut.h"
#include "TrOutDef.h"


// ----- include the spectrum headers -----
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"





struct _ST_TROUT_DEF* g_pstTrigOutDef;



// ******************************************************************
// vSetTrigMode
// ******************************************************************

void vSetTriggerMode (void)
    {
    switch (g_pstTrigOutDef->lTriggermode)
        {
        case TM_SOFTWARE: SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TRIGGERMODE, 1); break;
        case TM_TTLPOS:   SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TRIGGERMODE, 2); break;
        case TM_TTLNEG:   SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TRIGGERMODE, 3); break;
        }
    }



// ******************************************************************
// SetupWrite is called after panel is loaded before it's displayed
// ******************************************************************

void vTrigOutSetupWrite (struct _ST_TROUT_DEF* pstTrOutDef)
    {                                             
    short nIdx;

    // ----- store handle for future use -----
    g_pstTrigOutDef = pstTrOutDef;


    // ----- start settings or panel -----
    SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TERMINATION, g_pstTrigOutDef->lTermination);
    SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_OUTPUT,      g_pstTrigOutDef->lOutput);

    vSetTriggerMode ();
    
    
    // ----- fill mode box -----
    nIdx = 0;   
    if (g_pstTrigOutDef->lModeMask & TROUT_MODE_SINGLESHOT)
        InsertListItem (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, nIdx++, "Singleshot", 0); 
    if (g_pstTrigOutDef->lModeMask & TROUT_MODE_CONTINOUS)
        InsertListItem (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, nIdx++, "Continous", 1); 
    if (g_pstTrigOutDef->lModeMask & TROUT_MODE_MULTI)
        InsertListItem (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, nIdx++, "Multiple Segments", 2); 
    if (g_pstTrigOutDef->lModeMask & TROUT_MODE_GATE)
        InsertListItem (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, nIdx++, "Gated", 3); 
        
    // ----- start settings for mode -----
    switch (g_pstTrigOutDef->lMode)
        {
        case TROUT_MODE_SINGLESHOT: SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, 0); break;
        case TROUT_MODE_CONTINOUS:  SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, 1); break;
        case TROUT_MODE_MULTI:      SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, 2); break;
        case TROUT_MODE_GATE:       SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, 3); break;
        }
    
    // ----- set memsize and segment size -----
    
    vTrigOutCheckSettings();
    
    }


// ******************************************************************
// SetupRead is called before programming the hardware. Triggermode
// is already stored in global structure
// ******************************************************************

void vTrigOutSetupRead ()
    {                                             

    // ----- read out missing settings -----
    GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TERMINATION, &g_pstTrigOutDef->lTermination);
    GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_OUTPUT,      &g_pstTrigOutDef->lOutput);
    GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_SEGMENTSIZE, &g_pstTrigOutDef->lSegmentsize);
    GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MEMSIZE,     &g_pstTrigOutDef->lMemsize);
    }



// ******************************************************************
// check settings and dimm and correct controls
// ******************************************************************

void vTrigOutCheckSettings ()
    {

    // ----- some modes didn't allow software trigger -----
    if (g_pstTrigOutDef->lTriggermode == TM_SOFTWARE)
        switch (g_pstTrigOutDef->lMode)
            {
            case TROUT_MODE_MULTI:
            case TROUT_MODE_GATE:
            case TROUT_MODE_FIFOMULTI:
            case TROUT_MODE_FIFOGATE:
                g_pstTrigOutDef->lTriggermode = TM_TTLPOS;
                break;
            }
        
    // ----- segment size is available depending on mode -----
    switch (g_pstTrigOutDef->lMode)
        {
        case TROUT_MODE_MULTI:
        case TROUT_MODE_FIFOMULTI:
            SetInputMode (g_pstTrigOutDef->hPanel, SP_TROUT_SEGMENTSIZE, 1);
            break;
            
        default:
            SetInputMode (g_pstTrigOutDef->hPanel, SP_TROUT_SEGMENTSIZE, 0);
            break;
        }
    
                               
    // ----- enable/disable checkboxes -----            
    SetInputMode (g_pstTrigOutDef->hPanel, SP_TROUT_TERMINATION, (g_pstTrigOutDef->lTriggermode != TM_SOFTWARE));
    SetInputMode (g_pstTrigOutDef->hPanel, SP_TROUT_OUTPUT,      (g_pstTrigOutDef->lTriggermode == TM_SOFTWARE));
            
    // ----- set to matching value -----
    if (g_pstTrigOutDef->lTriggermode != TM_SOFTWARE)
        SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_OUTPUT, 0);
    if (g_pstTrigOutDef->lTriggermode == TM_SOFTWARE)
        SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TERMINATION, 0);
    }
    
            
                

// ******************************************************************
// Hide/Show checkboxes depending on selected mode
// ******************************************************************

int CVICALLBACK vTriggermodeCallback (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
    int lTriggermode;

    switch (event)
        {
        case EVENT_VAL_CHANGED:

            // ----- read new trigger mode -----
            GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_TRIGGERMODE, &lTriggermode);
            
            switch (lTriggermode)
                {
                case 1: g_pstTrigOutDef->lTriggermode = TM_SOFTWARE; break;
                case 2: g_pstTrigOutDef->lTriggermode = TM_TTLPOS; break;
                case 3: g_pstTrigOutDef->lTriggermode = TM_TTLNEG; break;
                }
            
            lTriggermode = g_pstTrigOutDef->lTriggermode;
            vTrigOutCheckSettings();
            if (lTriggermode != g_pstTrigOutDef->lTriggermode)
                MessagePopup ("Triggermode", "Triggermode is not allowed when using this mode");
            
            vSetTriggerMode();          
            
            break;
        }
    return 0;
    }



// ******************************************************************
// Mode changed
// ******************************************************************

int CVICALLBACK vModeCallback (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
    int lMode;

    switch (event)
        {
        case EVENT_VAL_CHANGED:

            // ----- read new trigger mode -----
            GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MODE, &lMode);
            
            switch (lMode)
                {
                case 0: g_pstTrigOutDef->lMode = TROUT_MODE_SINGLESHOT; break;
                case 1: g_pstTrigOutDef->lMode = TROUT_MODE_CONTINOUS; break;
                case 2: g_pstTrigOutDef->lMode = TROUT_MODE_MULTI; break;
                case 3: g_pstTrigOutDef->lMode = TROUT_MODE_GATE; break;
                }
            
            vTrigOutCheckSettings();
            vSetTriggerMode();          
            
            break;
        }
    return 0;
    }
        


// ******************************************************************
// Memsize and Segmentssize changed. Check for 32 samples stepsize
// ******************************************************************

int CVICALLBACK vMemsizeCallback (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
    switch (event)
        {
        case EVENT_VAL_CHANGED:

            // ----- read new trigger mode -----
            GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MEMSIZE, &g_pstTrigOutDef->lMemsize);
            g_pstTrigOutDef->lMemsize = ((g_pstTrigOutDef->lMemsize >> 5) << 5);
            SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_MEMSIZE,  g_pstTrigOutDef->lMemsize);
            break;
        }
    return 0;
    }

// ******************************************************************

int CVICALLBACK vSegmentsizeCallback (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
    switch (event)
        {
        case EVENT_VAL_CHANGED:

            // ----- read new trigger mode -----
            GetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_SEGMENTSIZE, &g_pstTrigOutDef->lSegmentsize);
            g_pstTrigOutDef->lMemsize = ((g_pstTrigOutDef->lSegmentsize >> 5) << 5);
            SetCtrlVal (g_pstTrigOutDef->hPanel, SP_TROUT_SEGMENTSIZE,  g_pstTrigOutDef->lSegmentsize);
            
            
            break;
        }
    return 0;
    }
