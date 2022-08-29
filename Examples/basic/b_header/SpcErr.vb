Option Strict Off
Option Explicit On
Module spcerr
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

Public Const SPCM_ERROR_ORIGIN_MASK       As Integer = &H80000000 ' this bit marks the origin of the error
Public Const SPCM_ERROR_ORIGIN_LOCAL      As Integer = &H00000000 ' error occured on local system
Public Const SPCM_ERROR_ORIGIN_REMOTE     As Integer = &H80000000 ' error occured on remote system (netbox)

Public Const ERR_OK               As Integer = &H0000      '   0 No Error
Public Const ERR_INIT             As Integer = &H0001      '   1 Initialisation error
Public Const ERR_NR               As Integer = &H0002      '   2 Board number out of range
Public Const ERR_TYP              As Integer = &H0003      '   3 Unknown board Typ
Public Const ERR_FNCNOTSUPPORTED  As Integer = &H0004      '   4 This function is not supported by the hardware
Public Const ERR_BRDREMAP         As Integer = &H0005      '   5 The Board Index Remap table is wrong
Public Const ERR_KERNELVERSION    As Integer = &H0006      '   6 The kernel version and the dll version are mismatching
Public Const ERR_HWDRVVERSION     As Integer = &H0007      '   7 The driver version doesn't match the minimum requirements of the board
Public Const ERR_ADRRANGE         As Integer = &H0008      '   8 The address range is disabled (fatal error)
Public Const ERR_INVALIDHANDLE    As Integer = &H0009      '   9 Handle not valid
Public Const ERR_BOARDNOTFOUND    As Integer = &H000A      '  10 Card with given name hasn't been found
Public Const ERR_BOARDINUSE       As Integer = &H000B      '  11 Card with given name is already in use by another application
Public Const ERR_EXPHW64BITADR    As Integer = &H000C      '  12 Express hardware version not able to handle 64 bit addressing -> update needed
Public Const ERR_FWVERSION        As Integer = &H000D      '  13 Firmware versions of synchronized cards or for this driver do not match -> update needed
Public Const ERR_SYNCPROTOCOL     As Integer = &H000E      '  14 Synchronization protocol of synchronized cards does not match -> update needed
Public Const ERR_KERNEL           As Integer = &H000F      '  15 Some error occurred in the kernel driver
Public Const ERR_LASTERR          As Integer = &H0010      '  16 Old Error waiting to be read
Public Const ERR_ABORT            As Integer = &H0020      '  32 Abort of wait function
Public Const ERR_BOARDLOCKED      As Integer = &H0030      '  48 Board acess already locked by another process. it's not possible to acess one board through multiple processes
Public Const ERR_DEVICE_MAPPING   As Integer = &H0032      '  50 Device is mapped to an invalid device
Public Const ERR_NETWORKSETUP     As Integer = &H0040      '  64 Network setup failed
Public Const ERR_NETWORKTRANSFER  As Integer = &H0041      '  65 Network data transfer failed
Public Const ERR_FWPOWERCYCLE     As Integer = &H0042      '  66 Power cycle needed to update card's firmware (simple PC reboot not sufficient !)
Public Const ERR_NETWORKTIMEOUT   As Integer = &H0043      '  67 Network timeout
Public Const ERR_BUFFERSIZE       As Integer = &H0044      '  68 Buffer too small
Public Const ERR_RESTRICTEDACCESS As Integer = &H0045      '  69 access to card has been restricted
Public Const ERR_INVALIDPARAM     As Integer = &H0046      '  70 invalid parameter for function
Public Const ERR_TEMPERATURE      As Integer = &H0047      '  71 card temperature too high

Public Const ERR_REG              As Integer = &H0100      ' 256 unknown Register for this Board
Public Const ERR_VALUE            As Integer = &H0101      ' 257 Not a possible value in this state
Public Const ERR_FEATURE          As Integer = &H0102      ' 258 Feature of the board not installed
Public Const ERR_SEQUENCE         As Integer = &H0103      ' 259 Channel sequence not allowed
Public Const ERR_READABORT        As Integer = &H0104      ' 260 Read not allowed after abort
Public Const ERR_NOACCESS         As Integer = &H0105      ' 261 Access to this register denied
Public Const ERR_POWERDOWN        As Integer = &H0106      ' 262 not allowed in Powerdown mode
Public Const ERR_TIMEOUT          As Integer = &H0107      ' 263 timeout occured while waiting for interrupt
Public Const ERR_CALLTYPE         As Integer = &H0108      ' 264 call type (int32 mux) is not allowed for this register
Public Const ERR_EXCEEDSINT32     As Integer = &H0109      ' 265 return value is int32 but software register exceeds the 32 bit integer range -> use 2x32 or 64
Public Const ERR_NOWRITEALLOWED   As Integer = &H010A      ' 266 register cannot be written, read only
Public Const ERR_SETUP            As Integer = &H010B      ' 267 the setup isn't valid
Public Const ERR_CLOCKNOTLOCKED   As Integer = &H010C      ' 268 clock section not locked: perhaps no external clock signal connected or not stable
Public Const ERR_MEMINIT          As Integer = &H010D      ' 269 on-board memory initialization error
Public Const ERR_POWERSUPPLY      As Integer = &H010E      ' 270 on-board power supply error
Public Const ERR_ADCCOMMUNICATION As Integer = &H010F      ' 271 communication with ADC failed
Public Const ERR_CHANNEL          As Integer = &H0110      ' 272 Wrong number of Channel to be read out
Public Const ERR_NOTIFYSIZE       As Integer = &H0111      ' 273 Notify block size isn't valid
Public Const ERR_RUNNING          As Integer = &H0120      ' 288 Board is running, changes not allowed
Public Const ERR_ADJUST           As Integer = &H0130      ' 304 Auto Adjust has an error
Public Const ERR_PRETRIGGERLEN    As Integer = &H0140      ' 320 pretrigger length exceeds allowed values
Public Const ERR_DIRMISMATCH      As Integer = &H0141      ' 321 direction of card and memory transfer mismatch
Public Const ERR_POSTEXCDSEGMENT  As Integer = &H0142      ' 322 posttrigger exceeds segment size in multiple recording mode
Public Const ERR_SEGMENTINMEM     As Integer = &H0143      ' 323 memsize is not a multiple of segmentsize, last segment hasn't full length
Public Const ERR_MULTIPLEPW       As Integer = &H0144      ' 324 multiple pulsewidth counters used but card only supports one at the time
Public Const ERR_NOCHANNELPWOR    As Integer = &H0145      ' 325 channel pulsewidth can't be OR'd
Public Const ERR_ANDORMASKOVRLAP  As Integer = &H0146      ' 326 AND mask and OR mask overlap in at least one channel -> not possible
Public Const ERR_ANDMASKEDGE      As Integer = &H0147      ' 327 AND mask together with edge trigger mode is not allowed
Public Const ERR_ORMASKLEVEL      As Integer = &H0148      ' 328 OR mask together with level trigger mode is not allowed
Public Const ERR_EDGEPERMOD       As Integer = &H0149      ' 329 All trigger edges must be simular on one module
Public Const ERR_DOLEVELMINDIFF   As Integer = &H014A      ' 330 minimum difference between low output level and high output level not reached
Public Const ERR_STARHUBENABLE    As Integer = &H014B      ' 331 card holding the star-hub must be active for sync
Public Const ERR_PATPWSMALLEDGE   As Integer = &H014C      ' 332 Combination of pattern with pulsewidht smaller and edge is not allowed
Public Const ERR_XMODESETUP       As Integer = &H014D      ' 333 The chosen setup for (SPCM_X0_MODE .. SPCM_X19_MODE) is not valid. See hardware manual for details.

Public Const ERR_NOPCI            As Integer = &H0200      ' 512 No PCI bus found
Public Const ERR_PCIVERSION       As Integer = &H0201      ' 513 Wrong PCI bus version
Public Const ERR_PCINOBOARDS      As Integer = &H0202      ' 514 No Spectrum PCI boards found
Public Const ERR_PCICHECKSUM      As Integer = &H0203      ' 515 Checksum error on PCI board
Public Const ERR_DMALOCKED        As Integer = &H0204      ' 516 DMA buffer in use, try later
Public Const ERR_MEMALLOC         As Integer = &H0205      ' 517 Memory Allocation error
Public Const ERR_EEPROMLOAD       As Integer = &H0206      ' 518 EEProm load error
Public Const ERR_CARDNOSUPPORT    As Integer = &H0207      ' 519 no support for that card in the library
Public Const ERR_CONFIGACCESS     As Integer = &H0208      ' 520 error occured during config write or read

Public Const ERR_FIFOBUFOVERRUN   As Integer = &H0300      ' 768 Buffer overrun in FIFO mode
Public Const ERR_FIFOHWOVERRUN    As Integer = &H0301      ' 769 Hardware buffer overrun in FIFO mode
Public Const ERR_FIFOFINISHED     As Integer = &H0302      ' 770 FIFO transfer hs been finished. Number of buffers has been transferred
Public Const ERR_FIFOSETUP        As Integer = &H0309      ' 777 FIFO setup not possible, transfer rate to high (max 250 MB/s)

Public Const ERR_TIMESTAMP_SYNC   As Integer = &H0310      ' 784 Synchronisation to ref clock failed
Public Const ERR_STARHUB          As Integer = &H0320      ' 800 Autorouting of Starhub failed

Public Const ERR_INTERNAL_ERROR   As Integer = &HFFFF      ' 65535 Internal hardware error detected, please check for update


End Module


' end of file