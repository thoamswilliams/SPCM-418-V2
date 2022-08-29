VERSION 5.00
Begin VB.Form formScope 
   Caption         =   "Universal Scope Example   (c) Spectrum GmbH"
   ClientHeight    =   3195
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   6435
   LinkTopic       =   "Form1"
   ScaleHeight     =   3195
   ScaleWidth      =   6435
   StartUpPosition =   3  'Windows Default
   Begin VB.PictureBox picDisplay 
      Height          =   2535
      Left            =   120
      ScaleHeight     =   2475
      ScaleWidth      =   6075
      TabIndex        =   2
      Top             =   120
      Width           =   6135
   End
   Begin VB.CommandButton butAcquire 
      Caption         =   "&Acquire"
      Height          =   375
      Left            =   4200
      TabIndex        =   1
      Top             =   2760
      Width           =   975
   End
   Begin VB.CommandButton butQuit 
      Caption         =   "&Quit"
      Height          =   375
      Left            =   5280
      TabIndex        =   0
      Top             =   2760
      Width           =   975
   End
End
Attribute VB_Name = "formScope"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

' ----- some global values -----
Dim g_hDevice As Long
Dim g_lFullScale As Long
Dim g_lBytesPerSample As Long

Const MEMSIZE As Long = 8192



' ************************************************************************
' This function tries to load the first AI devices and shows some info
' on it
' ************************************************************************

Private Sub Form_Load()
    Dim hDevice As Long
    Dim lIdx, lError, lBrdType, lSerial, lMemoryH, lMemoryL, lBrdFunction As Long
    Dim strName, strCard As String
    
    
    ' ----- we go through the cards and open the first analog input card that's available -----
    g_hDevice = 0
    For lIdx = 0 To 63
        strName = "spcm" & lIdx
        hDevice = spcm_hOpen(strName)
        If (hDevice <> 0) Then
            lError = spcm_dwGetParam_i32(hDevice, SPC_FNCTYPE, lBrdFunction)
            If (lBrdFunction = SPCM_TYPE_AI) Then
                lError = spcm_dwGetParam_i32(hDevice, SPC_PCITYP, lBrdType)
                lError = spcm_dwGetParam_i32(hDevice, SPC_PCISERIALNR, lSerial)
                lError = spcm_dwGetParam_i64m(hDevice, SPC_PCIMEMSIZE, lMemoryH, lMemoryL)
                lError = spcm_dwGetParam_i32(hDevice, SPC_MIINST_BYTESPERSAMPLE, g_lBytesPerSample)
                
                ' get the resolution and recalc it to full scale for graph scaling
                lError = spcm_dwGetParam_i32(hDevice, SPC_MIINST_BITSPERSAMPLE, g_lFullScale)
                Select Case (g_lFullScale)
                    Case 7 
                        g_lFullScale = 128

                    Case 8
                        g_lFullScale = 256

                    Case 12
                        g_lFullScale = 4096

                    Case 14
                        g_lFullScale = 16384

                    Case 16
                        g_lFullScale = 65536
                End Select

                ' show details of the selected card
                Select Case (lBrdType And TYP_SERIESMASK)
                    Case TYP_M2ISERIES
                        strCard = "M2i." & Hex(lBrdType And TYP_VERSIONMASK) & Chr(10)
                    Case TYP_M2IEXPSERIES
                        strCard = "M2i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp" & Chr(10)
                    Case TYP_M3ISERIES
                        strCard = "M3i." & Hex(lBrdType And TYP_VERSIONMASK) & Chr(10)
                    Case TYP_M3IEXPSERIES
                        strCard = "M3i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp" & Chr(10)
                    Case TYP_M4IEXPSERIES
                        strCard = "M4i." & Hex(lBrdType And TYP_VERSIONMASK) & "-x8" & Chr(10)
                    Case TYP_M4XEXPSERIES
                        strCard = "M4i." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4" & Chr(10)
                    Case TYP_M2PEXPSERIES
                        strCard = "M2p." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4" & Chr(10)
                End Select
                strCard = strCard & "s/n: " & lSerial & Chr(10)
                strCard = strCard & "Mem: " & lMemoryH * 4096 + (lMemoryL / 1024 / 1024) & " MBytes" & Chr(10)
                MsgBox ("Scope example using the following card:" & Chr(10) & Chr(10) & strCard)
                g_hDevice = hDevice
                Exit For
                
            ' other function that we don't support
            Else
                spcm_vClose (hDevice)
            End If
            
        ' last card found
        Else
            Exit For
        End If
    Next lIdx
    
    
    
    ' ----- if we didn't find a matching card we can just quit here -----
    If (g_hDevice = 0) Then
        MsgBox ("No matching Spectrum card found for the example")
        Unload formScope
    End If
End Sub



' ************************************************************************
' Acquire: start the acquistion
' ************************************************************************

Private Sub butAcquire_Click()
    Dim lError As Long
    Dim strError As String
    Dim pnData() As Integer
    Dim pbyData() As Byte
    Dim lChannels As Long
    
    
    
    ' ----- do a running and simple setup -----
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_CHENABLE, CHANNEL0)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_SAMPLERATE, 1000000)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_MEMSIZE, MEMSIZE)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_POSTTRIGGER, MEMSIZE / 2)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE)
    lError = spcm_dwGetParam_i32(g_hDevice, SPC_CHCOUNT, lChannels)
    
    
    ' ----- check for error and display error message
    If (lError) Then
        strError = String(ERRORTEXTLEN, vbNullChar)
        lError = spcm_dwGetErrorInfo_i32(g_hDevice, 0, 0, strError)
        MsgBox (strError)
        Exit Sub
    End If
    
    
    
    ' ----- do the acquistion and wait for the end -----
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_START Or M2CMD_CARD_ENABLETRIGGER Or M2CMD_CARD_WAITREADY)
    
    
    
    ' ----- read the data -----
    If (g_lBytesPerSample = 1) Then
        ReDim pbyData(lChannels - 1, MEMSIZE - 1)
        lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pbyData(0, 0), 0, 0, 0, MEMSIZE * lChannels)
    Else
        ReDim pnData(lChannels - 1, MEMSIZE - 1)
        lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pnData(0, 0), 0, 0, 0, MEMSIZE * 2 * lChannels)
    End If
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_DATA_STARTDMA Or M2CMD_DATA_WAITDMA)
    
    
    
    ' ----- display data -----
    picDisplay.Refresh
    
    Dim lChOffset As Long
    Dim dWidth, dHeigth As Double
    Dim i, j As Long
    Dim nData, nLastData As Integer
    

    ' calc settings to show signal inside the pic
    dWidth = (picDisplay.Width) / MEMSIZE
    dHeigth = (picDisplay.Height) / (g_lFullScale * lChannels)

    ' output signals
    For j = 0 To (lChannels - 1) Step 1
        lChOffset = g_lFullScale / 2 + (g_lFullScale * j)
        If (g_lBytesPerSample = 1) Then
        
            ' convert unsigned byte to signed integer
            nLastData = pbyData(j, 0)
            If (nLastData >= 128) Then
                nLastData = nLastData - 256
            End If
        
            For i = 1 To (MEMSIZE - 1) Step 1
                 
                ' line endpoint (unsigned to signed conversion)
                nData = pbyData(j, i)
                If (nData >= 128) Then
                    nData = pbyData(j, i) - 256
                End If
                
                picDisplay.Line (dWidth * (i - 1), dHeigth * (lChOffset - nLastData))-(dWidth * i, dHeigth * (lChOffset - nData))
                
                ' next line startpoint is actual line endpoint
                nLastData = nData
            Next i
        Else
            For i = 1 To (MEMSIZE - 1) Step 1
                picDisplay.Line (dWidth * (i - 1), dHeigth * (lChOffset - pnData(j, i - 1)))-(dWidth * i, dHeigth * (lChOffset - pnData(j, i)))
            Next i
        End If
    Next j
End Sub



' ************************************************************************
' Quit: stop and clean up
' ************************************************************************

Private Sub butQuit_Click()
    Dim lError As Long
    
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP)
    spcm_vClose (g_hDevice)
    Unload formScope
End Sub

