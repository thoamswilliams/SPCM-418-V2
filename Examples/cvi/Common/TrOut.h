/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/* Copyright (c) National Instruments 2004. All Rights Reserved.          */
/*                                                                        */
/* WARNING: Do not add to, delete from, or otherwise modify the contents  */
/*          of this include file.                                         */
/**************************************************************************/

#include <userint.h>

#ifdef __cplusplus
    extern "C" {
#endif

     /* Panels and Controls: */

#define  SP_TROUT                        1
#define  SP_TROUT_TRIGGERMODE            2       /* callback function: vTriggermodeCallback */
#define  SP_TROUT_TERMINATION            3
#define  SP_TROUT_OUTPUT                 4
#define  SP_TROUT_MODE                   5       /* callback function: vModeCallback */
#define  SP_TROUT_MEMSIZE                6       /* callback function: vMemsizeCallback */
#define  SP_TROUT_SEGMENTSIZE            7       /* callback function: vSegmentsizeCallback */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */ 

int  CVICALLBACK vMemsizeCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vModeCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vSegmentsizeCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vTriggermodeCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
