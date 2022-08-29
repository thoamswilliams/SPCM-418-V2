/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/* Copyright (c) National Instruments 2006. All Rights Reserved.          */
/*                                                                        */
/* WARNING: Do not add to, delete from, or otherwise modify the contents  */
/*          of this include file.                                         */
/**************************************************************************/

#include <userint.h>

#ifdef __cplusplus
    extern "C" {
#endif

     /* Panels and Controls: */

#define  SP_CLOCK                        1
#define  SP_CLOCK_EXTRANGE               2
#define  SP_CLOCK_CLOCK                  3
#define  SP_CLOCK_TERMINATION            4
#define  SP_CLOCK_OUTPUT                 5
#define  SP_CLOCK_CLOCKREFERENCE         6       /* callback function: vSourceChanged */
#define  SP_CLOCK_CLOCKEXTERNAL          7       /* callback function: vSourceChanged */
#define  SP_CLOCK_CLOCKINTERNAL          8       /* callback function: vSourceChanged */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */ 

int  CVICALLBACK vSourceChanged(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
