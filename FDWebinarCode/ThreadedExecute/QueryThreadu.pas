unit QueryThreadu;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, FireDAC.UI.Intf,
  FireDAC.FMXUI.Async, FireDAC.Comp.UI, Data.DB, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client, FireDAC.Stan.Def, FireDAC.Stan.Pool;

type
  TQueryThread = class(TThread)
  private
    { Private declarations }
    FDConnection: TFDConnection;
    FDQuery: TFDQuery;
    FFDMemTable: TFDMemTable;
  protected
    procedure Execute; override;
  public
    constructor Create(SQLText: string; FDMemTable: TFDMemTable); overload;
    destructor Destroy; override;
  end;

implementation


uses DataModuleu;

{ TQueryThread }

constructor TQueryThread.Create(SQLText: string; FDMemTable: TFDMemTable);
begin
  inherited Create(True);
  FDConnection := TFDConnection.Create(nil);
  FDConnection.ConnectionDefName := 'IBConn';
  FDConnection.LoginPrompt := False;
  FDConnection.Open;
  FDQuery := TFDQuery.Create(nil);
  FDQuery.Connection := FDConnection;
  FDQuery.SQL.Text := SQLText;
  FDQuery.ResourceOptions.CmdExecMode := amBlocking;
  FFDMemTable := FDMemTable;
end;

destructor TQueryThread.Destroy;
begin
  FDQuery.Free;
  FDConnection.Free; //The connection will return to the connection pool
  inherited;
end;

procedure TQueryThread.Execute;
begin
  FDQuery.Open;
  Synchronize(procedure
              begin
                FFDMemTable.CloneCursor(FDQuery, True);
              end);
end;

end.
