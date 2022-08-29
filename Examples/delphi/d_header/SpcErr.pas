unit SpcErr;

interface

{ Spectrum C/C++ header file -> Pascal / Delphi unit file converter }
{ Source file: }

{ *********************************************************************** }
{ }
{ SpcErr.h                                        (c) Spectrum GmbH, 2006 }
{ }
{ *********************************************************************** }
{ }
{ error codes of the Spectrum drivers. Until may 2004 this file was  }
{ errors.h. Name has been changed because errors.h has been already in  }
{ use by windows. }
{ }
{ *********************************************************************** }

const SPCM_ERROR_ORIGIN_MASK       = $80000000; { this bit marks the origin of the error }
const SPCM_ERROR_ORIGIN_LOCAL      = $00000000; { error occured on local system }
const SPCM_ERROR_ORIGIN_REMOTE     = $80000000; { error occured on remote system (netbox) }

const ERR_OK               = $0000;      {   0 No Error }
const ERR_INIT             = $0001;      {   1 Initialisation error }
const ERR_NR               = $0002;      {   2 Board number out of range }
const ERR_TYP              = $0003;      {   3 Unknown board Typ }
const ERR_FNCNOTSUPPORTED  = $0004;      {   4 This function is not supported by the hardware }
const ERR_BRDREMAP         = $0005;      {   5 The Board Index Remap table is wrong }
const ERR_KERNELVERSION    = $0006;      {   6 The kernel version and the dll version are mismatching }
const ERR_HWDRVVERSION     = $0007;      {   7 The driver version doesn't match the minimum requirements of the board }
const ERR_ADRRANGE         = $0008;      {   8 The address range is disabled (fatal error) }
const ERR_INVALIDHANDLE    = $0009;      {   9 Handle not valid }
const ERR_BOARDNOTFOUND    = $000A;      {  10 Card with given name hasn't been found }
const ERR_BOARDINUSE       = $000B;      {  11 Card with given name is already in use by another application }
const ERR_EXPHW64BITADR    = $000C;      {  12 Express hardware version not able to handle 64 bit addressing -> update needed }
const ERR_FWVERSION        = $000D;      {  13 Firmware versions of synchronized cards or for this driver do not match -> update needed }
const ERR_SYNCPROTOCOL     = $000E;      {  14 Synchronization protocol of synchronized cards does not match -> update needed }
const ERR_KERNEL           = $000F;      {  15 Some error occurred in the kernel driver }
const ERR_LASTERR          = $0010;      {  16 Old Error waiting to be read }
const ERR_ABORT            = $0020;      {  32 Abort of wait function }
const ERR_BOARDLOCKED      = $0030;      {  48 Board acess already locked by another process. it's not possible to acess one board through multiple processes }
const ERR_DEVICE_MAPPING   = $0032;      {  50 Device is mapped to an invalid device }
const ERR_NETWORKSETUP     = $0040;      {  64 Network setup failed }
const ERR_NETWORKTRANSFER  = $0041;      {  65 Network data transfer failed }
const ERR_FWPOWERCYCLE     = $0042;      {  66 Power cycle needed to update card's firmware (simple PC reboot not sufficient !) }
const ERR_NETWORKTIMEOUT   = $0043;      {  67 Network timeout }
const ERR_BUFFERSIZE       = $0044;      {  68 Buffer too small }
const ERR_RESTRICTEDACCESS = $0045;      {  69 access to card has been restricted }
const ERR_INVALIDPARAM     = $0046;      {  70 invalid parameter for function }
const ERR_TEMPERATURE      = $0047;      {  71 card temperature too high }

const ERR_REG              = $0100;      { 256 unknown Register for this Board }
const ERR_VALUE            = $0101;      { 257 Not a possible value in this state }
const ERR_FEATURE          = $0102;      { 258 Feature of the board not installed }
const ERR_SEQUENCE         = $0103;      { 259 Channel sequence not allowed }
const ERR_READABORT        = $0104;      { 260 Read not allowed after abort }
const ERR_NOACCESS         = $0105;      { 261 Access to this register denied }
const ERR_POWERDOWN        = $0106;      { 262 not allowed in Powerdown mode }
const ERR_TIMEOUT          = $0107;      { 263 timeout occured while waiting for interrupt }
const ERR_CALLTYPE         = $0108;      { 264 call type (int32 mux) is not allowed for this register }
const ERR_EXCEEDSINT32     = $0109;      { 265 return value is int32 but software register exceeds the 32 bit integer range -> use 2x32 or 64 }
const ERR_NOWRITEALLOWED   = $010A;      { 266 register cannot be written, read only }
const ERR_SETUP            = $010B;      { 267 the setup isn't valid }
const ERR_CLOCKNOTLOCKED   = $010C;      { 268 clock section not locked: perhaps no external clock signal connected or not stable }
const ERR_MEMINIT          = $010D;      { 269 on-board memory initialization error }
const ERR_POWERSUPPLY      = $010E;      { 270 on-board power supply error }
const ERR_ADCCOMMUNICATION = $010F;      { 271 communication with ADC failed }
const ERR_CHANNEL          = $0110;      { 272 Wrong number of Channel to be read out }
const ERR_NOTIFYSIZE       = $0111;      { 273 Notify block size isn't valid }
const ERR_RUNNING          = $0120;      { 288 Board is running, changes not allowed }
const ERR_ADJUST           = $0130;      { 304 Auto Adjust has an error }
const ERR_PRETRIGGERLEN    = $0140;      { 320 pretrigger length exceeds allowed values }
const ERR_DIRMISMATCH      = $0141;      { 321 direction of card and memory transfer mismatch }
const ERR_POSTEXCDSEGMENT  = $0142;      { 322 posttrigger exceeds segment size in multiple recording mode }
const ERR_SEGMENTINMEM     = $0143;      { 323 memsize is not a multiple of segmentsize, last segment hasn't full length }
const ERR_MULTIPLEPW       = $0144;      { 324 multiple pulsewidth counters used but card only supports one at the time }
const ERR_NOCHANNELPWOR    = $0145;      { 325 channel pulsewidth can't be OR'd }
const ERR_ANDORMASKOVRLAP  = $0146;      { 326 AND mask and OR mask overlap in at least one channel -> not possible }
const ERR_ANDMASKEDGE      = $0147;      { 327 AND mask together with edge trigger mode is not allowed }
const ERR_ORMASKLEVEL      = $0148;      { 328 OR mask together with level trigger mode is not allowed }
const ERR_EDGEPERMOD       = $0149;      { 329 All trigger edges must be simular on one module }
const ERR_DOLEVELMINDIFF   = $014A;      { 330 minimum difference between low output level and high output level not reached }
const ERR_STARHUBENABLE    = $014B;      { 331 card holding the star-hub must be active for sync }
const ERR_PATPWSMALLEDGE   = $014C;      { 332 Combination of pattern with pulsewidht smaller and edge is not allowed }
const ERR_XMODESETUP       = $014D;      { 333 The chosen setup for (SPCM_X0_MODE .. SPCM_X19_MODE) is not valid. See hardware manual for details. }

const ERR_NOPCI            = $0200;      { 512 No PCI bus found }
const ERR_PCIVERSION       = $0201;      { 513 Wrong PCI bus version }
const ERR_PCINOBOARDS      = $0202;      { 514 No Spectrum PCI boards found }
const ERR_PCICHECKSUM      = $0203;      { 515 Checksum error on PCI board }
const ERR_DMALOCKED        = $0204;      { 516 DMA buffer in use, try later }
const ERR_MEMALLOC         = $0205;      { 517 Memory Allocation error }
const ERR_EEPROMLOAD       = $0206;      { 518 EEProm load error }
const ERR_CARDNOSUPPORT    = $0207;      { 519 no support for that card in the library }
const ERR_CONFIGACCESS     = $0208;      { 520 error occured during config write or read }

const ERR_FIFOBUFOVERRUN   = $0300;      { 768 Buffer overrun in FIFO mode }
const ERR_FIFOHWOVERRUN    = $0301;      { 769 Hardware buffer overrun in FIFO mode }
const ERR_FIFOFINISHED     = $0302;      { 770 FIFO transfer hs been finished. Number of buffers has been transferred }
const ERR_FIFOSETUP        = $0309;      { 777 FIFO setup not possible, transfer rate to high (max 250 MB/s) }

const ERR_TIMESTAMP_SYNC   = $0310;      { 784 Synchronisation to ref clock failed }
const ERR_STARHUB          = $0320;      { 800 Autorouting of Starhub failed }

const ERR_INTERNAL_ERROR   = $FFFF;      { 65535 Internal hardware error detected, please check for update }




implementation

end.