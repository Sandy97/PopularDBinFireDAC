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
  System.SysUtils, System.Types, System.UITypes, System.Classes, System.Variants, 
  FMX.Types, FMX.Graphics, FMX.Controls, FMX.Forms, FMX.Dialogs, FMX.StdCtrls,
  System.Rtti, FMX.Layouts, Fmx.Bind.Navigator, FMX.Grid, Data.Bind.EngExt,
  Fmx.Bind.DBEngExt, Fmx.Bind.Grid, System.Bindings.Outputs, Fmx.Bind.Editors,
  Data.Bind.Components, Data.Bind.Grid, Data.DB, Data.Bind.DBScope, FireDAC.Stan.Intf,
  FMX.Grid.Style, Data.Bind.Controls, FMX.Controls.Presentation, FMX.ScrollBox,
  FMX.Ani, FireDAC.UI.Intf, FireDAC.FMXUI.Async, FireDAC.Comp.UI,
  DHPThreading;

type
  TForm1 = class(TForm)
    Grid1: TGrid;
    BindNavigator1: TBindNavigator;
    btExecBlocking: TButton;
    btExecCancel: TButton;
    btExecAsync: TButton;
    btExecThread: TButton;
    Label1: TLabel;
    BindSourceDB1: TBindSourceDB;
    BindingsList1: TBindingsList;
    LinkGridToDataSourceBindSourceDB1: TLinkGridToDataSource;
    ThreadCountLbl: TLabel;
    btNonBlocking: TButton;
    Label2: TLabel;
    Label3: TLabel;
    StyleBook1: TStyleBook;
    ScrollBar1: TScrollBar;
    FloatAnimation1: TFloatAnimation;
    btAsyncOpenDB: TButton;
    procedure btExecBlockingClick(Sender: TObject);
    procedure btExecCancelClick(Sender: TObject);
    procedure btExecAsyncClick(Sender: TObject);
    procedure QueryAfterOpen(DataSet: TDataSet);
    procedure ThreadDone(Sender: TObject);
    procedure btExecThreadClick(Sender: TObject);
    procedure btNonBlockingClick(Sender: TObject);
    procedure btAsyncOpenDBClick(Sender: TObject);
  private
    { Private declarations }
    fStartTime: LongWord;
    procedure longtimeopen(slp:integer = 1000; mode:TFDStanAsyncMode = amBlocking ; hook: TDataSetNotifyEvent = nil );
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.fmx}

uses DataModuleu, QueryThreadu, Winapi.Windows;

procedure TForm1.btExecBlockingClick(Sender: TObject);
begin
  fStartTime := GetTickCount;
  BindSourceDB1.DataSet.Close;
  BindSourceDB1.DataSet.DisableControls;
  try
    BindSourceDB1.DataSet := DataModule2.FDQuery1;
    DataModule2.FDQuery1.AfterOpen := nil;
    DataModule2.FDQuery1.ResourceOptions.CmdExecMode := amBlocking;
    DataModule2.FDQuery1.Open;
//    longtimeopen(1000, amBlocking, nil);
  finally
    BindSourceDB1.DataSet := DataModule2.FDQuery1;
    BindSourceDB1.DataSet.EnableControls;
    Label2.Text := FloatToStr((GetTickCount-FStartTime)/1000.0);
  end;
end;

procedure TForm1.btExecCancelClick(Sender: TObject);
var
  bsql: string;
begin
  fStartTime := GetTickCount;
  BindSourceDB1.DataSet.Close;
  BindSourceDB1.DataSet.DisableControls;
  bsql:= DataModule2.FDQuery1.SQL.Text;
  try
    BindSourceDB1.DataSet := DataModule2.FDQuery1;
    DataModule2.FDQuery1.AfterOpen := nil;
    DataModule2.FDQuery1.ResourceOptions.CmdExecMode := amCancelDialog;
    DataModule2.FDQuery1.Open('select a.ORDERNO,count(*) from ITEMS a , ITEMS b group by a.Orderno');
  finally
    BindSourceDB1.DataSet := DataModule2.FDQuery1;
    BindSourceDB1.DataSet.EnableControls;
    Label2.Text := FloatToStr((GetTickCount-FStartTime)/1000.0);
    //DataModule2.FDQuery1.SQL.Text:= bsql;
  end;

end;

procedure TForm1.btAsyncOpenDBClick(Sender: TObject);
begin
  (Sender as TButton).Enabled := false;

  DHPThreading.Async(DataModule2.chkConnectionOpen)
  .Await(
    procedure
    begin
      ShowMessage(Format('Connected in thread %d', [TThread.Current.ThreadID]));
      (Sender as TButton).Enabled := true;
    end
  );

end;

procedure TForm1.btExecAsyncClick(Sender: TObject);
begin
  fStartTime := GetTickCount;
  BindSourceDB1.DataSet.Close;
  BindSourceDB1.DataSet.DisableControls;
  BindSourceDB1.DataSet := DataModule2.FDQuery1;
  DataModule2.FDQuery1.AfterOpen := QueryAfterOpen;
  DataModule2.FDQuery1.ResourceOptions.CmdExecMode := amAsync;
  DataModule2.FDQuery1.Open;
//  longtimeopen(1000, amAsync, QueryAfterOpen);

  //  Label2.Text := FloatToStr((GetTickCount-FStartTime)/1000.0);
end;

procedure TForm1.btExecThreadClick(Sender: TObject);
var
  QueryThread: TQueryThread;
begin
  fStartTime := GetTickCount;
  BindSourceDB1.DataSet := nil;
  QueryThread := TQueryThread.Create(DataModule2.FDQuery1.SQL.Text,
                                     DataModule2.FDMemTable1);
  QueryThread.FreeOnTerminate := True;
  QueryThread.OnTerminate := ThreadDone;
  QueryThread.Start;
end;

procedure TForm1.btNonBlockingClick(Sender: TObject);
begin
  fStartTime := GetTickCount;
  BindSourceDB1.DataSet.Close;
  BindSourceDB1.DataSet.DisableControls;
  BindSourceDB1.DataSet := DataModule2.FDQuery1;
  DataModule2.FDQuery1.AfterOpen := QueryAfterOpen;
  DataModule2.FDQuery1.ResourceOptions.CmdExecMode := amNonBlocking;
  DataModule2.FDQuery1.Open;
//  longtimeopen(1000, amNonBlocking, QueryAfterOpen);
  Label2.Text := FloatToStr((GetTickCount-FStartTime)/1000.0);
end;

procedure TForm1.longtimeopen(slp: integer; mode: TFDStanAsyncMode;
  hook: TDataSetNotifyEvent);
var
  i: integer;
begin
  DataModule2.FDQuery1.AfterOpen := hook;
  DataModule2.FDQuery1.ResourceOptions.CmdExecMode := mode;
  sleep(slp);
  for i:=0 to 3 do begin
    DataModule2.FDQuery1.Close;
    DataModule2.FDQuery1.Open;
  end;
end;

procedure TForm1.QueryAfterOpen(DataSet: TDataSet);
begin
  BindSourceDB1.DataSet := DataModule2.FDQuery1;
  BindSourceDB1.DataSet.EnableControls;
end;

procedure TForm1.ThreadDone(Sender: TObject);
begin
  BindSourceDB1.DataSet := DataModule2.FDMemTable1;
  ThreadCountLbl.Text := IntToStr(StrToInt(ThreadCountLbl.Text) + 1);
  Label2.Text := FloatToStr((GetTickCount-FStartTime)/1000.0);
end;

end.
