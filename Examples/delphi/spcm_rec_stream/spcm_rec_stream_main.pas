{******************************************************************************
 * Delphi 4 analog streaming example for all cards that support the SpcM interface (M2i) *
 ******************************************************************************}

unit spcm_rec_stream_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  SpcRegs, SpcErr, spcm_win32, ExtCtrls;     // Spectrum specific Units

{******************************************************************************
FifoThread
******************************************************************************}
type
  FifoThread = class (TThread)

constructor Create (picDisplay : TImage; bStreamToFile : boolean; sFileName : String);

public
  m_bStop : boolean;

private
  m_PicDisplay    : TImage;
  m_lDataMin      : Array of int32;
  m_lDataMax      : Array of int32;
  m_lDataIdx      : int32;
  m_llTotalBytes  : int64;
  m_bStreamToFile : boolean;
  m_sFileName     : String;

protected
  procedure Execute; override;
  procedure DoPainting;
end;

type
    TformMain = class(TForm)
    butQuit      : TButton;
    picDisplay   : TImage;
    ButtonStart  : TButton;
    ButtonStop   : TButton;
    EditSRate    : TEdit;
    Label1       : TLabel;
    EditAmpl     : TEdit;
    Label2       : TLabel;
    LabelBufSize : TLabel;
    LabelNotify  : TLabel;
    CheckBoxToFile: TCheckBox;
    EditFileName: TEdit;
    procedure FormCreate(Sender: TObject);
    procedure butQuitClick(Sender: TObject);
    procedure ButtonStartClick(Sender: TObject);
    procedure ButtonStopClick(Sender: TObject);
    procedure ThreadDone (Sender: TObject);
    procedure CheckBoxToFileClick(Sender: TObject);

private
  { Private-Deklarationen}
public
  { Public-Deklarationen}
end;

var
  formMain          : TformMain;
  thread            : FifoThread;

  g_hDevice         : int32;
  g_lBytesPerSample : int32;
  g_lFullScale      : int32;

  g_pnData          : ^TNData;
  g_pbyData         : ^TCData;

const BUFSIZE = 1024 * 1024 * 8;
const NOTIFY  = 4096;

{******************************************************************************
FormCreate: look for a matching Spectrum card
******************************************************************************}
implementation

{$R *.DFM}

procedure TformMain.FormCreate(Sender: TObject);
var hDevice: int32;
    lIdx, lBrdType, lSerial, lBrdFunction, lMinSamplerate: int32;
    llMemory: int64;
    strName: AnsiString;
    strCard: String;
    lBufSize : int32;

begin
  lBufSize := trunc (BUFSIZE / 1024 / 1024);
  LabelBufSize.caption := 'Used Buffer size : ' + intToStr(lBufSize) + ' MByte';
  LabelNotify.caption  := 'Used Notify size : ' + intToStr(NOTIFY) + ' Bytes';

  picDisplay.canvas.pen.color   := clBlack;
  picDisplay.canvas.brush.color := clBlack;
  picDisplay.canvas.rectangle(0, 0, picDisplay.clientwidth, picDisplay.clientheight);

  CheckBoxToFile.Checked := false;
  EditFileName.Enabled   := false;

  // ----- we go through the cards and open the first analog input card that's available -----
  g_hDevice := 0;
  for lIdx := 0 to 63 do
    if (g_hDevice = 0) then
    begin
      strName := 'spcm' + inttostr(lIdx);
      hDevice := spcm_hOpen(PAnsiChar(strName));

      if (hDevice <> 0) then
      begin
        spcm_dwGetParam_i32(hDevice, SPC_FNCTYPE, lBrdFunction);
          if (lBrdFunction = SPCM_TYPE_AI) then
          begin
            spcm_dwGetParam_i32(hDevice, SPC_PCITYP, lBrdType);
            spcm_dwGetParam_i32(hDevice, SPC_PCISERIALNR, lSerial);
            spcm_dwGetParam_i64(hDevice, SPC_PCIMEMSIZE,  llMemory);
            spcm_dwGetParam_i32(hDevice, SPC_MIINST_BYTESPERSAMPLE, g_lBytesPerSample);

            // set samplerate
            spcm_dwGetParam_i32 (hDevice, SPC_MIINST_MINADCLOCK, lMinSamplerate);
            if (lMinSamplerate > 100000) then
            begin
               EditSRate.Text := IntToStr (lMinSamplerate);
            end
            else
            begin
               EditSRate.Text := IntToStr (100000);
            end;

            // get the resolution and recalc it to full scale for graph scaling
            spcm_dwGetParam_i32(hDevice, SPC_MIINST_MAXADCVALUE, g_lFullScale);
            g_lFullScale := g_lFullScale * 2;

            // show details of the selected card
            case (lBrdType and TYP_SERIESMASK) of
              TYP_M2ISERIES:    strCard := 'M2i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + #10#13;
              TYP_M2IEXPSERIES: strCard := 'M2i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-Exp' + #10#13;
              TYP_M3ISERIES:    strCard := 'M3i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + #10#13;
              TYP_M3IEXPSERIES: strCard := 'M3i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-Exp' + #10#13;
              TYP_M4IEXPSERIES: strCard := 'M4i.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x8' + #10#13;
              TYP_M4XEXPSERIES: strCard := 'M4x.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x4' + #10#13;
              TYP_M2PEXPSERIES: strCard := 'M2p.' + inttohex(lBrdType and TYP_VERSIONMASK, 4) + '-x4' + #10#13;
            end;

            strCard := strCard + 's/n: ' + inttostr(lSerial) + #10#13;
            strCard := strCard + 'Mem: ' + inttostr(trunc(llMemory / 1024 / 1024)) + ' MBytes' + #10#13;
            MessageDlg ('Scope example using the following card:' + #10#10#13 + strCard, mtInformation, [mbOK], 0);
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
butQuitClick: quit the program
******************************************************************************}
procedure TformMain.butQuitClick(Sender: TObject);
begin
  formMain.Close;
end;

{******************************************************************************
FifoThread: Constructor
******************************************************************************}
constructor FifoThread.Create (picDisplay : TImage; bStreamToFile : boolean; sFileName : String);
var i : Integer;

begin
  m_PicDisplay    := picDisplay;
  m_sFileName     := sFileName;
  m_bStreamToFile := bStreamToFile;
  m_bStop         := false;
  m_lDataIdx      := 0;

  // ----- init arrays to paint data -----
  SetLength (m_lDataMin, m_PicDisplay.clientwidth);
  SetLength (m_lDataMax, m_PicDisplay.clientwidth);

  for i:=0 to m_PicDisplay.clientwidth - 1 do
  begin
    m_lDataMin[i] :=  0;
    m_lDataMax[i] :=  0;
  end;

  inherited Create(False);
end;

{******************************************************************************
FifoThread: Painting method
******************************************************************************}
procedure FifoThread.DoPainting;
var i       : int32;
    lIdx    : int32;
    lOffset : int32;
    dMulti  : Double;

begin
  with m_PicDisplay.canvas do begin
    pen.color   := clBlack;
    brush.color := clBlack;

    rectangle(0, 0, m_PicDisplay.clientwidth, m_PicDisplay.clientheight);

    pen.color  := clYellow;
    font.color := clWhite;

    dMulti  := m_PicDisplay.clientheight / g_lFullScale;
    lOffset := trunc (g_lFullScale / 2);

    if (m_lDataIdx >= m_PicDisplay.clientwidth) then
      lIdx := 0
    else
      lIdx := m_lDataIdx + 1;

    i := 0;

    repeat
      moveTo (i, trunc (dMulti * (lOffset - m_lDataMin[lIdx])));
      lineTo (i, trunc (dMulti * (lOffset - m_lDataMax[lIdx])));

      i    := i + 1;
      lIdx := lIdx + 1;
      lIdx := lIdx mod m_PicDisplay.clientwidth;

    until lIdx = m_lDataIdx;

    textOut (10, 10, intToStr(trunc(m_llTotalBytes / 1024 / 1024)) + ' MBytes transferred');
  end;
end;

{******************************************************************************
FifoThread: Execute method
******************************************************************************}
procedure FifoThread.Execute;
var dwError         : uint32;
    lDummy          : int32;
    llAvailBytes    : int64;
    lAvailBytePos   : int32;
    llReceivedBytes : int64;
    lDataPos        : int32;
    llAvailData     : int64;
    lMinVal         : int32;
    lMaxVal         : int32;
    i               : int32;
    Stream          : TStream;
begin

  if (m_bStreamToFile = true) then
  begin
    // ----- create stream object -----
    Stream := TFileStream.Create(m_sFileName, fmCreate);

    // ----- write bytes per sample as header -----
    Stream.Write (g_lBytesPerSample, SizeOf(g_lBytesPerSample))
  end;

  // ----- start card and DMA -----
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_CARD_START or M2CMD_CARD_ENABLETRIGGER or M2CMD_DATA_STARTDMA);

  // ----- wait for DMA -----
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_DATA_WAITDMA);

  m_llTotalBytes  := 0;
  llReceivedBytes := 0;
  lMinVal         := 32000;
  lMaxVal         := -32000;

  // ----- now running Fifo loop -----
  while ((dwError = 0) and (m_bStop = false)) do
  begin
    // ----- get available bytes -----
    dwError := spcm_dwGetParam_i64 (g_hDevice, SPC_DATA_AVAIL_USER_LEN, llAvailBytes);

    m_llTotalBytes := m_llTotalBytes + llAvailBytes;

    // ----- get current byte position in Fifo buffer -----
    dwError := spcm_dwGetParam_i32 (g_hDevice, SPC_DATA_AVAIL_USER_POS, lAvailBytePos);

    // ----- check buffer range -----
    if ((lAvailBytePos + llAvailBytes) >= BUFSIZE) then
      llAvailBytes := BUFSIZE - lAvailBytePos;

    lDataPos := trunc (lAvailBytePos / g_lBytesPerSample);
    llAvailData := trunc (llAvailBytes / g_lBytesPerSample);

    // ----- stream to file or display stream data -----
    if (m_bStreamToFile = true) then
    begin
      for i:=lDataPos to (lDataPos + llAvailData) - 1 do
      begin
        if (g_lBytesPerSample = 1) then
          Stream.Write (g_pbyData[i], SizeOf(g_pbyData[i]))
        else
          Stream.Write (g_pnData[i], SizeOf(g_pnData[i]));
      end;
    end
    else
    begin
      // ----- get min and max values of data block -----
      for i:=lDataPos to (lDataPos + llAvailData) - 1 do
      begin
        if (g_lBytesPerSample = 1) then
        begin
          if (g_pbyData[i] > lMaxVal) then
            lMaxVal := g_pbyData[i];

          if (g_pbyData[i] < lMinVal) then
            lMinVal := g_pbyData[i];
        end
        else
        begin
          if (g_pnData[i] > lMaxVal) then
            lMaxVal := g_pnData[i];

          if (g_pnData[i] < lMinVal) then
            lMinVal := g_pnData[i];
        end;
      end;

      llReceivedBytes := llReceivedBytes + llAvailBytes;

      if (llReceivedBytes >= NOTIFY) then
      begin
        // ----- check data index -----
        if (m_lDataIdx >= m_PicDisplay.clientwidth) then
          m_lDataIdx := 0;

        // ----- store min and max values of data block -----
        m_lDataMin[m_lDataIdx] := lMinVal;
        m_lDataMax[m_lDataIdx] := lMaxVal;

        // ----- paint data -----
        Synchronize (DoPainting);

        m_lDataIdx := m_lDataIdx + 1;

        llReceivedBytes := 0;
        lMinVal         := 32000;
        lMaxVal         := -32000;
      end;
    end;

    // ----- set buffer section available for the card -----
    dwError := spcm_dwSetParam_i64 (g_hDevice, SPC_DATA_AVAIL_CARD_LEN, llAvailBytes);

    // ----- wait for DMA -----
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_DATA_WAITDMA);
    end;

  if (m_bStreamToFile = true) then
    Stream.Free;
end;

{******************************************************************************
Start Button Event
******************************************************************************}
procedure TformMain.ButtonStartClick(Sender: TObject);
var sError  : array[0..ERRORTEXTLEN] of char;
    dwError : uint32;
    lDummy  : int32;
begin
  // ----- do card setup -----
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD,       M2CMD_CARD_RESET);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CARDMODE,    SPC_REC_FIFO_SINGLE);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CHENABLE,    CHANNEL0);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_PRETRIGGER,  1024);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_LOOPS,       0);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CLOCKMODE,   SPC_CM_INTPLL);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_SAMPLERATE,  strToInt(EditSRate.text));
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CLOCKOUT,    0);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE);
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_AMP0,        strToInt(EditAmpl.text));
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_OFFS0,       0);

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
    spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, NOTIFY, g_pbyData, 0, BUFSIZE);
  end
  else
  begin
    GetMem (g_pnData, BUFSIZE);
    spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, NOTIFY, g_pnData, 0, BUFSIZE);
  end;

  // ----- set elements states -----
  ButtonStart.Enabled    := false;
  ButtonStop.Enabled     := true;
  EditSRate.Enabled      := false;
  EditAmpl.Enabled       := false;
  CheckBoxToFile.Enabled := false;

  // ----- start working thread -----
  thread := FifoThread.Create (picDisplay, CheckBoxToFile.Checked, EditFileName.Text);
  thread.OnTerminate := ThreadDone;
end;

{******************************************************************************
Stop Button Event
******************************************************************************}
procedure TformMain.ButtonStopClick(Sender: TObject);
begin
  // ----- end working thread -----
  thread.m_bStop := true;
end;

{******************************************************************************
Thread Done Event
******************************************************************************}
procedure TformMain.ThreadDone (Sender: TObject);
var sError  : array[0..ERRORTEXTLEN] of char;
    dwError : uint32;
    lDummy  : int32;
begin
  dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_CARD_STOP or M2CMD_DATA_STOPDMA);
  dwError := spcm_dwInvalidateBuf (g_hDevice, SPCM_BUF_DATA);

  // ----- check for error and display error message -----
  if (dwError <> 0) then
  begin
    spcm_dwGetErrorInfo_i32 (g_hDevice, lDummy, lDummy, sError);
    MessageDlg (sError, mtInformation, [mbOK], 0);
    exit;
  end;

  // ----- free buffer memory -----
  if (g_lBytesPerSample = 1) then
    FreeMem (g_pbyData, BUFSIZE)
  else
    FreeMem (g_pnData, BUFSIZE);

  // ----- set elements states -----
  ButtonStart.Enabled    := true;
  ButtonStop.Enabled     := false;
  EditSRate.Enabled      := true;
  EditAmpl.Enabled       := true;
  CheckBoxToFile.Enabled := true;
end;

procedure TformMain.CheckBoxToFileClick(Sender: TObject);
begin
  picDisplay.Visible   := NOT CheckBoxToFile.Checked;
  EditFileName.Enabled := CheckBoxToFile.Checked;
end;

end.

