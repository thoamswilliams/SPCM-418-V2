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

#define  BRD_SELECT                      1
#define  BRD_SELECT_BOARDLIST            2
#define  BRD_SELECT_BUTTON_BRD_SELECT    3       /* callback function: lBoardSelect */

#define  PANEL                           2
#define  PANEL_BUTTON_SINE_CH0           2       /* callback function: lSetSineCh0 */
#define  PANEL_BUTTON_RECTANGLE_CH0      3       /* callback function: lSetRectangleCh0 */
#define  PANEL_BUTTON_TRIANGLE_CH0       4       /* callback function: lSetTriangleCh0 */
#define  PANEL_KNOB_AMPLITUDE_CH0        5       /* callback function: lSetAmplitudeCh0 */
#define  PANEL_KNOB_OFFSET_CH0           6       /* callback function: lSetOffsetCh0 */
#define  PANEL_KNOB_PHASE_CH0            7       /* callback function: lSetPhaseCh0 */
#define  PANEL_MENU_DIVIDER_CH0          8       /* callback function: lSetDividerCh0 */
#define  PANEL_INDICATOR_FREQ_CH0        9
#define  PANEL_LED_CH0                   10
#define  PANEL_BUTTON_SINE_CH1           11      /* callback function: lSetSineCh1 */
#define  PANEL_BUTTON_RECTANGLE_CH1      12      /* callback function: lSetRectangleCh1 */
#define  PANEL_BUTTON_TRIANGLE_CH1       13      /* callback function: lSetTriangleCh1 */
#define  PANEL_KNOB_AMPLITUDE_CH1        14      /* callback function: lSetAmplitudeCh1 */
#define  PANEL_KNOB_OFFSET_CH1           15      /* callback function: lSetOffsetCh1 */
#define  PANEL_KNOB_PHASE_CH1            16      /* callback function: lSetPhaseCh1 */
#define  PANEL_MENU_DIVIDER_CH1          17      /* callback function: lSetDividerCh1 */
#define  PANEL_INDICATOR_FREQ_CH1        18
#define  PANEL_LED_CH1                   19
#define  PANEL_BUTTON_SINE_CH2           20      /* callback function: lSetSineCh2 */
#define  PANEL_BUTTON_RECTANGLE_CH2      21      /* callback function: lSetRectangleCh2 */
#define  PANEL_BUTTON_TRIANGLE_CH2       22      /* callback function: lSetTriangleCh2 */
#define  PANEL_KNOB_AMPLITUDE_CH2        23      /* callback function: lSetAmplitudeCh2 */
#define  PANEL_KNOB_OFFSET_CH2           24      /* callback function: lSetOffsetCh2 */
#define  PANEL_KNOB_PHASE_CH2            25      /* callback function: lSetPhaseCh2 */
#define  PANEL_MENU_DIVIDER_CH2          26      /* callback function: lSetDividerCh2 */
#define  PANEL_INDICATOR_FREQ_CH2        27
#define  PANEL_LED_CH2                   28
#define  PANEL_BUTTON_SINE_CH3           29      /* callback function: lSetSineCh3 */
#define  PANEL_BUTTON_RECTANGLE_CH3      30      /* callback function: lSetRectangleCh3 */
#define  PANEL_BUTTON_TRIANGLE_CH3       31      /* callback function: lSetTriangleCh3 */
#define  PANEL_KNOB_AMPLITUDE_CH3        32      /* callback function: lSetAmplitudeCh3 */
#define  PANEL_KNOB_OFFSET_CH3           33      /* callback function: lSetOffsetCh3 */
#define  PANEL_KNOB_PHASE_CH3            34      /* callback function: lSetPhaseCh3 */
#define  PANEL_MENU_DIVIDER_CH3          35      /* callback function: lSetDividerCh3 */
#define  PANEL_INDICATOR_FREQ_CH3        36
#define  PANEL_LED_CH3                   37
#define  PANEL_DECORATION                38
#define  PANEL_DECORATION_2              39
#define  PANEL_DECORATION_3              40
#define  PANEL_DECORATION_4              41
#define  PANEL_INDICATOR_BOARDTYPE       42
#define  PANEL_INDICATOR_SERIALNR        43
#define  PANEL_INDICATOR_MAX_SRATE       44
#define  PANEL_INDICATOR_MAX_MEMSIZE     45
#define  PANEL_DIAL_FREQ                 46      /* callback function: lSetFrequency */
#define  PANEL_BUTTON_QUIT               47      /* callback function: lQuitProgram */
#define  PANEL_LED_STATUS                48
#define  PANEL_DECORATION_6              49
#define  PANEL_SPECTRUM                  50
#define  PANEL_INDICATOR_USED_MEM        51
#define  PANEL_LED_SINE_CH0              52
#define  PANEL_LED_RECTANGLE_CH0         53
#define  PANEL_LED_TRIANGLE_CH0          54
#define  PANEL_LED_SINE_CH1              55
#define  PANEL_LED_RECTANGLE_CH1         56
#define  PANEL_LED_TRIANGLE_CH1          57
#define  PANEL_LED_SINE_CH2              58
#define  PANEL_LED_RECTANGLE_CH2         59
#define  PANEL_LED_TRIANGLE_CH2          60
#define  PANEL_LED_SINE_CH3              61
#define  PANEL_LED_RECTANGLE_CH3         62
#define  PANEL_LED_TRIANGLE_CH3          63
#define  PANEL_BUTTON_ENABLED_CH0        64      /* callback function: lCh0Enable */
#define  PANEL_BUTTON_ENABLED_CH1        65      /* callback function: lCh1Enable */
#define  PANEL_BUTTON_ENABLED_CH2        66      /* callback function: lCh2Enable */
#define  PANEL_BUTTON_ENABLED_CH3        67      /* callback function: lCh3Enable */
#define  PANEL_DECORATION_7              68
#define  PANEL_BUTTON_RESET              69      /* callback function: lResetSettings */
#define  PANEL_MENU_FREQ                 70      /* callback function: lSetUnit */
#define  PANEL_INDICATOR_USED_SRATE      71
#define  PANEL_BUTTON_INFO               72      /* callback function: lSetBoardInfo */
#define  PANEL_BUTTON_BOARD_STOP         73      /* callback function: lBoardStop */
#define  PANEL_TEXTMSG_2                 74
#define  PANEL_TEXTMSG                   75
#define  PANEL_MENU_FILTER_CH0           76      /* callback function: lSetFilterCh0 */
#define  PANEL_MENU_FILTER_CH1           77      /* callback function: lSetFilterCh1 */
#define  PANEL_MENU_FILTER_CH2           78      /* callback function: lSetFilterCh2 */
#define  PANEL_MENU_FILTER_CH3           79      /* callback function: lSetFilterCh3 */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */ 

int  CVICALLBACK lBoardSelect(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lBoardStop(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCh0Enable(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCh1Enable(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCh2Enable(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lCh3Enable(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lQuitProgram(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lResetSettings(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetAmplitudeCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetAmplitudeCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetAmplitudeCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetAmplitudeCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetBoardInfo(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetDividerCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetDividerCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetDividerCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetDividerCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetFilterCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetFilterCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetFilterCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetFilterCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetFrequency(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetOffsetCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetOffsetCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetOffsetCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetOffsetCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetPhaseCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetPhaseCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetPhaseCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetPhaseCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetRectangleCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetRectangleCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetRectangleCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetRectangleCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetSineCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetSineCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetSineCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetSineCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetTriangleCh0(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetTriangleCh1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetTriangleCh2(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetTriangleCh3(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK lSetUnit(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif
