// ******************************************************************
// 72Levels: Cares for level setup
// ******************************************************************

#include <userint.h>

#include "72Levels.h"
#include "72LevelDef.h"


struct _ST_72LEVELS_DEF* g_pstLevels;


// ******************************************************************
// vLevelsSetupWrite
// ******************************************************************

// remapping of the control ids to access them in an array
int plLowLevelList[] =  {SP_LEVEL_LOWLEVEL0, SP_LEVEL_LOWLEVEL1, SP_LEVEL_LOWLEVEL2, SP_LEVEL_LOWLEVEL3, SP_LEVEL_LOWLEVEL4, SP_LEVEL_LOWLEVEL5, SP_LEVEL_LOWLEVEL6, SP_LEVEL_LOWLEVEL7};
int plHighLevelList[] = {SP_LEVEL_HIGHLEVEL0, SP_LEVEL_HIGHLEVEL1, SP_LEVEL_HIGHLEVEL2, SP_LEVEL_HIGHLEVEL3, SP_LEVEL_HIGHLEVEL4, SP_LEVEL_HIGHLEVEL5, SP_LEVEL_HIGHLEVEL6, SP_LEVEL_HIGHLEVEL7};

// ******************************************************************

void vLevelsSetupWrite (struct _ST_72LEVELS_DEF* pstLevels)
{
    int i;
    
    g_pstLevels = pstLevels;

    // ----- enable the level input fields, each level is valid for 4 channels -----
    for (i=0; i<8; i++)
    {
        SetInputMode (g_pstLevels->hPanel, plLowLevelList[i],  g_pstLevels->lMaxChannel > (4*i));
        SetInputMode (g_pstLevels->hPanel, plHighLevelList[i], g_pstLevels->lMaxChannel > (4*i));
    }
    
    // ----- fill values -----
    for (i=0; i<8; i++)
    {
        SetCtrlVal (g_pstLevels->hPanel, plLowLevelList[i],   g_pstLevels->lLowLevel[i]);
        SetCtrlVal (g_pstLevels->hPanel, plHighLevelList[i],  g_pstLevels->lHighLevel[i]);
    }
    
}



// ******************************************************************
// vLevelsSetupRead
// ******************************************************************

void vLevelsSetupRead (void)
{
    int i;
    
    // ----- read values -----
    for (i=0; i<8; i++)
    {
        GetCtrlVal (g_pstLevels->hPanel, plLowLevelList[i],   &g_pstLevels->lLowLevel[i]);
        GetCtrlVal (g_pstLevels->hPanel, plHighLevelList[i],  &g_pstLevels->lHighLevel[i]);
    }
}
