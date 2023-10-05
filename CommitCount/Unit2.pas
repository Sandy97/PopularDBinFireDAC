unit Unit2;

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
  FireDAC.Comp.DataSet, Vcl.DBGrids;

type
  TForm2 = class(TForm)
    FDBatchMove1: TFDBatchMove;
    FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader;
    FDMemTable1: TFDMemTable;
    FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter;
    Button1: TButton;
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    DBGrid2: TDBGrid;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    EmployeeConnection: TFDConnection;
    EmployeeTable: TFDQuery;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.Button1Click(Sender: TObject);
begin
   FDMemTable1.Active:=False;
   FDBatchMove1.Execute;
   FDMemTable1.Active:=True;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
  EmployeeTable.Open;
end;

end.
