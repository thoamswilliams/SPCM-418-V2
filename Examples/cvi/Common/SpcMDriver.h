// ******************************************************************
// Interface to spcm_win32.dll
// ******************************************************************




// ----- structure for card information -----
struct _ST_CARD_INFO
{
    drv_handle hDrv;    	// driver handle
    int32 	lCardFunction;	// function of the card
    int32 	lBrdType;       // type of card
    int32 	lSerialNumber;  // serial number
    int32 	lMemsize;       // installed memory in bytes
    int32 	lVersionBase;   // version of base board
    int32 	lVersionModule; // version of module
    int32 	lFeatures;      // Features of the card
};

struct _ST_SYSTEM_INFO
{
    struct _ST_CARD_INFO stCards[MAXBRD];     // information about the cards
    int32   lCardsFound;    // number of cards found in system
    int32   lDriverVersion; // driver dll version information
    int32   lKernelVersion; // kernel driver version information
    int16   nInitError;     // initialisation error code
};


// ----- prototypes -----
char bInitAndReadSystem (struct _ST_SYSTEM_INFO*);
void vCloseAllCards (struct _ST_SYSTEM_INFO*);
void vDisplaySystemInfo (struct _ST_SYSTEM_INFO*);
char bCheckAndDisplayErrorInfo (struct _ST_CARD_INFO*);

void vFillCardInfoPanel (struct _ST_CARD_INFO*, int hPanel);
void vFillClockDef (struct _ST_CARD_INFO*, struct _ST_CLOCK_DEF*);


