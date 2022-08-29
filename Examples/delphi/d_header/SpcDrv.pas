{
*******************************************************************************
Delphi unit for type definition and prototypes for all Spectrum Delphi examples
*******************************************************************************
Spectrum Instrumentation GmbH
Ahrensfelder Weg 13-17 - 22927 Grosshansdorf - Germany
Phone: +49/4102-6956-0 Fax: +49/4102-6956-66
https://www.spectrum-instrumentation.com - email: info@spec.de
*******************************************************************************

*******************************************************************************
}

unit SpcDrv;

interface

// ----- some overall type definitions -----
type

    int8 =   shortint;
    pint8 =  ^shortint;
    int16 =  smallint;
    pint16 = ^smallint;
    int32 =  longint;
    pint32 = ^longint;

    TCData = array[0..0] of int8;        // Helper array for pointer declaration. 8 Bit
    PCData = ^TCData;

    TNData = array[0..0] of int16;       // Helper array for pointer declaration. 16 Bit
    PNData = ^TNData;

    

// ----- driver functions that we use -----
function SpcSetData (nNr,nCh:int16; lStart,lLen:int32; pData:Pointer): int16; cdecl; external 'SPECTRUM.DLL';
function SpcGetData (nNr,nCh:int16; lStart,lLen:int32; pData:Pointer): int16; cdecl; external 'SPECTRUM.DLL';
function SpcSetParam (nNr:int16; lReg,lValue: int32): int16;                  cdecl; external 'SPECTRUM.DLL';
function SpcGetParam (nNr:int16; lReg:int32; plValue:pint32): int16;          cdecl; external 'SPECTRUM.DLL';
function SpcInitPCIBoards (nCount,nPCIVersion: pint16): int16;                cdecl; external 'SPECTRUM.DLL';
function SpcInitBoard (nNr, nTyp: int16): int16;                              cdecl; external 'SPECTRUM.DLL';

implementation

end.


