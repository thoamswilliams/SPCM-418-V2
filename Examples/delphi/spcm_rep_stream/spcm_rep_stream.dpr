program spcm_rep_stream;

uses
  Forms,
  spcm_rep_stream_main in 'spcm_rep_stream_main.pas' {formMain},
  SpcRegs in '..\d_header\SpcRegs.pas',
  SpcErr in '..\d_header\SpcErr.pas',
  spcm_win32 in '..\d_header\spcm_win32.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
