Attribute VB_Name = "Declarations"
'***********************************************************************
' Declarations file for spcm win32 driver (M2i cards) for Visual Basic
'
'                                                 (c) Spectrum GmbH/2006
'***********************************************************************


' ----- card handling functions -----
Public Declare Function spcm_hOpen Lib "spcm_win32.dll" Alias "_spcm_hOpen@4" (ByVal szDeviceName As String) As Long
Public Declare Function spcm_vClose Lib "spcm_win32.dll" Alias "_spcm_vClose@4" (ByVal hDevice As Long) As Long
Public Declare Function spcm_dwGetErrorInfo_i32 Lib "spcm_win32.dll" Alias "_spcm_dwGetErrorInfo_i32@16" (ByVal hDevice As Long, ByRef lErrorReg As Long, ByRef lErrorValue As Long, ByVal szErrorText As String) As Long

' ----- software register handling -----
Public Declare Function spcm_dwGetParam_i32 Lib "spcm_win32.dll" Alias "_spcm_dwGetParam_i32@12" (ByVal hDevice As Long, ByVal lRegister As Long, ByRef lValue As Long) As Long
Public Declare Function spcm_dwGetParam_i64m Lib "spcm_win32.dll" Alias "_spcm_dwGetParam_i64m@16" (ByVal hDevice As Long, ByVal lRegister As Long, ByRef lValueHigh As Long, ByRef lValueLow As Long) As Long
Public Declare Function spcm_dwSetParam_i32 Lib "spcm_win32.dll" Alias "_spcm_dwSetParam_i32@12" (ByVal hDevice As Long, ByVal lRegister As Long, ByVal lValue As Long) As Long
Public Declare Function spcm_dwSetParam_i64m Lib "spcm_win32.dll" Alias "_spcm_dwSetParam_i64m@16" (ByVal hDevice As Long, ByVal lRegister As Long, ByVal lValueHigh As Long, ByVal lValueLow As Long) As Long

' ----- data handling -----
Public Const SPCM_DIR_PCTOCARD = 0      ' transfer from PC memory to card memory
Public Const SPCM_DIR_CARDTOPC = 1      ' transfer from card memory to PC memory
Public Const SPCM_BUF_DATA = 1000       ' main data buffer for acquired or generated samples
Public Const SPCM_BUF_ABA = 2000        ' buffer for ABA data, holds the A-DATA (slow samples)
Public Const SPCM_BUF_TIMESTAMP = 3000  ' buffer for timestamps

Public Declare Function spcm_dwDefTransfer_i64m Lib "spcm_win32.dll" Alias "_spcm_dwDefTransfer_i64m@36" (ByVal hDevice As Long, ByVal dwBufType As Long, ByVal dwDirection As Long, ByVal dwNotifySize As Long, ByRef pvDataBuffer As Any, ByVal dwBrdOffsH As Long, ByVal dwBrdOffsL As Long, ByVal dwTransferLenH As Long, ByVal dwTransferLenL As Long) As Long
Public Declare Function spcm_dwInvalidateBuf Lib "spcm_win32.dll" Alias "_spcm_dwInvalidateBuf@8" (ByVal hDevice As Long, ByVal lBuffer As Long) As Long
