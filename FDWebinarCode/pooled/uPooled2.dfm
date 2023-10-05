object fmPooled: TfmPooled
  Left = 0
  Top = 0
  Caption = 'FireDAC Pooled Connections'
  ClientHeight = 231
  ClientWidth = 421
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OnDestroy = FormDestroy
  TextHeight = 13
  object pnlMain: TPanel
    Left = 0
    Top = 0
    Width = 421
    Height = 231
    Align = alClient
    BevelOuter = bvNone
    TabOrder = 0
    ExplicitWidth = 419
    ExplicitHeight = 228
    object Label1: TLabel
      Left = 147
      Top = 83
      Width = 175
      Height = 25
      Caption = #1042#1089#1077#1075#1086' '#1074#1099#1087#1086#1083#1085#1077#1085#1086':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object Label2: TLabel
      Left = 181
      Top = 152
      Width = 143
      Height = 25
      Caption = #1055#1086#1083#1085#1086#1077' '#1074#1088#1077#1084#1103':'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalExec: TLabel
      Left = 335
      Top = 83
      Width = 30
      Height = 33
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblTotalTime: TLabel
      Left = 338
      Top = 152
      Width = 30
      Height = 33
      Caption = '---'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -27
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object btnRun: TButton
      Left = 22
      Top = 129
      Width = 115
      Height = 74
      Caption = #1055#1091#1089#1082
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -21
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = btnRunClick
    end
    object chPooled: TCheckBox
      Left = 147
      Top = 33
      Width = 175
      Height = 17
      Caption = #1048#1089#1087#1086#1083#1100#1079#1086#1074#1072#1090#1100' '#1087#1091#1083
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -17
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'ConnectionDef=EMPLOYEE')
    Left = 52
    Top = 60
  end
end
