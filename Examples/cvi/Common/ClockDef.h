// ******************************************************************
// Clock.h
// ******************************************************************
// Handles the definitions for clock panel
// ******************************************************************


struct _ST_CLOCK_DEF
    {   
    
    // settings from main task
    int hPanel;                 // panel handle from main task
    
    int lMinClock;              // minimum internal clock
    int lMaxClock;              // maximum internal clock
    
    int lExtRangeMask;          // mask of the available external ranges
    
    // settings
    int lSamplerate;
    int lExternalClock;
    int lClockTermination;
    int lClockOutput;
    int lReferenceClock;
    int lExtRange;
    };



// ----- functions to read and write setup of sub panel -----
void vClockSetupWrite    (struct _ST_CLOCK_DEF*);
void vClockSetupRead     (void);
