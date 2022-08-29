{******************************************************************************
 * Delphi 4 scope example for all cards that support the SpcM interface (M2i) *
 ******************************************************************************}

unit spcm_scope_main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls,
  SpcRegs, SpcErr, spcm_win32, ExtCtrls;     // Spectrum specific Units


type
  TformMain = class(TForm)
    butQuit: TButton;
    butAcquire: TButton;
    picDisplay: TImage;
    procedure FormCreate(Sender: TObject);
    procedure butQuitClick(Sender: TObject);
    procedure butAcquireClick(Sender: TObject);
  private
    { Private-Deklarationen}
  public
    { Public-Deklarationen}
  end;

var
  formMain: TformMain;

  g_hDevice: int32;
  g_lBytesPerSample: int32;
  g_lFullScale: int32;


const MEMSIZE = 16384;


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

begin

    // ----- we go through the cards and open the first analog input card that is available -----
    g_hDevice := 0;
    for lIdx := 0 to 63 do
        if (g_hDevice = 0) then begin
           strName := 'spcm' + inttostr(lIdx);
           hDevice := spcm_hOpen(PAnsiChar(strName));

           if (hDevice <> 0) then begin
              spcm_dwGetParam_i32(hDevice, SPC_FNCTYPE, lBrdFunction);
              if (lBrdFunction = SPCM_TYPE_AI) then begin
                 spcm_dwGetParam_i32(hDevice, SPC_PCITYP, lBrdType);
                 spcm_dwGetParam_i32(hDevice, SPC_PCISERIALNR, lSerial);
                 spcm_dwGetParam_i64(hDevice, SPC_PCIMEMSIZE,  llMemory);
                 spcm_dwGetParam_i32(hDevice, SPC_MIINST_BYTESPERSAMPLE, g_lBytesPerSample);

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
              end else begin
                  spcm_vClose (hDevice);
              end;
           end;
        end;



    // ----- if we didn't find a matching card we can just quit here -----
    if (g_hDevice = 0) then begin
        MessageDlg ('No matching Spectrum card found for the example', mtInformation, [mbOK], 0);
    end;
end;


{******************************************************************************
butQuitClick: quit the program
******************************************************************************}

procedure TformMain.butQuitClick(Sender: TObject);
begin
     formMain.Close;
end;



{******************************************************************************
butAcquireClick: make a single acquisition
******************************************************************************}

procedure TformMain.butAcquireClick(Sender: TObject);
var
    strError: array[0..ERRORTEXTLEN] of char;
    dwError: uint32;
    pnData: ^TNData;
    pbyData: ^TCData;
    lChannels, lDummy: int32;
    llSamplerate: int64;

    lChOffset, i, j: int32;
    dWidth, dHeigth: double;
begin



    // ----- do a running and simple setup -----
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_CHENABLE, CHANNEL0);
    dwError := spcm_dwGetParam_i64 (g_hDevice, SPC_MIINST_MAXADCLOCK, llSamplerate);
    dwError := spcm_dwSetParam_i64 (g_hDevice, SPC_SAMPLERATE, llSamplerate);
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_MEMSIZE, MEMSIZE);
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_POSTTRIGGER,trunc (MEMSIZE / 2));
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_TRIG_ORMASK, SPC_TMASK_SOFTWARE);
    dwError := spcm_dwGetParam_i32 (g_hDevice, SPC_CHCOUNT, lChannels);



    // ----- check for error and display error message -----
    if (dwError <> 0) then begin
        spcm_dwGetErrorInfo_i32 (g_hDevice, lDummy, lDummy, strError);
        MessageDlg (strError, mtInformation, [mbOK], 0);
        exit;
    end;


    // ----- do the acquistion and wait for the end -----
    dwError := spcm_dwSetParam_i32 (g_hDevice, SPC_M2CMD, M2CMD_CARD_START or M2CMD_CARD_ENABLETRIGGER or M2CMD_CARD_WAITREADY);



    // ----- read the data -----
    if (g_lBytesPerSample = 1) then begin
        GetMem (pbyData, MEMSIZE * lChannels);
        spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pbyData, 0, MEMSIZE * lChannels);
    end else begin
        GetMem (pnData, MEMSIZE * lChannels * 2);
        spcm_dwDefTransfer_i64 (g_hDevice, SPCM_BUF_DATA, SPCM_DIR_CARDTOPC, 0, pnData, 0, MEMSIZE * 2 * lChannels);
    end;
    spcm_dwSetParam_i32(g_hDevice, SPC_M2CMD, M2CMD_DATA_STARTDMA or M2CMD_DATA_WAITDMA);



    // ----- paint the data -----
    with picDisplay.canvas do begin

        // erase background
        pen.color :=   clBlack;
        brush.color := clWhite;
        rectangle(0, 0, picDisplay.clientwidth, picDisplay.clientheight);

        // calc settings to show signal inside the pic
        dWidth := (picDisplay.clientwidth) / MEMSIZE;
        dHeigth := (picDisplay.clientheight) / (g_lFullScale * lChannels);

        // ----- paint signals -----
        // if using cards with 2 modules the channel order differs, please see hardware manual for details
        // e.g.: a 4 channel card with 2 modules has the order ch0, ch2, ch1, ch3 !
        for j := 0 to (lChannels - 1) do begin
            lChOffset := trunc (g_lFullScale / 2 + (g_lFullScale * j));

            // 8 bit signals (= 1 byte per sample)
            if (g_lBytesPerSample = 1) then begin
               moveto (0, trunc (dHeigth * (lChOffset - pbyData [j])));
               for i := 1 to (MEMSIZE - 1) do
                   lineto (trunc (dWidth * (i - 1)), trunc (dHeigth * (lChOffset - pbyData[lChannels * i + j])));

            // >= 12 bit signals (= 2 bytes per sample)
            end else begin
               moveto (0, trunc (dHeigth * (lChOffset - pnData [j])));
               for i := 1 to (MEMSIZE - 1) do
                   lineto (trunc (dWidth * (i - 1)), trunc (dHeigth * (lChOffset - pnData[lChannels * i + j])));
            end;
        end;
    end;
end;

end.
