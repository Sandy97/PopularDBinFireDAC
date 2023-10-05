object Form2: TForm2
  Left = 0
  Top = 0
  Caption = #1043#1083#1072#1074#1085#1086#1077' '#1086#1082#1085#1086
  ClientHeight = 438
  ClientWidth = 584
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 13
  object Label1: TLabel
    Left = 12
    Top = 213
    Width = 32
    Height = 13
    Caption = 'Moved'
  end
  object Label2: TLabel
    Left = 12
    Top = 71
    Width = 33
    Height = 13
    Caption = 'Source'
  end
  object Label3: TLabel
    Left = 464
    Top = 71
    Width = 112
    Height = 13
    AutoSize = False
    Caption = ' '
  end
  object Label4: TLabel
    Left = 464
    Top = 213
    Width = 109
    Height = 13
    AutoSize = False
    Caption = ' '
  end
  object btBatchMove: TButton
    Left = 224
    Top = 28
    Width = 75
    Height = 25
    Caption = 'Batch move'
    TabOrder = 0
    OnClick = btBatchMoveClick
  end
  object DBGrid1: TDBGrid
    Left = 8
    Top = 232
    Width = 565
    Height = 198
    DataSource = DataSource1
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object DBGrid2: TDBGrid
    Left = 8
    Top = 87
    Width = 565
    Height = 120
    DataSource = DataSource2
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object btSimple: TButton
    Left = 456
    Top = 28
    Width = 75
    Height = 25
    Caption = 'btSimple'
    TabOrder = 3
    OnClick = btSimpleClick
  end
  object DataSource1: TDataSource
    DataSet = DataModule1.FDMemTable1
    Left = 260
    Top = 264
  end
  object DataSource2: TDataSource
    DataSet = DataModule1.EmployeeTable
    Left = 424
    Top = 140
  end
end
