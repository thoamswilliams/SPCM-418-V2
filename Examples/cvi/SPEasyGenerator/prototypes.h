//*************************************************************************************************************
//*****											   PROTOTYPES                                             *****
//*************************************************************************************************************



//*************************************************************************************************************
//*****											 funcGenerator.c                                          *****
//*************************************************************************************************************

void vChDimmed (int lState, int lChannel);
void vInitGui (struct _BOARD_INFO stBoardInfo);
void vChHide (int lChannel);
void vDisplayFrequency (void);
void vDisplayUsedSettings (void);
void vDisplayDrvError (void);
void vActivateToolTips (void);  
int lChannelEnableCheck (int lEnable);
int lGetBoardHandle (int *hDrv);

extern struct _ERRORCODE stControlBoard (int lEvent, struct _GUI_SETTINGS *stGuiSettings); 


//*************************************************************************************************************
//*****											boardControl.c                                            *****
//*************************************************************************************************************

extern HINSTANCE lLoadSpectrumDrv (int *plStatus);	
extern void vFreeSpectrumDrv (HINSTANCE hDLL);


extern int lSearch4Boards (int lMI6X_BrdType[], int lMI6X_SN[], int lMI6X_hDrv[]);
extern struct _BOARD_INFO stInitBoard (int hDrv);


//*************************************************************************************************************
//*****											calculation.c                                             *****
//*************************************************************************************************************

extern void vGetCalcData (struct _CALC_DATA *stCalcData, struct _BOARD_INFO *stBoardInfo, struct _GUI_SETTINGS *stGuiSettings);

extern short* pnCalculateSampleData (struct _CALC_DATA *stCalcData, struct _GUI_SETTINGS *stGuiSettings, 
					     	         struct _BOARD_INFO *stBoardInfo, int lChannel);
