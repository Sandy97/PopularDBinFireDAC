object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Array DML Demonstration'
  ClientHeight = 347
  ClientWidth = 635
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  DesignSize = (
    635
    347)
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 27
    Width = 56
    Height = 13
    Caption = 'Table Name'
  end
  object Label2: TLabel
    Left = 16
    Top = 57
    Width = 50
    Height = 13
    Caption = 'Start Date'
  end
  object Label3: TLabel
    Left = 16
    Top = 84
    Width = 44
    Height = 13
    Caption = 'End Date'
  end
  object lblTotalTime: TLabel
    Left = 256
    Top = 84
    Width = 28
    Height = 24
    Caption = '----'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = 24
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label4: TLabel
    Left = 256
    Top = 65
    Width = 99
    Height = 13
    Caption = #1042#1088#1077#1084#1103' '#1088#1072#1073#1086#1090#1099' ('#1089#1077#1082')'
  end
  object Edit1: TEdit
    Left = 88
    Top = 24
    Width = 121
    Height = 21
    TabOrder = 0
    Text = 'DateTable01'
  end
  object DateTimePicker1: TDateTimePicker
    Left = 88
    Top = 51
    Width = 121
    Height = 21
    Date = 41360.000000000000000000
    Time = 0.674699143521138500
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 88
    Top = 78
    Width = 121
    Height = 21
    Date = 45203.000000000000000000
    Time = 0.674836574071378000
    TabOrder = 2
  end
  object Button1: TButton
    Left = 256
    Top = 22
    Width = 137
    Height = 25
    Caption = #1057#1086#1079#1076#1072#1090#1100' '#1080' '#1079#1072#1087#1086#1083#1085#1080#1090#1100
    TabOrder = 3
    OnClick = Button1Click
  end
  object DBGrid1: TDBGrid
    Left = 16
    Top = 148
    Width = 609
    Height = 191
    Anchors = [akLeft, akTop, akRight, akBottom]
    DataSource = DataSource1
    TabOrder = 4
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object cbArrayDML: TCheckBox
    Left = 88
    Top = 112
    Width = 97
    Height = 17
    Caption = 'ArrayDML'
    TabOrder = 5
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    LoginPrompt = False
    Left = 436
    Top = 208
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 540
    Top = 208
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 540
    Top = 256
  end
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    Left = 436
    Top = 272
  end
  object DataSource1: TDataSource
    Left = 320
    Top = 192
  end
  object FDTable1: TFDTable
    Connection = FDConnection1
    Left = 304
    Top = 128
  end
  object FDQuery2: TFDQuery
    Connection = FDConnection1
    Left = 376
    Top = 276
  end
end
