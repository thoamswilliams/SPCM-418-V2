{******************************************************************************
 * Delphi 4 replay stream example for all cards that support the SpcM interface (M2i) *
 ******************************************************************************}

unit spcm_rep_stream_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  SpcRegs, SpcErr, spcm_win32, ExtCtrls, ComCtrls, Spin;     // Spectrum specific Units

{******************************************************************************
FifoThread
******************************************************************************}
type
  FifoThread = class (TThread)

constructor Create (LabelDataInfo : TLabel; LabelCardInfo : TLabel; lSignalType : int32); overload;
constructor Create (LabelDataInfo : TLabel; LabelCardInfo : TLabel; sFileName : string); overload;

public
  m_bStop        : boolean;
  m_lSignalType  : int32;

private
  m_LabelDataInfo       : TLabel;
  m_LabelCardInfo       : TLabel;
  m_llTransferredBytes  : int64;
  m_lFileBytesPerSample : int32;
  m_bFromFile           : boolean;
  m_sFileName           : string;
  m_sCardInfoText       : string;
  m_Stream              : TStream;

protected
  procedure Execute; override;
  procedure DoPainting;
  procedure GetSignalData (llBufIdx : int64; llLen : int64);
end;

type
    TformMain = class(TForm)
    ButtonQuit         : TButton;
    ButtonStart        : TButton;
    ButtonStop         : TButton;
    ComboBoxSignalType : TComboBox;
    SlideAmpl          : TTrackBar;
    LabelAmpl          : TLabel;
    SlideOffset        : TTrackBar;
    LabelBufSize       : TLabel;
    LabelNotify        : TLabel;
    LabelOffset        : TLabel;
    LabelOutput        : TLabel;
    EditSRate          : TEdit;
    LabelSRate         : TLabel;
    LabelTransfer      : TLabel;
    EditFileName: TEdit;
    CheckBoxFromFile: TCheckBox;
    LabelInfo: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure ButtonQuitClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ThreadDone (Sender: TObject);
    procedure ComboBoxSignalTypeChange(Sender: TObject);
    procedure SlideAmplChange(Sender: TObject);
    procedure SlideOffsetChange(Sender: TObject);
    procedure CheckBoxFromFileClick(Sender: TObject);
private
  { Private-Deklarationen}
public
  { Public-Deklarationen}
end;

var
  formMain          : TformMain;
  thread            : FifoThread;

  g_sError          : array[0..ERRORTEXTLEN] of char;
  g_dwError         : uint32;

  g_hDevice         : int32;
  g_lBytesPerSample : int32;
  g_lMaxDACValue    : int32;

  g_pnData          : ^TNData;
  g_pbyData         : ^TCData;

  g_bThreadStart    : boolean;

const BUFSIZE = 1024 * 1024 * 8;
const NOTIFY  = 4096;

{******************************************************************************
FormCreate: look for a matching Spectrum card
******************************************************************************}
implementation

{$R *.DFM}

procedure TformMain.FormCreate(Sender: TObject);
var
  hDevice: int32;
  lIdx, lBrdType, lSerial, lBrdFunction: int32;
  llMemory: int64;
  strName: AnsiString;
  strCard: String;
  lBufSize, lNotify : int32;

begin
  g_bThreadStart       := false;
  ButtonStop.Enabled   := false;
  EditFileName.Enabled := false;

  ComboBoxSignalType.Items.Add ('Sine signal');
  ComboBoxSignalType.Items.Add ('Max signal');
  ComboBoxSignalType.Items.Add ('Min signal');
  ComboBoxSignalType.Items.Add ('Zero signal');

  ComboBoxSignalType.ItemIndex := 0;

  lBufSize := trunc (BUFSIZE / 1024 / 1024);
  lNotify  := trunc (NOTIFY / 1024);

  LabelBufSize.caption := 'Used Buffer size : ' + intToStr(lBufSize) + ' MByte';
  LabelNotify.caption  := 'Used Notify size : ' + intToStr(lNotify) + ' kBytes';

  // ----- we go through the cards and open the first analog output card that is available -----
  g_hDevice := 0;
  for lIdx := 0 to 63 do
    if (g_hDevice = 0) then
      begin
      strName := 'spcm' + inttostr(lIdx);
      hDevice := spcm_hOpen (PAnsiChar(strName));

      if (hDevice <> 0) then
        begin
        spcm_dwGetParam_i32(hDevice, SPC_FNCTYPE, lBrdFunction);
          if (lBrdFunction = SPCM_TYPE_AO) then
            begin
            spcm_dwGetParam_i32(hDevice, SPC_PCITYP, lBrdType);
            spcm_dwGetParam_i32(hDevice, SPC_PCISERIALNR, lSerial);
            spcm_dwGetParam_i64(hDevice, SPC_PCIMEMSIZE,  llMemory);
            spcm_dwGetParam_i32(hDevice, SPC_MIINST_BYTESPERSAMPLE, g_lBytesPerSample);
            spcm_dwGetParam_i32(hDevice, SPC_MIINST_MAXADCVALUE, g_lMaxDACValue);

            // show details of the selected card
            case (lBrdType and TYP_SERIESMASK) of
              TYP_M2ISERIES:    strCard := 'M2i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + #10#13;
              TYP_M2IEXPSERIES: strCard := 'M2i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-Exp' + #10#13;
              TYP_M4IEXPSERIES: strCard := 'M4i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x8' + #10#13;
              TYP_M4XEXPSERIES: strCard := 'M4x.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x4' + #10#13;
              TYP_M2PEXPSERIES: strCard := 'M2p.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x4' + #10#13;
            end;

            strCard := strCard + 's/n: ' + inttostr(lSerial) + #10#13;
            strCard := strCard + 'Mem: ' + inttostr(trunc(llMemory / 1024 / 1024)) + ' MBytes' + #10#13;
            MessageDlg ('Replay stream example using the following card:' + #10#10#13 + strCard, mtInformation, [mbOK], 0);
            g_hDevice := hDevice;

            // other function that we don't support
            end
          else
            spcm_vClose (hDevice);
          end;
        end;

    // ----- if we didn't find a matching card we can just quit here -----
    if (g_hDevice = 0) then
      MessageDlg ('No matching Spectrum card found for the example', mtInformation, [mbOK], 0);
end;

{******************************************************************************
Quit Button Event
******************************************************************************}
procedure TformMain.ButtonQuitClick(Sender: TObject);
begin
     formMain.Close;
end;

{******************************************************************************
FifoThread: Constructor
******************************************************************************}
constructor FifoThread.Create (LabelDataInfo : TLabel; LabelCardInfo : TLabel; lSignalType : int32);
begin
  m_LabelDataInfo := LabelDataInfo;
  m_LabelCardInfo := LabelCardInfo;
  m_lSignalType   := lSignalType;
  m_bFromFile     := false;
  m_bStop         := false;

  inherited Create(False);
end;

{******************************************************************************
FifoThread: Constructor
******************************************************************************}
constructor FifoThread.Create (LabelDataInfo : TLabel; LabelCardInfo : TLabel; sFileName : string);
begin
  m_LabelDataInfo := LabelDataInfo;
  m_LabelCardInfo := LabelCardInfo;
  m_sFileName     := sFileName;
  m_bFromFile     := true;
  m_bStop         := false;

  m_Stream := TFileStream.Create(m_sFileName, fmOpenRead);
  m_Stream.Read (m_lFileBytesPerSample, SizeOf(m_lFileBytesPerSample));

  if ((g_lBytesPerSample = 1) and (m_lFileBytesPerSample = 2)) then
  begin
    m_bStop := true;
    MessageDlg ('Mismatch: File data is not 8 bit data.', mtInformation, [mbOK], 0);
  end;

  inherited Create(False);
end;

{******************************************************************************
FifoThread: Painting method
******************************************************************************}
procedure FifoThread.DoPainting;
begin
  m_LabelDataInfo.Caption := intToStr (trunc (m_llTransferredBytes / 1024 / 1024)) + ' MBytes transferred';
  m_LabelCardInfo.Caption := m_sCardInfoText;
end;

{******************************************************************************
FifoThread: Get signal data method
******************************************************************************}
procedure FifoThread.GetSignalData (llBufIdx : int64; llLen : int64);
var
  i            : int32;
  lIdx         : int32;
  lMin         : int32;
  lMax         : int32;
  dScaleXMulti : Double;
  nVal         : int16;
  byVal        : int8;

begin
  i:= 0;
  dScaleXMulti := 2 * Pi / (BUFSIZE / g_lBytesPerSample / 1024);

  lMin := -g_lMaxDACValue;
  lMax :=  g_lMaxDACValue - 1;

  if (m_bFromFile = true) then
  begin

    // ----- signal data from file -----
    for lIdx:=llBufIdx to llBufIdx + llLen - 1 do
    begin
      if (m_lFileBytesPerSample = 1) then
      begin
        // ----- samples in file 8 bit data -----

        // ----- check file stream end -----
        if (m_Stream.Position + SizeOf(byVal) > m_Stream.Size) then
        begin
          m_sCardInfoText := 'File data transfer complete.';
          byVal   := 0;
        end
        else
          m_Stream.Read (byVal, SizeOf(byVal));

        if (g_lBytesPerSample = 1) then
          g_pbyData[lIdx] := byVal
        else
        begin
          nVal := byVal;
          g_pnData[lIdx] := nVal;
        end;
      end
      else
        // ----- samples in file 12, 14 bit data -----

        // ----- check file stream end -----
        if (m_Stream.Position + SizeOf(nVal) > m_Stream.Size) then
        begin
          m_sCardInfoText := 'File data transfer complete.';
          nVal   := 0;
        end
        else
          m_Stream.Read (nVal, SizeOf(nVal));

        g_pnData[lIdx] := nVal;
      end;
    end
  else
  begin
    // ----- calculate signal data -----
    for lIdx:=llBufIdx to llBufIdx + llLen - 1 do
    begin
      if (g_lBytesPerSample = 1) then
      case m_lSignalType of
        0 : g_pbyData[lIdx] := trunc (lMax * Sin (dScaleXMulti * (llBufIdx + i)));
        1 : g_pbyData[lIdx] := lMax;
        2 : g_pbyData[lIdx] := lMin;
        3 : g_pbyData[lIdx] := 0;
      end
      else
      case m_lSignalType of
        0 : g_pnData[lIdx] := trunc (lMax * Sin (dScaleXMulti * (llBufIdx + i)));
        1 : g_pnData[lIdx] := lMax;
        2 : g_pnData[lIdx] := lMin;
        3 : g_pnData[lIdx] := 0;
      end;
      i := i + 1;
    end;
  end;

end;

{******************************************************************************
FifoThread: Execute method
******************************************************************************}
procedure FifoThread.Execute;
var
  llAvailUser : int64;
  llUserPos   : int64;
  bCardStart  : boolean;
  lDummy      : int32;
  llBufferFillPromille : int64;
begin

  if (m_bStop = false) then
  begin
    bCardStart           := false;
    m_llTransferredBytes := 0;
    g_dwError            := 0;

    // ----- show infos -----
    m_sCardInfoText := 'Fill complete buffer with data ...';
    Synchronize (DoPainting);

    // ----- calculate output data and wtite to buffer -----
    GetSignalData (0, trunc(BUFSIZE / g_lBytesPerSample));

    // ----- set BufSize available to driver -----
    g_dwError := spcm_dwSetParam_i64 (g_hDevice, SPC_DATA_AVAIL_CARD_LEN, BUFSIZE);

    // ----- now buffer is full of data and we start DMA transfer -----
    g_dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_DATA_STARTDMA or M2CMD_DATA_WAITDMA);

    // ----- show infos -----
    m_sCardInfoText := 'DMA transfer startet ...';
    Synchronize (DoPainting);

    // ----- now running Fifo loop -----
    while ((g_dwError = 0) and (m_bStop = false)) do
    begin
      spcm_dwGetParam_i64 (g_hDevice, SPC_DATA_AVAIL_USER_LEN, llAvailUser);
      spcm_dwGetParam_i64 (g_hDevice, SPC_FILLSIZEPROMILLE, llBufferFillPromille);

      // ----- we recalculate the amount of data that is free and set this part available for card again -----
      if (llAvailUser >= NOTIFY) then
      begin
        spcm_dwGetParam_i64 (g_hDevice, SPC_DATA_AVAIL_USER_POS, llUserPos);
        m_llTransferredBytes := m_llTransferredBytes + NOTIFY;
        GetSignalData (trunc(llUserPos / g_lBytesPerSample), trunc(NOTIFY / g_lBytesPerSample));
        g_dwError := spcm_dwSetParam_i64 (g_hDevice, SPC_DATA_AVAIL_CARD_LEN, NOTIFY);

        // ----- show infos -----
        Synchronize (DoPainting);
      end;

      // ----- we start if the hardware buffer is completely full -----
      if ((bCardStart = false) and (llBufferFillPromille >= 250)) then
      begin
        // ----- show infos -----
        m_sCardInfoText := 'Card starts replay.';
        Synchronize (DoPainting);

        spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_CARD_START or M2CMD_CARD_ENABLETRIGGER);
        bCardStart := true;
      end;

      // ----- wait for DMA -----
      g_dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_DATA_WAITDMA);
    end;

    // ----- check for error and display error message -----
    if (g_dwError <> 0) then
      spcm_dwGetErrorInfo_i32 (g_hDevice, lDummy, lDummy, g_sError);
  end;

  // ----- free stream object -----
  if (m_bFromFile = true) then
    m_Stream.Free;
end;

{******************************************************************************
Start Button Event
******************************************************************************}
procedure TformMain.ButtonStartClick(Sender: TObject);
  var
  sError   : array[0..ERRORTEXTLEN] of char;
  dwError  : uint32;
  lDummy   : int32;
begin

  // ----- set elements states -----
  ButtonStart.Enabled      := false;
  ButtonStop.Enabled       := true;
  EditSRate.Enabled        := false;
  CheckBoxFromFile.Enabled := false;

  // ----- do card setup -----
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD,       M2CMD_CARD_RESET);

  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CARDMODE,    SPC_REP_FIFO_SINGLE);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CHENABLE,    CHANNEL0);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_LOOPS,       0);

  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CLOCKMODE,   SPC_CM_INTPLL);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_SAMPLERATE,  strToInt(EditSRate.Text));
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CLOCKOUT,    0);

  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE);

  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_AMP0,       SlideAmpl.Position);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_OFFS0,      SlideOffset.Position);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_ENABLEOUT0, 1);

  // ----- check for error and display error message -----
  if (dwError <> 0) then begin
    spcm_dwGetErrorInfo_i32 (g_hDevice, lDummy, lDummy, sError);
    MessageDlg (sError, mtInformation, [mbOK], 0);
    exit;
  end;

  // ----- setup Fifo buffer -----
  if (g_lBytesPerSample = 1) then
  begin
    GetMem (g_pbyData, BUFSIZE);
    spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, NOTIFY, g_pbyData, 0, BUFSIZE);
  end
  else
  begin
    GetMem (g_pnData, BUFSIZE);
    spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_PCTOCARD, NOTIFY, g_pnData, 0, BUFSIZE);
  end;

  // ----- start working thread -----
  if (CheckBoxFromFile.Checked = true) then
    thread := FifoThread.Create (LabelTransfer, LabelInfo, EditFileName.Text)
  else
    thread := FifoThread.Create (LabelTransfer, LabelInfo, ComboBoxSignalType.ItemIndex);

  thread.OnTerminate := ThreadDone;

  g_bThreadStart := true;
end;

{******************************************************************************
Stop Button Event
******************************************************************************}
procedure TformMain.ButtonStopClick(Sender: TObject);
begin
  if (g_bThreadStart = true) then
    thread.m_bStop := true;
end;

{******************************************************************************
Thread Done Event
******************************************************************************}
procedure TformMain.ThreadDone (Sender: TObject);
begin
  g_bThreadStart := false;

  // ----- check for error and display error message -----
  if (g_dwError <> 0) then
    MessageDlg (g_sError, mtInformation, [mbOK], 0);

  spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP or M2CMD_DATA_STOPDMA);
  spcm_dwInvalidateBuf (g_hDevice, SPCM_BUF_DATA);

  // ----- free buffer memory -----
  if (g_lBytesPerSample = 1) then
    FreeMem (g_pbyData, BUFSIZE)
  else
    FreeMem (g_pnData, BUFSIZE);

  // ----- set elements states -----
  ButtonStart.Enabled      := true;
  ButtonStop.Enabled       := false;
  EditSRate.Enabled        := true;
  CheckBoxFromFile.Enabled := true;

  LabelInfo.Caption := 'Card stopped.';
end;

{******************************************************************************
Signal type changed by user
******************************************************************************}
procedure TformMain.ComboBoxSignalTypeChange(Sender: TObject);
begin
  if (g_bThreadStart = true) then
    thread.m_lSignalType := ComboBoxSignalType.ItemIndex;
end;

{******************************************************************************
Amplitude changed by user
******************************************************************************}
procedure TformMain.SlideAmplChange(Sender: TObject);
begin
  spcm_dwSetParam_i32 (g_hDevice, SPC_AMP0, SlideAmpl.Position);
  LabelAmpl.Caption := 'Amplitude (' + intToStr (SlideAmpl.Position) + ' mV)';
end;

{******************************************************************************
Offset changed by user
******************************************************************************}
procedure TformMain.SlideOffsetChange(Sender: TObject);
begin
  spcm_dwSetParam_i32 (g_hDevice, SPC_OFFS0, SlideOffset.Position);
  LabelOffset.Caption := 'Offset (' + intToStr (SlideOffset.Position) + ' mV)';
end;

{******************************************************************************
Set from file CheckBox
******************************************************************************}
procedure TformMain.CheckBoxFromFileClick(Sender: TObject);
begin
  EditFileName.Enabled       := CheckBoxFromFile.Checked;
  ComboBoxSignalType.Enabled := Not CheckBoxFromFile.Checked;
end;

end.

