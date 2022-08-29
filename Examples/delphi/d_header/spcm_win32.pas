{
*******************************************************************************
Delphi unit for type definition and prototypes for spcm driver Windows 32 bit
*******************************************************************************
}

unit spcm_win32;

interface

// ----- some overall type definitions -----
type

    int8 =   shortint;
    pint8 =  ^shortint;
    int16 =  smallint;
    pint16 = ^smallint;
    int32 =  longint;
    pint32 = ^longint;

    uint8 =  byte;
    uint16 = word;
    uint32 = longword;

    TCData = array[0..0] of int8;        // Helper array for pointer declaration. 8 Bit
    TNData = array[0..0] of int16;       // Helper array for pointer declaration. 16 Bit


// ----- device handling functions -----
function spcm_hOpen (strName: PAnsiChar): int32; stdcall; external 'spcm_win32.dll' name '_spcm_hOpen@4';
procedure spcm_vClose (hDevice: int32); stdcall; external 'spcm_win32.dll' name '_spcm_vClose@4';
function spcm_dwGetErrorInfo_i32 (hDevice: int32; var lErrorReg, lErrorValue: int32; strError: pchar): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwGetErrorInfo_i32@16'

// ----- register access functions -----
function spcm_dwSetParam_i32 (hDevice, lRegister, lValue: int32): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwSetParam_i32@12';
function spcm_dwSetParam_i64 (hDevice, lRegister: int32; llValue: int64): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwSetParam_i64@16';
function spcm_dwGetParam_i32 (hDevice, lRegister: int32; var plValue: int32): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwGetParam_i32@12';
function spcm_dwGetParam_i64 (hDevice, lRegister: int32; var pllValue: int64): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwGetParam_i64@12';

// ----- data handling -----
const SPCM_DIR_PCTOCARD = 0;        // transfer from PC memory to card memory
const SPCM_DIR_CARDTOPC = 1;        // transfer from card memory to PC memory
const SPCM_BUF_DATA = 1000;         // main data buffer for acquired or generated samples
const SPCM_BUF_ABA = 2000;          // buffer for ABA data, holds the A-DATA (slow samples)
const SPCM_BUF_TIMESTAMP = 3000;    // buffer for timestamps

function spcm_dwDefTransfer_i64 (hDevice, dwBufType, dwDirection, dwNotifySize: int32; pvDataBuffer: Pointer; llBrdOffs, llTransferLen: int64): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwDefTransfer_i64@36';
function spcm_dwInvalidateBuf (hDevice, lBuffer: int32): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwInvalidateBuf@8';

function spcm_dwGetContBuf_i64 (hDevice: int32; dwBufType: uint32; var ppvDataBuffer: Pointer; var pllContBufLen: int64): uint32; stdcall; external 'spcm_win32.dll' name '_spcm_dwGetContBuf_i64@16';

implementation

end.


