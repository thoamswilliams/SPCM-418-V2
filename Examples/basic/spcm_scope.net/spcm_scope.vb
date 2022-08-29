Option Strict Off
Option Explicit On
Friend Class formScope
	Inherits System.Windows.Forms.Form
#Region "Windows Form-Designer generated Code "
    Public Sub New()
        MyBase.New()
        If m_vb6FormDefInstance Is Nothing Then
            If m_InitializingDefInstance Then
                m_vb6FormDefInstance = Me
            Else
                Try
                    'Für das Startformular ist die zuerst erstellte Instanz die Standardinstanz.
                    If System.Reflection.Assembly.GetExecutingAssembly.EntryPoint.DeclaringType Is Me.GetType Then
                        m_vb6FormDefInstance = Me
                    End If
                Catch
                End Try
            End If
        End If
        'Dieser Aufruf ist für den Windows Form-Designer erforderlich.
        InitializeComponent()
    End Sub
    'Das Formular überschreibt den Löschvorgang, um die Komponentenliste zu bereinigen.
    Protected Overloads Overrides Sub Dispose(ByVal Disposing As Boolean)
        If Disposing Then
            If Not components Is Nothing Then
                components.Dispose()
            End If
        End If
        MyBase.Dispose(Disposing)
    End Sub
    'Wird vom Windows Form-Designer benötigt.
    Private components As System.ComponentModel.IContainer
    Public ToolTip1 As System.Windows.Forms.ToolTip
    Public WithEvents picDisplay As System.Windows.Forms.PictureBox
    Public WithEvents butAcquire As System.Windows.Forms.Button
    Public WithEvents butQuit As System.Windows.Forms.Button
    'Hinweis: Die folgende Prozedur wird vom Windows Form-Designer benötigt.
    'Das Verändern mit dem Windows Form-Designer ist nicht möglich.
    'Das Verändern mit dem Code-Editor ist nicht möglich.
    <System.Diagnostics.DebuggerStepThrough()> Private Sub InitializeComponent()
        Dim resources As System.Resources.ResourceManager = New System.Resources.ResourceManager(GetType(formScope))
        Me.components = New System.ComponentModel.Container
        Me.ToolTip1 = New System.Windows.Forms.ToolTip(components)
        Me.ToolTip1.Active = True
        Me.picDisplay = New System.Windows.Forms.PictureBox
        Me.butAcquire = New System.Windows.Forms.Button
        Me.butQuit = New System.Windows.Forms.Button
        Me.Text = "Universal Scope Example   (c) Spectrum GmbH"
        Me.ClientSize = New System.Drawing.Size(429, 213)
        Me.Location = New System.Drawing.Point(4, 23)
        Me.StartPosition = System.Windows.Forms.FormStartPosition.WindowsDefaultLocation
        Me.AutoScaleBaseSize = New System.Drawing.Size(5, 13)
        Me.BackColor = System.Drawing.SystemColors.Control
        Me.FormBorderStyle = System.Windows.Forms.FormBorderStyle.Sizable
        Me.ControlBox = True
        Me.Enabled = True
        Me.KeyPreview = False
        Me.MaximizeBox = True
        Me.MinimizeBox = True
        Me.Cursor = System.Windows.Forms.Cursors.Default
        Me.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.ShowInTaskbar = True
        Me.HelpButton = False
        Me.WindowState = System.Windows.Forms.FormWindowState.Normal
        Me.Name = "formScope"
        Me.picDisplay.Size = New System.Drawing.Size(409, 169)
        Me.picDisplay.Location = New System.Drawing.Point(8, 8)
        Me.picDisplay.TabIndex = 2
        Me.picDisplay.Dock = System.Windows.Forms.DockStyle.None
        Me.picDisplay.BackColor = System.Drawing.SystemColors.Control
        Me.picDisplay.CausesValidation = True
        Me.picDisplay.Enabled = True
        Me.picDisplay.ForeColor = System.Drawing.SystemColors.ControlText
        Me.picDisplay.Cursor = System.Windows.Forms.Cursors.Default
        Me.picDisplay.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.picDisplay.TabStop = True
        Me.picDisplay.Visible = True
        Me.picDisplay.SizeMode = System.Windows.Forms.PictureBoxSizeMode.Normal
        Me.picDisplay.BorderStyle = System.Windows.Forms.BorderStyle.Fixed3D
        Me.picDisplay.Name = "picDisplay"
        Me.butAcquire.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.butAcquire.Text = "&Acquire"
        Me.butAcquire.Size = New System.Drawing.Size(65, 25)
        Me.butAcquire.Location = New System.Drawing.Point(280, 184)
        Me.butAcquire.TabIndex = 1
        Me.butAcquire.BackColor = System.Drawing.SystemColors.Control
        Me.butAcquire.CausesValidation = True
        Me.butAcquire.Enabled = True
        Me.butAcquire.ForeColor = System.Drawing.SystemColors.ControlText
        Me.butAcquire.Cursor = System.Windows.Forms.Cursors.Default
        Me.butAcquire.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.butAcquire.TabStop = True
        Me.butAcquire.Name = "butAcquire"
        Me.butQuit.TextAlign = System.Drawing.ContentAlignment.MiddleCenter
        Me.butQuit.Text = "&Quit"
        Me.butQuit.Size = New System.Drawing.Size(65, 25)
        Me.butQuit.Location = New System.Drawing.Point(352, 184)
        Me.butQuit.TabIndex = 0
        Me.butQuit.BackColor = System.Drawing.SystemColors.Control
        Me.butQuit.CausesValidation = True
        Me.butQuit.Enabled = True
        Me.butQuit.ForeColor = System.Drawing.SystemColors.ControlText
        Me.butQuit.Cursor = System.Windows.Forms.Cursors.Default
        Me.butQuit.RightToLeft = System.Windows.Forms.RightToLeft.No
        Me.butQuit.TabStop = True
        Me.butQuit.Name = "butQuit"
        Me.Controls.Add(picDisplay)
        Me.Controls.Add(butAcquire)
        Me.Controls.Add(butQuit)
    End Sub
#End Region
#Region "Aktualisierungssupport "
    Private Shared m_vb6FormDefInstance As formScope
    Private Shared m_InitializingDefInstance As Boolean
    Public Shared Property DefInstance() As formScope
        Get
            If m_vb6FormDefInstance Is Nothing OrElse m_vb6FormDefInstance.IsDisposed Then
                m_InitializingDefInstance = True
                m_vb6FormDefInstance = New formScope
                m_InitializingDefInstance = False
            End If
            DefInstance = m_vb6FormDefInstance
        End Get
        Set(ByVal Value As formScope)
            m_vb6FormDefInstance = Value
        End Set
    End Property
#End Region

    ' ----- some global values -----
    Dim g_hDevice As Integer
    Dim g_lFullScale As Integer
    Dim g_lBytesPerSample As Integer

    Const MEMSIZE As Integer = 8192

    ' ************************************************************************
    ' This function tries to load the first AI devices and shows some info
    ' on it
    ' ************************************************************************

    Private Sub formScope_Load(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles MyBase.Load
        Dim hDevice As Integer
        Dim lMemoryH, lBrdType, lIdx, lError, lSerial, lMemoryL As Object
        Dim lBrdFunction As Integer
        Dim strName As Object
        Dim strCard As String

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
                            strCard = "M4x." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4" & Chr(10)
                        Case TYP_M2PEXPSERIES
                            strCard = "M2p." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4" & Chr(10)
                    End Select

                    strCard = strCard & "s/n: " & lSerial & Chr(10)

                    strCard = strCard & "Mem: " & lMemoryH * 4096 + (lMemoryL / 1024 / 1024) & " MBytes" & Chr(10)
                    MsgBox("Scope example using the following card:" & Chr(10) & Chr(10) & strCard)
                    g_hDevice = hDevice
                    Exit For

                    ' other function that we don't support
                Else
                    spcm_vClose(hDevice)
                End If

                ' last card found
            Else
                Exit For
            End If
        Next lIdx

        ' ----- if we didn't find a matching card we can just quit here -----
        If (g_hDevice = 0) Then
            MsgBox("No matching Spectrum card found for the example")
            formScope.DefInstance.Close()
        End If
    End Sub



    ' ************************************************************************
    ' Acquire: start the acquistion
    ' ************************************************************************

    Private Sub butAcquire_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles butAcquire.Click
        Dim lError As Integer
        Dim strError As String
        Dim pnData() As Short
        Dim pbyData() As Byte
        Dim lChannels As Integer

        ' ----- do a running and simple setup -----
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_CHENABLE, CHANNEL0)
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_SAMPLERATE, 1000000)
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_MEMSIZE, MEMSIZE)
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_POSTTRIGGER, MEMSIZE / 2)
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE)
        lError = spcm_dwGetParam_i32(g_hDevice, SPC_CHCOUNT, lChannels)

        ' ----- check for error and display error message
        If (lError) Then
            strError = New String(vbNullChar, ERRORTEXTLEN)
            lError = spcm_dwGetErrorInfo_i32(g_hDevice, 0, 0, strError)
            MsgBox(strError)
            Exit Sub
        End If

        ' ----- do the acquistion and wait for the end -----
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_START Or M2CMD_CARD_ENABLETRIGGER Or M2CMD_CARD_WAITREADY)

        ' ----- read the data -----
        If (g_lBytesPerSample = 1) Then
            ReDim pbyData(lChannels * MEMSIZE - 1)
            lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pbyData(0), 0, 0, 0, MEMSIZE * lChannels)
        Else
            ReDim pnData(lChannels * MEMSIZE - 1)
            lError = spcm_dwDefTransfer_i64m(g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pnData(0), 0, 0, 0, MEMSIZE * 2 * lChannels)
        End If
        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_DATA_STARTDMA Or M2CMD_DATA_WAITDMA)

        ' ----- display data -----
        picDisplay.Refresh()

        Dim lChOffset As Integer
        Dim dWidth As Object
        Dim dHeigth As Double
        Dim i As Object
        Dim j As Integer
        Dim nData As Object
        Dim nLastData As Short
        Dim pPainter As System.Drawing.Graphics
        Dim pPen As New System.Drawing.Pen(System.Drawing.Color.Red)
        Dim dX1 As Single
        Dim dY1 As Single
        Dim dX2 As Single
        Dim dY2 As Single

        ' calc settings to show signal inside the pic
        dWidth = (picDisplay.Width) / MEMSIZE
        dHeigth = (picDisplay.Height) / (g_lFullScale * lChannels)

        pPainter = picDisplay.CreateGraphics()

        For j = 0 To (lChannels - 1) Step 1
            ' output signals
            lChOffset = g_lFullScale / 2 + (g_lFullScale * j)
            If (g_lBytesPerSample = 1) Then

                ' convert unsigned byte to signed integer
                nLastData = pbyData(j)
                If (nLastData >= 128) Then
                    nLastData = nLastData - 256
                End If

                ' demultiplex and paint data
                For i = 0 To (MEMSIZE - (lChannels + 1)) Step lChannels

                    ' line endpoint (unsigned to signed conversion)
                    nData = pbyData(i * lChannels + j)

                    If (nData >= 128) Then
                        nData = pbyData(i * lChannels + j) - 256
                    End If

                    dX1 = dWidth * (i)
                    dY1 = dHeigth * (lChOffset - nLastData)
                    dX2 = dWidth * (i + 1)
                    dY2 = dHeigth * (lChOffset - nData)

                    pPainter.DrawLine(pPen, dX1, dY1, dX2, dY2)

                    ' next line startpoint is actual line endpoint
                    nLastData = nData
                Next i
            Else
                ' demultiplex and paint data
                For i = 0 To (MEMSIZE - (lChannels + 1)) Step lChannels
                    dX1 = dWidth * i
                    dY1 = dHeigth * (lChOffset - pnData(i * lChannels + j))
                    dX2 = dWidth * (i + 1)
                    dY2 = dHeigth * (lChOffset - pnData(i * lChannels + j + lChannels))

                    pPainter.DrawLine(pPen, dX1, dY1, dX2, dY2)
                Next i
            End If
        Next j

        pPen.Dispose()
        pPainter.Dispose()

    End Sub



    ' ************************************************************************
    ' Quit: stop and clean up
    ' ************************************************************************

    Private Sub butQuit_Click(ByVal eventSender As System.Object, ByVal eventArgs As System.EventArgs) Handles butQuit.Click
        Dim lError As Integer

        lError = spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP)
        spcm_vClose(g_hDevice)
        formScope.DefInstance.Close()
    End Sub
End Class
