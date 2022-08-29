Attribute VB_Name = "Declarations"
Public Declare Function SpcInitPCIBoards Lib "spectrum_comp.dll" Alias "_SpcInitPCIBoards_StdCall@8" (ByRef Count As Integer, ByRef PCIVersion As Integer) As Integer
Public Declare Function SpcInitBoard Lib "spectrum_comp.dll" Alias "_SpcInitBoard_StdCall@8" (ByVal Nr As Integer, ByVal Typ As Integer) As Integer
Public Declare Function SpcGetParam Lib "spectrum_comp.dll" Alias "_SpcGetParam_StdCall@12" (ByVal BrdNr As Integer, ByVal RegNr As Long, ByRef Value As Long) As Integer
Public Declare Function SpcSetParam Lib "spectrum_comp.dll" Alias "_SpcSetParam_StdCall@12" (ByVal BrdNr As Integer, ByVal RegNr As Long, ByVal Value As Long) As Integer
Public Declare Function SpcGetData8 Lib "spectrum_comp.dll" Alias "_SpcGetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Byte) As Integer
Public Declare Function SpcSetData8 Lib "spectrum_comp.dll" Alias "_SpcSetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Byte) As Integer
Public Declare Function SpcGetData16 Lib "spectrum_comp.dll" Alias "_SpcGetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Integer) As Integer
Public Declare Function SpcSetData16 Lib "spectrum_comp.dll" Alias "_SpcSetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Integer) As Integer
Public Declare Function SpcGetData32 Lib "spectrum_comp.dll" Alias "_SpcGetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Long) As Integer
Public Declare Function SpcSetData32 Lib "spectrum_comp.dll" Alias "_SpcSetData_StdCall@20" (ByVal BrdNr As Integer, ByVal Channel As Integer, ByVal Start As Long, ByVal Length As Long, ByRef data As Long) As Integer





