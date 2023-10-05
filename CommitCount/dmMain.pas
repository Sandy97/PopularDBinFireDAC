unit dmMain;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.IB,
  FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf, FireDAC.DApt, FireDAC.Comp.Client,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.BatchMove, Data.DB,
  FireDAC.Comp.DataSet;

type
  TDataModule1 = class(TDataModule)
    EmployeeConnection: TFDConnection;
    EmployeeTable: TFDQuery;
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    FDMemTable1: TFDMemTable;
    procedure DataModuleCreate(Sender: TObject);

  private
    { Private declarations }

  public
    { Public declarations }
    Fread: integer;
    FWritten: integer;
    procedure longBatchMove(rep:integer = 5);
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.DataModuleCreate(Sender: TObject);
begin
  EmployeeTable.Open;
end;

procedure TDataModule1.longBatchMove(rep: integer);
var i: integer;
begin
  Fread:=0;
  FWritten:=0;
  FDMemTable1.Active:=False;
  for i :=0 to rep-1 do begin
    sleep(2000);
    FDBatchMove1.Execute;
    Fread := FRead + FDBatchMove1.ReadCount;
    FWritten := FRead + FDBatchMove1.WriteCount;
  end;
  FDMemTable1.Active:=True;
end;

end.
