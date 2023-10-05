program ThreadedExecute;

uses
  FMX.Forms,
  mainformu in 'mainformu.pas' {Form1},
  datamoduleu in 'datamoduleu.pas' {DataModule2: TDataModule},
  QueryThreadu in 'QueryThreadu.pas',
  DHPThreading in 'DHPThreading.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TDataModule2, DataModule2);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
