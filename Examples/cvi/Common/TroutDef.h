// ******************************************************************
// TrOutDef.h
// ******************************************************************
// Handles the definitions for trigger output panel
// ******************************************************************


// ------ defines for the mode registers -----
#define TROUT_MODE_SINGLESHOT 0x00000001
#define TROUT_MODE_CONTINOUS  0x00000002
#define TROUT_MODE_MULTI      0x00000004
#define TROUT_MODE_GATE       0x00000008
#define TROUT_MODE_FIFO       0x00000010
#define TROUT_MODE_FIFOMULTI  0x00000020
#define TROUT_MODE_FIFOGATE   0x00000040


struct _ST_TROUT_DEF
    {

    // settings from main task
    int hPanel;                 // panel handle from main task
    int lModeMask;              // mask for the modes that are possible
    
    // current setup
    int lMode;                  // used mode
    int lMemsize;               // memory size
    int lSegmentsize;           // segment size
    int lTriggermode;           // trigger mode of card
    int lOutput;                // trigger output enabled
    int lTermination;           // trigger termination enabled
    };



// ----- functions to read and write setup of sub panel -----
void vTrigOutSetupWrite    (struct _ST_TROUT_DEF*);
void vTrigOutSetupRead     (void);
void vTrigOutCheckSettings (void);
