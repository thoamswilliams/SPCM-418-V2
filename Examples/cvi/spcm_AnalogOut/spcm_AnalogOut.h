/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/* Copyright (c) National Instruments 2015. All Rights Reserved.          */
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
#define  PANEL_BUTTON_QUIT               2       /* callback function: lCallbackQuitButton */
#define  PANEL_BUTTON_RECT               3       /* callback function: lCallBackGuiSettingsChanged */
#define  PANEL_BUTTON_SINE               4       /* callback function: lCallBackGuiSettingsChanged */
#define  PANEL_BUTTON_TRI                5       /* callback function: lCallBackGuiSettingsChanged */
#define  PANEL_NUMERIC_MEMSIZE           6       /* callback function: lCallBackGuiSettingsChanged */
#define  PANEL_BUTTON_START              7       /* callback function: lCallbackStartButton */
#define  PANEL_NUMERIC_SRATE             8       /* callback function: lCallBackGuiSettingsChanged */
#define  PANEL_LED                       9


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */ 

int  CVICALLBACK lCallBackGuiSettingsChanged(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCallbackQuitButton(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCallbackStartButton(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
