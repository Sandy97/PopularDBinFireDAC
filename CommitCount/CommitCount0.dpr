program CommitCount0;

uses
  Vcl.Forms,
  uMainF in 'uMainF.pas' {Form2},
  Vcl.Themes,
  Vcl.Styles,
  dmMain in 'dmMain.pas' {DataModule1: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Sapphire Kamri');
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.Run;
end.
