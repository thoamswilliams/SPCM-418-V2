Attribute VB_Name = "spcerr"
' Spectrum C/C++ header file -> Basic file converter
' Source file:

' ***********************************************************************
'
' SpcErr.h                                        (c) Spectrum GmbH, 2006
'
' ***********************************************************************
'
' error codes of the Spectrum drivers. Until may 2004 this file was 
' errors.h. Name has been changed because errors.h has been already in 
' use by windows.
'
' ***********************************************************************

Public Const SPCM_ERROR_ORIGIN_MASK       = &H80000000& ' this bit marks the origin of the error
Public Const SPCM_ERROR_ORIGIN_LOCAL      = &H00000000& ' error occured on local system
Public Const SPCM_ERROR_ORIGIN_REMOTE     = &H80000000& ' error occured on remote system (netbox)

Public Const ERR_OK               = &H0000&      '   0 No Error
Public Const ERR_INIT             = &H0001&      '   1 Initialisation error
Public Const ERR_NR               = &H0002&      '   2 Board number out of range
Public Const ERR_TYP              = &H0003&      '   3 Unknown board Typ
Public Const ERR_FNCNOTSUPPORTED  = &H0004&      '   4 This function is not supported by the hardware
Public Const ERR_BRDREMAP         = &H0005&      '   5 The Board Index Remap table is wrong
Public Const ERR_KERNELVERSION    = &H0006&      '   6 The kernel version and the dll version are mismatching
Public Const ERR_HWDRVVERSION     = &H0007&      '   7 The driver version doesn't match the minimum requirements of the board
Public Const ERR_ADRRANGE         = &H0008&      '   8 The address range is disabled (fatal error)
Public Const ERR_INVALIDHANDLE    = &H0009&      '   9 Handle not valid
Public Const ERR_BOARDNOTFOUND    = &H000A&      '  10 Card with given name hasn't been found
Public Const ERR_BOARDINUSE       = &H000B&      '  11 Card with given name is already in use by another application
Public Const ERR_EXPHW64BITADR    = &H000C&      '  12 Express hardware version not able to handle 64 bit addressing -> update needed
Public Const ERR_FWVERSION        = &H000D&      '  13 Firmware versions of synchronized cards or for this driver do not match -> update needed
Public Const ERR_SYNCPROTOCOL     = &H000E&      '  14 Synchronization protocol of synchronized cards does not match -> update needed
Public Const ERR_KERNEL           = &H000F&      '  15 Some error occurred in the kernel driver
Public Const ERR_LASTERR          = &H0010&      '  16 Old Error waiting to be read
Public Const ERR_ABORT            = &H0020&      '  32 Abort of wait function
Public Const ERR_BOARDLOCKED      = &H0030&      '  48 Board acess already locked by another process. it's not possible to acess one board through multiple processes
Public Const ERR_DEVICE_MAPPING   = &H0032&      '  50 Device is mapped to an invalid device
Public Const ERR_NETWORKSETUP     = &H0040&      '  64 Network setup failed
Public Const ERR_NETWORKTRANSFER  = &H0041&      '  65 Network data transfer failed
Public Const ERR_FWPOWERCYCLE     = &H0042&      '  66 Power cycle needed to update card's firmware (simple PC reboot not sufficient !)
Public Const ERR_NETWORKTIMEOUT   = &H0043&      '  67 Network timeout
Public Const ERR_BUFFERSIZE       = &H0044&      '  68 Buffer too small
Public Const ERR_RESTRICTEDACCESS = &H0045&      '  69 access to card has been restricted
Public Const ERR_INVALIDPARAM     = &H0046&      '  70 invalid parameter for function
Public Const ERR_TEMPERATURE      = &H0047&      '  71 card temperature too high

Public Const ERR_REG              = &H0100&      ' 256 unknown Register for this Board
Public Const ERR_VALUE            = &H0101&      ' 257 Not a possible value in this state
Public Const ERR_FEATURE          = &H0102&      ' 258 Feature of the board not installed
Public Const ERR_SEQUENCE         = &H0103&      ' 259 Channel sequence not allowed
Public Const ERR_READABORT        = &H0104&      ' 260 Read not allowed after abort
Public Const ERR_NOACCESS         = &H0105&      ' 261 Access to this register denied
Public Const ERR_POWERDOWN        = &H0106&      ' 262 not allowed in Powerdown mode
Public Const ERR_TIMEOUT          = &H0107&      ' 263 timeout occured while waiting for interrupt
Public Const ERR_CALLTYPE         = &H0108&      ' 264 call type (int32 mux) is not allowed for this register
Public Const ERR_EXCEEDSINT32     = &H0109&      ' 265 return value is int32 but software register exceeds the 32 bit integer range -> use 2x32 or 64
Public Const ERR_NOWRITEALLOWED   = &H010A&      ' 266 register cannot be written, read only
Public Const ERR_SETUP            = &H010B&      ' 267 the setup isn't valid
Public Const ERR_CLOCKNOTLOCKED   = &H010C&      ' 268 clock section not locked: perhaps no external clock signal connected or not stable
Public Const ERR_MEMINIT          = &H010D&      ' 269 on-board memory initialization error
Public Const ERR_POWERSUPPLY      = &H010E&      ' 270 on-board power supply error
Public Const ERR_ADCCOMMUNICATION = &H010F&      ' 271 communication with ADC failed
Public Const ERR_CHANNEL          = &H0110&      ' 272 Wrong number of Channel to be read out
Public Const ERR_NOTIFYSIZE       = &H0111&      ' 273 Notify block size isn't valid
Public Const ERR_RUNNING          = &H0120&      ' 288 Board is running, changes not allowed
Public Const ERR_ADJUST           = &H0130&      ' 304 Auto Adjust has an error
Public Const ERR_PRETRIGGERLEN    = &H0140&      ' 320 pretrigger length exceeds allowed values
Public Const ERR_DIRMISMATCH      = &H0141&      ' 321 direction of card and memory transfer mismatch
Public Const ERR_POSTEXCDSEGMENT  = &H0142&      ' 322 posttrigger exceeds segment size in multiple recording mode
Public Const ERR_SEGMENTINMEM     = &H0143&      ' 323 memsize is not a multiple of segmentsize, last segment hasn't full length
Public Const ERR_MULTIPLEPW       = &H0144&      ' 324 multiple pulsewidth counters used but card only supports one at the time
Public Const ERR_NOCHANNELPWOR    = &H0145&      ' 325 channel pulsewidth can't be OR'd
Public Const ERR_ANDORMASKOVRLAP  = &H0146&      ' 326 AND mask and OR mask overlap in at least one channel -> not possible
Public Const ERR_ANDMASKEDGE      = &H0147&      ' 327 AND mask together with edge trigger mode is not allowed
Public Const ERR_ORMASKLEVEL      = &H0148&      ' 328 OR mask together with level trigger mode is not allowed
Public Const ERR_EDGEPERMOD       = &H0149&      ' 329 All trigger edges must be simular on one module
Public Const ERR_DOLEVELMINDIFF   = &H014A&      ' 330 minimum difference between low output level and high output level not reached
Public Const ERR_STARHUBENABLE    = &H014B&      ' 331 card holding the star-hub must be active for sync
Public Const ERR_PATPWSMALLEDGE   = &H014C&      ' 332 Combination of pattern with pulsewidht smaller and edge is not allowed
Public Const ERR_XMODESETUP       = &H014D&      ' 333 The chosen setup for (SPCM_X0_MODE .. SPCM_X19_MODE) is not valid. See hardware manual for details.

Public Const ERR_NOPCI            = &H0200&      ' 512 No PCI bus found
Public Const ERR_PCIVERSION       = &H0201&      ' 513 Wrong PCI bus version
Public Const ERR_PCINOBOARDS      = &H0202&      ' 514 No Spectrum PCI boards found
Public Const ERR_PCICHECKSUM      = &H0203&      ' 515 Checksum error on PCI board
Public Const ERR_DMALOCKED        = &H0204&      ' 516 DMA buffer in use, try later
Public Const ERR_MEMALLOC         = &H0205&      ' 517 Memory Allocation error
Public Const ERR_EEPROMLOAD       = &H0206&      ' 518 EEProm load error
Public Const ERR_CARDNOSUPPORT    = &H0207&      ' 519 no support for that card in the library
Public Const ERR_CONFIGACCESS     = &H0208&      ' 520 error occured during config write or read

Public Const ERR_FIFOBUFOVERRUN   = &H0300&      ' 768 Buffer overrun in FIFO mode
Public Const ERR_FIFOHWOVERRUN    = &H0301&      ' 769 Hardware buffer overrun in FIFO mode
Public Const ERR_FIFOFINISHED     = &H0302&      ' 770 FIFO transfer hs been finished. Number of buffers has been transferred
Public Const ERR_FIFOSETUP        = &H0309&      ' 777 FIFO setup not possible, transfer rate to high (max 250 MB/s)

Public Const ERR_TIMESTAMP_SYNC   = &H0310&      ' 784 Synchronisation to ref clock failed
Public Const ERR_STARHUB          = &H0320&      ' 800 Autorouting of Starhub failed

Public Const ERR_INTERNAL_ERROR   = &HFFFF&      ' 65535 Internal hardware error detected, please check for update




' end of file