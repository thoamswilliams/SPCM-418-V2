// ******************************************************************
// Clock: Cares for some simple clock settings
// ******************************************************************

#include <cvirte.h>     
#include <userint.h>
#include <ansi_c.h>

#include "Clock.h"
#include "ClockDef.h"

// ----- include the spectrum headers -----
#include "../c_header/regs.h"
#include "../c_header/spcerr.h"


struct _ST_CLOCK_DEF* g_pstClockDef;


// default clocks for all cards
int g_plDefaultClocks[] = {1000, 2000, 5000, 10000, 20000, 50000, 100000, 200000, 500000, 1000000, 2000000, 5000000, 10000000, 20000000, 40000000, 50000000, 60000000, 70000000, 80000000, 90000000, 100000000, 200000000, -1};



// ******************************************************************
// vEnableControls
// ******************************************************************

void vEnableControls (void)
    {

    // ----- set clock source depending on the setup -----
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_CLOCKINTERNAL, !g_pstClockDef->lExternalClock && (g_pstClockDef->lReferenceClock == 0));
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_CLOCKEXTERNAL,  g_pstClockDef->lExternalClock);
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_CLOCKREFERENCE, (g_pstClockDef->lReferenceClock != 0));

    SetInputMode (g_pstClockDef->hPanel, SP_CLOCK_TERMINATION, g_pstClockDef->lExternalClock || (g_pstClockDef->lReferenceClock != 0));
    SetInputMode (g_pstClockDef->hPanel, SP_CLOCK_OUTPUT,     !g_pstClockDef->lExternalClock && (g_pstClockDef->lReferenceClock == 0));
    SetInputMode (g_pstClockDef->hPanel, SP_CLOCK_CLOCK,      !g_pstClockDef->lExternalClock || (g_pstClockDef->lReferenceClock != 0));
    SetInputMode (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE,    g_pstClockDef->lExternalClock);
    }



// ******************************************************************
// ClockSetupWrite
// ******************************************************************

void vClockSetupWrite (struct _ST_CLOCK_DEF* pstClockDef)
    {
    int i;
    short nIdx;
    char szBuffer[20];

    g_pstClockDef = pstClockDef;
    
    // ----- fill ring control with clock rates -----
    ClearListCtrl (g_pstClockDef->hPanel, SP_CLOCK_CLOCK);    
    nIdx = 0;
    for (i=0; g_plDefaultClocks[i] != -1; i++)
        if ((g_plDefaultClocks[i] >= g_pstClockDef->lMinClock) && (g_plDefaultClocks[i] <= g_pstClockDef->lMaxClock))
            {
            if (g_plDefaultClocks[i] < 1000)
                sprintf (szBuffer, "%d S/s",g_plDefaultClocks[i]);
            else if (g_plDefaultClocks[i] < 1000000)
                sprintf (szBuffer, "%d kS/s",g_plDefaultClocks[i] / 1000);
            else
                sprintf (szBuffer, "%d MS/s",g_plDefaultClocks[i] / 1000 / 1000);
            
            InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_CLOCK, nIdx++, szBuffer, g_plDefaultClocks[i]);
            }
    
    // ----- fill ring with external ranges -----
    nIdx = 0;
    ClearListCtrl (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_LOW)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Low", EXRANGE_LOW);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_HIGH)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "High", EXRANGE_HIGH);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_SINGLE)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Single", EXRANGE_SINGLE);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_BURST_S)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Burst S", EXRANGE_BURST_S);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_BURST_M)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Burst M", EXRANGE_BURST_M);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_BURST_L)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Burst L", EXRANGE_BURST_L);
    if (g_pstClockDef->lExtRangeMask & EXRANGE_BURST_XL)
        InsertListItem (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE, nIdx++, "Burst XL", EXRANGE_BURST_XL);
    
    
    // ----- fill all controls -----
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_CLOCK,       g_pstClockDef->lSamplerate);
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE,    g_pstClockDef->lExtRange);
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_OUTPUT,      g_pstClockDef->lClockOutput);
    SetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_TERMINATION, g_pstClockDef->lClockTermination);

    vEnableControls();    
    }



// ******************************************************************
// SetupRead is called before programming the hardware.
// ******************************************************************

void vClockSetupRead ()
    {                                             

    // ----- read out missing settings -----
    GetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_TERMINATION, &g_pstClockDef->lClockTermination);
    GetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_OUTPUT,      &g_pstClockDef->lClockOutput);
    GetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_CLOCK,       &g_pstClockDef->lSamplerate);
    GetCtrlVal (g_pstClockDef->hPanel, SP_CLOCK_EXTRANGE,    &g_pstClockDef->lExtRange);
    }



// ******************************************************************
// Enable/Disable some settings depending on mode
// ******************************************************************

int CVICALLBACK vSourceChanged (int panel, int control, int event, void *callbackData, int eventData1, int eventData2)
    {
    int lValue;
    
    switch (event)
        {
        case EVENT_COMMIT:
            switch (control)
                {
                case SP_CLOCK_CLOCKINTERNAL:
                    g_pstClockDef->lExternalClock = 0; 
                    g_pstClockDef->lReferenceClock = 0; 
                    break;
                    
                case SP_CLOCK_CLOCKEXTERNAL:
                    g_pstClockDef->lExternalClock = 1; 
                    g_pstClockDef->lReferenceClock = 0; 
                    break;
                    
                case SP_CLOCK_CLOCKREFERENCE:
                    g_pstClockDef->lExternalClock = 0; 
                    g_pstClockDef->lReferenceClock = 10000000; 
                    break;
                }

            vEnableControls ();
            break;
            
        case EVENT_VAL_CHANGED:
            break;
        }
    return 0;
    }


