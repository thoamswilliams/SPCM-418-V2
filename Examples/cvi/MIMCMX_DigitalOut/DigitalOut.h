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

#define  PANEL                           1
#define  PANEL_QUIT                      2       /* callback function: vQuit */
#define  PANEL_START                     3       /* callback function: vStartCallback */
#define  PANEL_STATUS                    4
#define  PANEL_STOP                      5       /* callback function: vStopCallback */
#define  PANEL_STATUSPOLL                6       /* callback function: vPollStatusTimer */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */ 

int  CVICALLBACK vPollStatusTimer(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vQuit(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vStartCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK vStopCallback(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
