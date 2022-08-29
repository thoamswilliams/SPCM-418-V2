//********************************************************************************************************************** 
//*****										   		  DEFINES                                                      *****
//********************************************************************************************************************** 

#define MAX_BRDS    				64
#define DELTA_CHANNEL_COMPONENTS	9
#define ENABLE_CH0					1
#define ENABLE_CH1					2
#define ENABLE_CH2					4
#define ENABLE_CH3					8
#define SINE  						1
#define RECTANGLE   				2
#define TRIANGLE					3
#define SET	  						1
#define RESET 						0
#define ON	  						1
#define OFF   						0
#define CH0	  						0
#define CH1   						1
#define CH2   						2
#define CH3	  						3
#define SUCCESS	   					0
#define _1							1
#define _1DIV2						2
#define _1DIV4						3
#define _1DIV8      				4
#define AUTO_FILTER					4
#define LOAD_DLL					1
#define UNLOAD_DLL  				0
#define START						1
#define STOP						0

//********************************************************************************************************************** 
//*****										Defines for calculation.c                                              *****
//********************************************************************************************************************** 

#define PERIOD_MAX 		     	 1024  
#define PERIOD_MIN				   12
#define PERIOD_START			  120

//********************************************************************************************************************** 
//*****								  Events for the lControlBoard function                                        *****
//********************************************************************************************************************** 

#define SET_INIT_SETUP				0
#define SET_AMPLITUDE_CH0			1
#define SET_AMPLITUDE_CH1   		2
#define SET_AMPLITUDE_CH2   		3
#define SET_AMPLITUDE_CH3   		4
#define SET_OFFSET_CH0				5
#define SET_OFFSET_CH1				6
#define SET_OFFSET_CH2				7
#define SET_OFFSET_CH3				8
#define SET_PHASE_CH0				9
#define SET_PHASE_CH1	   		   10
#define SET_PHASE_CH2	   		   11
#define SET_PHASE_CH3	   		   12
#define SET_WAVEFORM_CH0   		   13	
#define SET_WAVEFORM_CH1   		   14
#define SET_WAVEFORM_CH2   		   15
#define SET_WAVEFORM_CH3   		   16
#define SET_DIVIDER_CH0	   		   17
#define SET_DIVIDER_CH1	   		   18
#define SET_DIVIDER_CH2	   		   19
#define SET_DIVIDER_CH3	   		   20
#define START_BOARD		   		   21
#define STOP_BOARD  	   		   22
#define SET_FREQUENCY	   		   23
#define RESET_BOARD		   		   24
#define SET_CH0_ON         		   25
#define SET_CH0_OFF        		   26
#define SET_CH1_ON		   		   27
#define SET_CH1_OFF        		   28
#define SET_CH2_ON         		   29
#define SET_CH2_OFF        		   30
#define SET_CH3_ON         		   31
#define SET_CH3_OFF        		   32
#define SET_FILTER_CH0			   33
#define SET_FILTER_CH1			   34
#define SET_FILTER_CH2			   35
#define SET_FILTER_CH3			   36

//********************************************************************************************************************** 
//*****								   			STRUCT _GUI_SETTINGS											   *****
//********************************************************************************************************************** 

struct _GUI_SETTINGS
{
	int lAmplitudeCh[4];
	int lOffsetCh[4];
	int lPhaseCh[4];
	int lWaveformCh[4];
	int lDividerCh[4];
	int lFilterCh[4];
	int lSwitchCh[4];
	double dDisplayFreqCh[4];
	int lUsedMemsize;
	int lUsedSamplerate;
	int lChannels;
	int lBoardStatus;
	double dFrequency;
	double dMaxFrequency;
};

//********************************************************************************************************************** 
//*****								   			STRUCT _BOARD_INFO											       *****
//********************************************************************************************************************** 

struct _BOARD_INFO
{
	int hDrv;
	int lBoardType;
	int lSerialNumber;
	int lMaxMemsize;
	int lMaxSamplerate;
	int lMaxFrequency;
	int lMaxChannels;
	int lMod;
	int lChPerMod;
	int lChEnable;
	int lBytesPerSample;
};

//********************************************************************************************************************** 
//*****								   		  STRUCT _DATA_CALC_INFO											   *****
//********************************************************************************************************************** 

struct _CALC_DATA
{
	int lPeriod;
	int lBlockSize;
	int lMemsize;
	int lSamplerate;
};

//********************************************************************************************************************** 
//*****								   			 STRUCT _ERRORCODE											       *****
//********************************************************************************************************************** 

struct _ERRORCODE
{
	int lErrorCode;
	int lErrorReg;
	int lErrorValue;
};
