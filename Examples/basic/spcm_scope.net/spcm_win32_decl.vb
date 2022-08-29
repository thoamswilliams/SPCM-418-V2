Option Strict Off
Option Explicit On
Module Declarations
	'***********************************************************************
	' Declarations file for spcm win32 driver (M2i cards) for
	' Visual Basic .NET (VB.NET)
	'
	'                                                 (c) Spectrum GmbH/2006
	'***********************************************************************


	' ----- card handling functions -----
	Public Declare Function spcm_hOpen Lib "spcm_win32.dll"  Alias "_spcm_hOpen@4"(ByVal szDeviceName As String) As Integer
	Public Declare Function spcm_vClose Lib "spcm_win32.dll"  Alias "_spcm_vClose@4"(ByVal hDevice As Integer) As Integer
	Public Declare Function spcm_dwGetErrorInfo_i32 Lib "spcm_win32.dll"  Alias "_spcm_dwGetErrorInfo_i32@16"(ByVal hDevice As Integer, ByRef lErrorReg As Integer, ByRef lErrorValue As Integer, ByVal szErrorText As String) As Integer

	' ----- software register handling -----
	Public Declare Function spcm_dwGetParam_i32 Lib "spcm_win32.dll"  Alias "_spcm_dwGetParam_i32@12"(ByVal hDevice As Integer, ByVal lRegister As Integer, ByRef lValue As Integer) As Integer
	Public Declare Function spcm_dwGetParam_i64m Lib "spcm_win32.dll"  Alias "_spcm_dwGetParam_i64m@16"(ByVal hDevice As Integer, ByVal lRegister As Integer, ByRef lValueHigh As Integer, ByRef lValueLow As Integer) As Integer
	Public Declare Function spcm_dwSetParam_i32 Lib "spcm_win32.dll"  Alias "_spcm_dwSetParam_i32@12"(ByVal hDevice As Integer, ByVal lRegister As Integer, ByVal lValue As Integer) As Integer
	Public Declare Function spcm_dwSetParam_i64m Lib "spcm_win32.dll"  Alias "_spcm_dwSetParam_i64m@16"(ByVal hDevice As Integer, ByVal lRegister As Integer, ByVal lValueHigh As Integer, ByVal lValueLow As Integer) As Integer

	' ----- data handling -----
	Public Const SPCM_DIR_PCTOCARD As Short = 0 ' transfer from PC memory to card memory
	Public Const SPCM_DIR_CARDTOPC As Short = 1 ' transfer from card memory to PC memory
	Public Const SPCM_BUF_DATA As Short = 1000 ' main data buffer for acquired or generated samples
	Public Const SPCM_BUF_ABA As Short = 2000 ' buffer for ABA data, holds the A-DATA (slow samples)
	Public Const SPCM_BUF_TIMESTAMP As Short = 3000 ' buffer for timestamps

    ' ----- buffer handling -----
    Public Declare Function spcm_dwDefTransfer_i64m Lib "spcm_win32.dll" Alias "_spcm_dwDefTransfer_i64m@36" (ByVal hDevice As Integer, ByVal dwBufType As Integer, ByVal dwDirection As Integer, ByVal dwNotifySize As Integer, ByRef pvDataBuffer As Byte, ByVal dwBrdOffsH As Integer, ByVal dwBrdOffsL As Integer, ByVal dwTransferLenH As Integer, ByVal dwTransferLenL As Integer) As Integer
    Public Declare Function spcm_dwDefTransfer_i64m Lib "spcm_win32.dll" Alias "_spcm_dwDefTransfer_i64m@36" (ByVal hDevice As Integer, ByVal dwBufType As Integer, ByVal dwDirection As Integer, ByVal dwNotifySize As Integer, ByRef pvDataBuffer As Short, ByVal dwBrdOffsH As Integer, ByVal dwBrdOffsL As Integer, ByVal dwTransferLenH As Integer, ByVal dwTransferLenL As Integer) As Integer
	Public Declare Function spcm_dwInvalidateBuf Lib "spcm_win32.dll"  Alias "_spcm_dwInvalidateBuf@8"(ByVal hDevice As Integer, ByVal lBuffer As Integer) As Integer
End Module