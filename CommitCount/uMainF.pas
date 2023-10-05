unit uMainF;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error,
  FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.Phys.IB, FireDAC.Phys.IBDef, FireDAC.VCLUI.Wait, FireDAC.Stan.Param,
  FireDAC.DatS, FireDAC.DApt.Intf, FireDAC.DApt, Vcl.Bind.Grid, System.Rtti,
  System.Bindings.Outputs, Vcl.Bind.Editors, Data.Bind.EngExt, Vcl.Bind.DBEngExt,
  Data.Bind.Components, Data.Bind.Grid, Vcl.Grids, Data.Bind.DBScope, Vcl.StdCtrls,
  FireDAC.Comp.BatchMove.DataSet, FireDAC.Comp.Client, FireDAC.Comp.BatchMove, Data.DB,
  FireDAC.Comp.DataSet, Vcl.DBGrids, System.Threading;

type
  TForm2 = class(TForm)
    btBatchMove: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    Label3: TLabel;
    Label4: TLabel;
    btSimple: TButton;
    procedure btBatchMoveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btSimpleClick(Sender: TObject);
  private
    { Private declarations }
    FTask: ITask;
    procedure BatchMoveCompleted;
    procedure BatchTask;
    procedure BatchTaskError(exc: Exception);
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

uses dmMain;


procedure TForm2.FormCreate(Sender: TObject);
begin
  FTask := nil;
end;

procedure TForm2.btSimpleClick(Sender: TObject);
begin
  DataModule1.longBatchMove(4);
  BatchMoveCompleted;
end;

procedure TForm2.BatchMoveCompleted;
begin
  FTask := nil;
  btBatchMove.Enabled := True;
  Label3.Caption := format('Read: %d',[DataModule1.Fread]);
  Label4.Caption := format('Written: %d',[DataModule1.Fwritten]);
end;

{$region 'Task mode'}
procedure TForm2.BatchTask;
var
  exc: TObject;
begin
  try
    DataModule1.longBatchMove(4);
    TThread.ForceQueue(nil, BatchMoveCompleted);
  except
    on E: Exception do
    begin
      exc := AcquireExceptionObject;
      TThread.ForceQueue(nil,
        procedure
        begin
          BatchTaskError(Exception(exc));
        end);
    end;
  end;
end;

procedure TForm2.BatchTaskError(exc: Exception);
begin
  showmessage(Format('Task raised exception %s %s', [exc.ClassName, exc.Message]));
  ReleaseExceptionObject;
end;

procedure TForm2.btBatchMoveClick(Sender: TObject);
begin
  FTask := TTask.Run(BatchTask);
end;

{$endregion}

end.
