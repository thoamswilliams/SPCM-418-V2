VERSION 5.00
Begin VB.Form form_fifo_single 
   BackColor       =   &H8000000A&
   Caption         =   "Fifo Single Example"
   ClientHeight    =   2835
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5295
   ScaleHeight     =   2835
   ScaleWidth      =   5295
   Begin VB.TextBox textMem 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   2040
      Locked          =   -1  'True
      TabIndex        =   8
      Text            =   "4096 MBytes"
      Top             =   240
      Width           =   1215
   End
   Begin VB.TextBox textSN 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   1200
      TabIndex        =   7
      Text            =   "123456"
      Top             =   240
      Width           =   735
   End
   Begin VB.TextBox textType 
      Alignment       =   2  'Center
      BackColor       =   &H00E0E0E0&
      Height          =   285
      Left            =   120
      TabIndex        =   6
      Text            =   "M2I.3010"
      Top             =   240
      Width           =   975
   End
   Begin VB.CommandButton buttonStop 
      Caption         =   "Stop"
      Height          =   255
      Left            =   1080
      TabIndex        =   4
      Top             =   2400
      Width           =   855
   End
   Begin VB.CommandButton buttonQuit 
      Caption         =   "Quit"
      Height          =   255
      Left            =   4320
      TabIndex        =   3
      Top             =   2400
      Width           =   855
   End
   Begin VB.PictureBox display 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FFFF&
      Height          =   1035
      Left            =   120
      ScaleHeight     =   975
      ScaleWidth      =   4155
      TabIndex        =   2
      Top             =   720
      Width           =   4215
   End
   Begin VB.TextBox TextField 
      Alignment       =   1  'Right Justify
      BackColor       =   &H00000000&
      BeginProperty DataFormat 
         Type            =   0
         Format          =   "0;(0)"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   1031
         SubFormatType   =   0
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   285
      Left            =   1320
      TabIndex        =   1
      Top             =   1800
      Width           =   3015
   End
   Begin VB.CommandButton buttonStart 
      Caption         =   "Start"
      Height          =   255
      Left            =   120
      TabIndex        =   0
      Top             =   2400
      Width           =   855
   End
   Begin VB.Label labelAmplMin 
      Height          =   255
      Left            =   4440
      TabIndex        =   13
      Top             =   1680
      Width           =   615
   End
   Begin VB.Label labelAmplMax 
      Height          =   255
      Left            =   4500
      TabIndex        =   12
      Top             =   600
      Width           =   615
   End
   Begin VB.Label labelMem 
      Caption         =   "Mem:"
      Height          =   255
      Left            =   2040
      TabIndex        =   11
      Top             =   0
      Width           =   495
   End
   Begin VB.Label labelSN 
      Caption         =   "SN:"
      Height          =   255
      Left            =   1200
      TabIndex        =   10
      Top             =   0
      Width           =   495
   End
   Begin VB.Label labelType 
      Caption         =   "Type:"
      Height          =   255
      Left            =   120
      TabIndex        =   9
      Top             =   0
      Width           =   495
   End
   Begin VB.Label Label 
      Caption         =   "Transferred"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   5
      Top             =   1830
      Width           =   1095
   End
End
Attribute VB_Name = "form_fifo_single"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Const AMPL_mV As Long = 1000

' ----- data buffers -----
Const BUFSIZE_IN_SAMPLES As Long = 4194304  ' 4MSample

' ----- data buffer 8 bit -----
Dim pbyData(BUFSIZE_IN_SAMPLES) As Byte

' ----- data buffer 16 bit -----
Dim pnData(BUFSIZE_IN_SAMPLES) As Integer

' ----- plot buffers -----
Const PLOT_BUFSIZE As Long = 4096

Dim g_xValues(PLOT_BUFSIZE - 1) As Long
Dim g_y1Values(PLOT_BUFSIZE - 1) As Long
Dim g_y2Values(PLOT_BUFSIZE - 1) As Long
Dim g_PlotBufIdx As Long

' ----- some global values -----
Dim g_hDevice As Long
Dim g_lFullScale As Long
Dim g_lBytesPerSample As Long

Dim g_bFIFORunning As Boolean
Dim g_bStop As Boolean
Dim g_bQuit As Boolean

Private Sub buttonQuit_Click()
    If (g_bFIFORunning = True) Then
        g_bStop = True
        g_bQuit = True
    Else
        spcm_vClose (g_hDevice)
        Unload form_fifo_single
    End If
End Sub

Private Sub buttonStop_Click()
    g_bStop = True
End Sub

Private Sub ButtonStart_Click()
    Dim lError As Long
    Dim lAvailBytes As Long
    Dim dAvailBytes As Double
    Dim lAvailPos As Long
    Dim dTotalMBytes As Double
    Dim lTransferedMBytes As Long
    Dim lStatus As Long
    Dim lZeroLinePos As Long
    Dim lMinY As Long
    Dim lMaxY As Long
    Dim lBufferIdx As Long
    Dim lMaxYVal As Long
    Dim lMinYVal As Long
    Dim dMulti As Double
    Dim i As Long
    
    dTotalMBytes = 0
    lZeroLinePos = display.Height / 2
    g_bFIFORunning = True
    g_bStop = False
     
    ' ----- reset board -----
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_RESET)
     
    ' ----- setup board -----
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_CARDMODE, SPC_REC_FIFO_SINGLE)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_CHENABLE, CHANNEL0)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_AMP0, AMPL_mV)
    lError = spcm_dwSetParam_i64m(g_hDevice, SPC_PRETRIGGER, 0, 16)
    lError = spcm_dwSetParam_i64m(g_hDevice, SPC_SEGMENTSIZE, 0, 1024)
    lError = spcm_dwSetParam_i64m(g_hDevice, SPC_LOOPS, 0, 0)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_CLOCKMODE, SPC_CM_INTPLL)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_SAMPLERATE, 1000000)
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE)
    
    ' ----- setup board for data transfer -----
    If (g_lBytesPerSample = 1) Then
        lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 4096, pbyData(0), 0, 0, 0, BUFSIZE_IN_SAMPLES)
    Else
        lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 4096, pnData(0), 0, 0, 0, BUFSIZE_IN_SAMPLES * 2)
    End If
    
    ' ----- start board and DMA -----
    lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_START Or M2CMD_CARD_ENABLETRIGGER Or M2CMD_DATA_STARTDMA)
    
    ' ----- run FIFO loop -----
    While (g_bStop = False)
        
        ' ----- wait for DMA -----
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_DATA_WAITDMA)
    
        ' ----- read card status -----
        lError = spcm_dwGetParam_i32(g_hDevice, SPC_M2STATUS, lStatus)
        
        ' ----- check if data block is ready -----
        If ((lStatus& And M2STAT_DATA_BLOCKREADY) = M2STAT_DATA_BLOCKREADY) Then
        
            ' ----- get available bytes and position pointer -----
            lError = spcm_dwGetParam_i32(g_hDevice, SPC_DATA_AVAIL_USER_LEN, lAvailBytes)
            lError = spcm_dwGetParam_i32(g_hDevice, SPC_DATA_AVAIL_USER_POS, lAvailPos)
        
            ' ----- in this example only channel 0 is used -----
        
            ' ----- get min and max value of the available data -----
            lMinY = 65000
            lMaxY = -65000
        
            For i = lAvailPos To lAvailPos + lAvailBytes
        
                lBufferIdx = i Mod BUFSIZE_IN_SAMPLES
            
                If (g_lBytesPerSample = 1) Then
                    If (pbyData(lBufferIdx) < lMinY) Then lMinY = pbyData(lBufferIdx)
                    If (pbyData(lBufferIdx) > lMaxY) Then lMaxY = pbyData(lBufferIdx)
                Else
                    If (pnData(lBufferIdx) < lMinY) Then lMinY = pnData(lBufferIdx)
                    If (pnData(lBufferIdx) > lMaxY) Then lMaxY = pnData(lBufferIdx)
                End If
            Next i
                
            ' ----- calculate plot position -----
            dMulti = lMaxY / (g_lFullScale / 2)
            lMaxYVal = lZeroLinePos * dMulti
            lMaxYVal = lZeroLinePos - lMaxYVal
        
            dMulti = lMinY / (g_lFullScale / 2)
            lMinYVal = lZeroLinePos * dMulti
            lMinYVal = lZeroLinePos - lMinYVal
        
            ' ----- add new min and max value to plot buffers -----
            AddToPlotBuffers lMaxYVal, lMinYVal
        
            ' ----- plot buffers -----
            PlotData
        
            ' ----- calculate values of transferred MBytes -----
            dAvailBytes = lAvailBytes
            dTotalMBytes = dTotalMBytes + (dAvailBytes / 1024 / 1024)
            lTransferedMBytes = dTotalMBytes
        
            ' ----- write transferred MBbytes value to text field -----
            TextField.Text = lTransferedMBytes & " MBytes"
            TextField.Refresh
        
            ' ----- free memory of the data buffer -----
            lError = spcm_dwSetParam_i32(g_hDevice, SPC_DATA_AVAIL_CARD_LEN, lAvailBytes)
        
            ' ----- check for events -----
            DoEvents
        End If
    Wend
    
    If (g_bQuit = True) Then
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP)
        spcm_vClose (g_hDevice)
        Unload form_fifo_single
    Else
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP)
        g_bFIFORunning = False
    End If
End Sub

' ************************************************************************
' This function tries to load the first AI devices and shows some info
' on it
' ************************************************************************

Private Sub Form_Load()
    Dim hDevice As Long
    Dim lIdx, lError, lBrdType, lSerial, lMemoryH, lMemoryL, lBrdFunction As Long
    Dim strName, strType, strSN, strMem As String
    
    g_bFIFORunning = False
    g_bQuit = False
    g_PlotBufIdx = 0
    
    display.AutoRedraw = True
    SetAmplitudeLabel AMPL_mV
    
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
                    Case 8
                        g_lFullScale = 256
                        
                    Case 12
                        g_lFullScale = 4096
                        
                    Case 14
                        g_lFullScale = 16384
                        
                    Case 16
                        g_lFullScale = 65536
                End Select
                                    
                ' set details of the selected card
                Select Case (lBrdType And TYP_SERIESMASK)
                    Case TYP_M2ISERIES
                        strType = "M2i." & Hex(lBrdType And TYP_VERSIONMASK)
                    Case TYP_M2IEXPSERIES
                        strType = "M2i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp"
                    Case TYP_M3ISERIES
                        strType = "M3i." & Hex(lBrdType And TYP_VERSIONMASK)
                    Case TYP_M3IEXPSERIES
                        strType = "M3i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp"
                    Case TYP_M4IEXPSERIES
                        strType = "M4i." & Hex(lBrdType And TYP_VERSIONMASK) & "-x8"
                    Case TYP_M4XEXPSERIES
                        strType = "M4i." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4"
                    Case TYP_M2PEXPSERIES
                        strType = "M2p." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4"
                End Select
                
                strSN = lSerial
                strMem = lMemoryH * 4096 + (lMemoryL / 1024 / 1024) & " MBytes"
                
                textType.Text = strType
                textSN.Text = strSN
                textMem.Text = strMem
                
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
        Unload form_fifo_single
    End If
End Sub

Private Sub AddToPlotBuffers(ByVal lYValMax As Integer, ByVal lYValMin As Integer)
    Dim lIndex As Long
    Dim i As Long
    
    ' ----- set correct index -----
    g_PlotBufIdx = g_PlotBufIdx Mod PLOT_BUFSIZE
    
    ' ----- set y values of the plot buffers -----
    g_y1Values(g_PlotBufIdx) = lYValMax
    g_y2Values(g_PlotBufIdx) = lYValMin
    
    ' ----- set x values of the plot buffers -----
    lIndex = 0
    For i = g_PlotBufIdx To 0 Step -1
        g_xValues(i) = lIndex
        lIndex = lIndex + 1
    Next i
    
    If g_PlotBufIdx < PLOT_BUFSIZE - 1 Then
        For i = PLOT_BUFSIZE - 1 To g_PlotBufIdx + 1 Step -1
            g_xValues(i) = lIndex
            lIndex = lIndex + 1
        Next i
    End If
    
    ' ----- set index to next position -----
    g_PlotBufIdx = g_PlotBufIdx + 1

End Sub

Private Sub PlotData()
    Dim i As Long
    
    ' ----- clear display -----
    display.Cls
    
    ' ----- plot values of the plot buffers -----
    For i = 0 To PLOT_BUFSIZE - 1
        display.Line (g_xValues(i), g_y1Values(i))-(g_xValues(i), g_y2Values(i))
    Next i
End Sub

Private Sub SetAmplitudeLabel(ByVal lAmplitude_mV As Integer)

    ' ----- set value of range -----
    Select Case lAmplitude_mV
        Case 50
            labelAmplMax.Caption = "50 mV"
            labelAmplMin.Caption = "-50 mV"
        Case 100
            labelAmplMax.Caption = "100 mV"
            labelAmplMin.Caption = "-100 mV"
        Case 200
            labelAmplMax.Caption = "200 mV"
            labelAmplMin.Caption = "-200 mV"
        Case 500
            labelAmplMax.Caption = "500 mV"
            labelAmplMin.Caption = "-500 mV"
        Case 1000
            labelAmplMax.Caption = "1 V"
            labelAmplMin.Caption = "-1 V"
        Case 2000
            labelAmplMax.Caption = "2 V"
            labelAmplMin.Caption = "-2 V"
        Case 2500
            labelAmplMax.Caption = "2.5 V"
            labelAmplMin.Caption = "-2.5 V"
        Case 5000
            labelAmplMax.Caption = "5 V"
            labelAmplMin.Caption = "-5 V"
        Case 10000
            labelAmplMax.Caption = "10 V"
            labelAmplMin.Caption = "-10 V"
        Case Else
            labelAmplMax.Caption = "1 V"
            labelAmplMin.Caption = "-1 V"
    End Select
End Sub








