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

  For consulting, training, and development services,
  visit http://www.JensenDataSystems.com


  For information about Delphi Developer Days with Bob Swart and Cary Jensen,
  visit http://www.DelphiDeveloperDays.com

*)
unit mainformu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.VCLUI.Wait, FireDAC.Stan.Param, FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Comp.UI,
  FireDAC.Phys.IB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.ComCtrls,
  FireDAC.Phys.IBBase, FireDAC.Phys.IBDef;

type
  TForm1 = class(TForm)
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Button1: TButton;
    DBGrid1: TDBGrid;
    FDConnection1: TFDConnection;
    FDPhysIBDriverLink1: TFDPhysIBDriverLink;
    FDGUIxWaitCursor1: TFDGUIxWaitCursor;
    FDQuery1: TFDQuery;
    DataSource1: TDataSource;
    FDTable1: TFDTable;
    cbArrayDML: TCheckBox;
    lblTotalTime: TLabel;
    FDQuery2: TFDQuery;
    Label4: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    FStartTime: LongWord;
  public
    { Public declarations }

  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses DateUtils;

procedure TForm1.Button1Click(Sender: TObject);
var
  CurrentDate: TDateTime;
  TotalDays: Integer;
  i: Integer;
begin
  if DateTimePicker1.Date >= DateTimePicker2.Date then
    raise Exception.Create('Starting date cannot following ending date');

  TotalDays := DateUtils.DaysBetween(DateTimePicker1.Date,
    DateTimePicker2.Date);
  // Creating the table in a transaction that is committed
  // before beginning the INSERT process ensures that the
  // table is available when the Array DML process is initiated.
  FDConnection1.StartTransaction;
  try
    FDConnection1.ExecSQL('CREATE TABLE ' + Edit1.Text + '( ' +
      '     DateValue date NOT NULL Primary Key, ' +
      '     DayName varchar(16) )');
  finally
    FDConnection1.Commit;
  end;

  FDQuery1.SQL.Text := 'INSERT INTO ' + Edit1.Text +
    ' (DateValue, DayName) VALUES(:Date, (:name) )';
  FDQuery2.SQL.Text := 'INSERT INTO ' + Edit1.Text +
    ' (DateValue, DayName) VALUES(:Date, (:name) )';

  CurrentDate := DateTimePicker1.Date;
  FStartTime := GetTickCount;
  if cbArrayDML.Checked then
  begin
    // Set the array size
    FDQuery1.Params.ArraySize := TotalDays;
    // Insert the parameters
    for i := 0 to TotalDays - 1 do
    begin
      FDQuery1.Params[0].AsDateTimes[i] := DateOf(CurrentDate);
      FDQuery1.Params[1].AsStrings[i] := FormatDateTime('dddd', CurrentDate);
      CurrentDate := IncDay(CurrentDate);
    end;
    // Execute the query
    FDQuery1.Execute(FDQuery1.Params.ArraySize);
  end
  else
  begin
    // Insert the parameters
    for i := 0 to TotalDays - 1 do
    begin
      FDQuery2.Params[0].AsDateTimes[0] := DateOf(CurrentDate);
      FDQuery2.Params[1].AsStrings[0] := FormatDateTime('dddd', CurrentDate);
      CurrentDate := IncDay(CurrentDate);
      // Execute the query
      FDQuery2.Execute();
    end;

  end;
  lblTotalTime.Caption := FloatToStr((GetTickCount-FStartTime)/1000.0);
  // Let's take a look at the data
  FDQuery1.Open('SELECT * FROM ' + Edit1.Text);
  DataSource1.DataSet := FDQuery1;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  DateTimePicker1.Date := DateOf(now);
  DateTimePicker2.Date := DateOf(incyear(now, 5));
end;

end.
