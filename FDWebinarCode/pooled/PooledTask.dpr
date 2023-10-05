program PooledTask;

uses
  Vcl.Forms,
  uPooled2 in 'uPooled2.pas' {fmPooled},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TfmPooled, fmPooled);
  Application.Run;
end.
