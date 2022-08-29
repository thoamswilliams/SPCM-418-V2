// ******************************************************************
// Interface to Spectrum.dll
// ******************************************************************




// ----- define the Spectrum driver functions -----
typedef short (SPCINITPCIBOARDS) (short* pnCount, short* pnPCIVersion);
typedef short (SPCINITBOARD)     (short nNr, short nTyp);
typedef short (SPCSETPARAM)      (short nNr, int lReg, int lValue);
typedef short (SPCGETPARAM)      (short nNr, int lReg, int* plValue);
typedef short (SPCSETDATA)       (short nNr, short nCh, int lStart, int lLen, void* pvData);
typedef short (SPCGETDATA)       (short nNr, short nCh, int lStart, int lLen, void* pvData);



// ----- global function adresses to acess the Spectrum driver -----
#ifndef SPCDRVINTERFACE
extern SPCINITPCIBOARDS* SpcInitPCIBoards;
extern SPCINITBOARD*     SpcInitBoard;
extern SPCSETPARAM*      SpcSetParam;
extern SPCGETPARAM*      SpcGetParam;
extern SPCSETDATA*       SpcSetData;
extern SPCGETDATA*       SpcGetData;

#else
SPCINITPCIBOARDS* SpcInitPCIBoards;
SPCINITBOARD*     SpcInitBoard;
SPCSETPARAM*      SpcSetParam;
SPCGETPARAM*      SpcGetParam;
SPCSETDATA*       SpcSetData;
SPCGETDATA*       SpcGetData;
#endif


// ----- some global constants -----
#define MAX_CARDS 8



// ----- structure for card information -----
struct _ST_CARD_INFO
{
    int lIdx;           // card index (needed if _ST_CARD_INFO is used directly)
    int lBrdType;       // type of card
    int lSerialNumber;  // serial number
    int lMemsize;       // installed memory in bytes
    int lVersionBase;   // version of base board
    int lVersionModule; // version of module
    int lFeatures;      // Features of the card
};

struct _ST_SYSTEM_INFO
{
    struct _ST_CARD_INFO stCards[MAX_CARDS];     // information about the cards
    int   lCardsFound;    // number of cards found in system
    int   lDriverVersion; // driver dll version information
    int   lKernelVersion; // kernel driver version information
    short nInitError;     // initialisation error code
};


// ----- prototypes -----
char bInitSpcDrvInterface (void);     
void vFreeSpcDrvInterface (void);         
char bInitAndReadSystem (struct _ST_SYSTEM_INFO*);
void vDisplaySystemInfo (struct _ST_SYSTEM_INFO*);
void vFillCardInfoPanel (struct _ST_CARD_INFO*, int hPanel);
char bCheckAndDisplayErrorInfo (struct _ST_CARD_INFO*);
char bCheckForFirstSupportedCard (struct _ST_SYSTEM_INFO* pstSystemInfo, short* pnBrdIdx, int lBrdMask, int lBrdType);
