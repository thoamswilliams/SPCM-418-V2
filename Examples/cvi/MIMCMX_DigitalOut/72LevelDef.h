// ******************************************************************
// 72LevelDef
// ******************************************************************
// Handles the definitions for output levels
// ******************************************************************



struct _ST_72LEVELS_DEF
{

    // settings from main task
    int hPanel;                 // panel handle from main task
    int lMaxChannel;            // number of available channels depends on board version
    
    // current setup
    int lLowLevel[8];
    int lHighLevel[8];
};



// ----- functions to read and write setup of sub panel -----
void vLevelsSetupWrite    (struct _ST_72LEVELS_DEF*);
void vLevelsSetupRead     (void);
