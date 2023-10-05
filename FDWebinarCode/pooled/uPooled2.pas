unit uPooled2;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, Data.DB, FireDAC.Comp.Client, FireDAC.Dapt,
  System.Diagnostics, FireDAC.Phys.MongoDB,
  FireDAC.Phys.MongoDBDef, System.Rtti, System.JSON.Types, System.JSON.Readers,
  System.JSON.BSON, System.JSON.Builders, FireDAC.Phys.MongoDBWrapper,
  FireDAC.Phys.IB, FireDAC.Phys.IBDef;

const
  DefaultConDefName = 'EMPLOYEE';

type
  TfmPooled = class(TForm)
    pnlMain: TPanel;
    Label1: TLabel;
    lblTotalExec: TLabel;
    Label2: TLabel;
    lblTotalTime: TLabel;
    btnRun: TButton;
    chPooled: TCheckBox;
    FDConnection1: TFDConnection;
    procedure btnRunClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    FCount: Integer;
    FStartTime: LongWord;
    ActualConDefName:string;
    procedure RunQuery;
    procedure Executed;
  public
    { Public declarations }
  end;

var
  fmPooled: TfmPooled;

implementation

{$R *.dfm}
uses
  System.Threading;

procedure TfmPooled.btnRunClick(Sender: TObject);
var
  i: Integer;
begin
  btnRun.Enabled := False;
  FDManager.Close;
  while FDManager.State <> dmsInactive do
    Sleep(0);
  FDManager.Open;
  ActualConDefName:=DefaultConDefName;
  if chPooled.Checked then
    FDManager.ConnectionDefs.ConnectionDefByName(ActualConDefName).Params.Pooled := True
  else
    FDManager.ConnectionDefs.ConnectionDefByName(ActualConDefName).Params.Pooled := False;

  FStartTime := GetTickCount;
  FCount := 0;
  lblTotalExec.Caption := '---';
  lblTotalTime.Caption := '---';
  for i := 1 to 10 do
    TTask.Run(
        procedure
        var
          Total: integer;
          ElapsedSeconds: Double;
        begin
          RunQuery;        //Total := PrimesBelow(200000);
        end);

end;

procedure TfmPooled.Executed;
begin
  Inc(FCount);
  if (FCount mod 10) = 0 then
    lblTotalExec.Caption := IntToStr(FCount);
  if FCount = 500 then begin
    lblTotalTime.Caption := FloatToStr((GetTickCount - FStartTime) / 1000.0);
    btnRun.Enabled := True;
  end;
end;

procedure TfmPooled.FormDestroy(Sender: TObject);
begin
  FDManager.Close;
end;

procedure TfmPooled.RunQuery;
var
  oConn:  TFDConnection;
  oQuery: TFDQuery;
  i: Integer;
begin
  oConn  := TFDConnection.Create(nil);
  oQuery := TFDQuery.Create(nil);
  try
    oQuery.Connection := oConn;
    oConn.ConnectionDefName := ActualConDefName;
    for i := 1 to 50 do begin
      oQuery.SQL.Text := 'select count(*) from DEPARTMENT';
      oQuery.Open;
      oConn.Close;
      TThread.Synchronize(nil,fmPooled.Executed);
    end;
  finally
    oConn.Free;
    oQuery.Free;
  end;
end;

initialization
  ReportMemoryLeaksOnShutdown := True;

end.

