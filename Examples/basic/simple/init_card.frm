VERSION 5.00
Begin VB.Form formMain 
   Caption         =   "Card Initialisation Example (c) Spectrum GmbH"
   ClientHeight    =   2640
   ClientLeft      =   60
   ClientTop       =   345
   ClientWidth     =   5745
   LinkTopic       =   "Form1"
   ScaleHeight     =   2640
   ScaleWidth      =   5745
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton buttonQuit 
      Caption         =   "&Quit"
      Height          =   375
      Left            =   4680
      TabIndex        =   1
      Top             =   2160
      Width           =   855
   End
   Begin VB.ListBox listCards 
      Height          =   1815
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   5295
   End
End
Attribute VB_Name = "formMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit


' ************************************************************************
' Quit function
' ************************************************************************

Private Sub buttonQuit_Click()
    Unload formMain
End Sub



' ************************************************************************
' This function tries to load all devices and shows them inside the list
' box
' ************************************************************************

Private Sub Form_Load()
    Dim hDevice(64) As Long
    Dim lIdx, lError, lBrdType, lSerial, lMemory As Long
    Dim strName, strCard As String
    
    ' ----- try to open the device and read out some details -----
    For lIdx = 0 To 63
        strName = "spcm" & lIdx
        hDevice(lIdx) = spcm_hOpen(strName)
        If (hDevice(lIdx) <> 0) Then
            lError = spcm_dwGetParam_i32(hDevice(lIdx), SPC_PCITYP, lBrdType)
            lError = spcm_dwGetParam_i32(hDevice(lIdx), SPC_PCISERIALNR, lSerial)
            lError = spcm_dwGetParam_i32(hDevice(lIdx), SPC_PCIMEMSIZE, lMemory)
            
            ' print the card details and add it to the list
            Select Case (lBrdType And TYP_SERIESMASK)
                Case TYP_M2ISERIES
                    strCard = "M2i." & Hex(lBrdType And TYP_VERSIONMASK)
                Case TYP_M2IEXPSERIES
                    strCard = "M2i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp"
                Case TYP_M3ISERIES
                    strCard = "M3i." & Hex(lBrdType And TYP_VERSIONMASK)
                Case TYP_M3IEXPSERIES
                    strCard = "M3i." & Hex(lBrdType And TYP_VERSIONMASK) & "-Exp"
                Case TYP_M4IEXPSERIES
                    strCard = "M4i." & Hex(lBrdType And TYP_VERSIONMASK) & "-x8"
                Case TYP_M4XEXPSERIES
                    strCard = "M4x." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4"
                Case TYP_M2PEXPSERIES
                    strCard = "M2p." & Hex(lBrdType And TYP_VERSIONMASK) & "-x4"
            End Select
            strCard = strCard & "  s/n: " & lSerial & "   Mem: " & (lMemory / 1024 / 1024) & " MBytes"
            listCards.AddItem (strCard)
        End If
    Next lIdx
    
    ' ----- close all devices again -----
    For lIdx = 0 To 63
        If (hDevice(lIdx) <> 0) Then
            spcm_vClose (hDevice(lIdx))
        End If
    Next lIdx
    
End Sub
