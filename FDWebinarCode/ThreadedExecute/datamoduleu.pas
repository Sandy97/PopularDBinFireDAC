(*
  Copyright (c) 2013 Cary Jensen

  This sample was designed to accompany the Embarcadero Webinar
  Universal Enterprise Data Connectivity using FireDAC,
  presented on October 30th, 2013 by Cary Jensen

  No guarantees or warranties are expressed or implied concerning
  the applicability of techniques or code included in this example.
  If you wish to use techniques or code included in this example,
  it is your responsibility to test and certify any code, 
  techniques, or design adopted as a result of this project.

*)
unit datamoduleu;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.FMXUI.Async, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Phys,
  FireDAC.FMXUI.Wait, FireDAC.Phys.IBBase, FireDAC.Phys.IB, FireDAC.Phys.IBDef;

type
  TDataModule2 = class(TDataModule)
    FDQuery1: TFDQuery;
    FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog;
    FDConnection1: TFDConnection;
    FDManager1: TFDManager;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDMemTable1: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure chkConnectionOpen;
  end;

var
  DataModule2: TDataModule2;

implementation

{%CLASSGROUP 'FMX.Controls.TControl'}

{$R *.dfm}

procedure TDataModule2.chkConnectionOpen;
begin
  FDConnection1.Open;
end;

procedure TDataModule2.DataModuleCreate(Sender: TObject);
var
  ConDef: TStringList;
  DataDir: string;
begin
  DataDir := 'C:\Data';
  ConDef := TStringList.Create;
  try
    ConDef.Add('Server=Localhost');
    ConDef.Add('Database=' + DataDir + '\dbdemos.gdb');
    ConDef.Add('User_Name=sysdba');
    ConDef.Add('Password=masterkey');
    ConDef.Add('Pooled=True');
    FDManager.AddConnectionDef('IBConn', 'IB', ConDef);
    FDManager.Open;
  finally
    ConDef.Free;
  end;
  FDConnection1.ConnectionName := 'IBConn';
  //  FDConnection1.Open;
end;


procedure TDataModule2.DataModuleDestroy(Sender: TObject);
begin
  FDManager.Close;
end;

end.
