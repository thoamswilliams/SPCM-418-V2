program spcm_scope;

uses
  Forms,
  spcm_scope_main in 'spcm_scope_main.pas' {formMain},
  SpcRegs in '..\d_header\SpcRegs.pas',
  SpcErr in '..\d_header\SpcErr.pas',
  spcm_win32 in '..\d_header\spcm_win32.pas';

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TformMain, formMain);
  Application.Run;
end.
