object DataModule2: TDataModule2
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 272
  Width = 389
  object FDQuery1: TFDQuery
    Connection = FDConnection1
    SQL.Strings = (
      'select c.Company as Customer, '
      '       e.FirstName || '#39' '#39' || e.LastName as Employee,'
      
        '       (SELECT COUNT(*) FROM Orders WHERE CustNo = c.CustNo) as ' +
        'NumOrders'
      'FROM Customer c'
      'right outer join Orders o on o.CustNo = c.CustNo'
      'inner join Employee e on e.EmpNo = o.EmpNo'
      'union all'
      'select c.Company as Customer, '
      '       e.FirstName || '#39' '#39' || e.LastName as Employee,'
      
        '       (SELECT COUNT(*) FROM Orders WHERE CustNo = c.CustNo) as ' +
        'NumOrders'
      'FROM Customer c'
      'right outer join Orders o on o.CustNo = c.CustNo'
      'inner join Employee e on e.EmpNo = o.EmpNo'
      'union all'
      'select c.Company as Customer, '
      '       e.FirstName || '#39' '#39' || e.LastName as Employee,'
      
        '       (SELECT COUNT(*) FROM Orders WHERE CustNo = c.CustNo) as ' +
        'NumOrders'
      'FROM Customer c'
      'right outer join Orders o on o.CustNo = c.CustNo'
      'inner join Employee e on e.EmpNo = o.EmpNo')
    Left = 44
    Top = 136
  end
  object FDGUIxAsyncExecuteDialog1: TFDGUIxAsyncExecuteDialog
    Provider = 'FMX'
    Prompt = #1046#1076#1077#1084' '#1087#1086#1083#1091#1095#1077#1085#1080#1103' '#1088#1077#1079#1091#1083#1100#1090#1072#1090#1072'...'
    ShowDelay = 10
    Left = 200
    Top = 136
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'Database=c:\Data\dbdemos.gdb'
      'User_Name=sysdba'
      'Password=masterkey'
      'DriverID=IB')
    LoginPrompt = False
    Left = 40
    Top = 72
  end
  object FDManager1: TFDManager
    FormatOptions.AssignedValues = [fvMapRules]
    FormatOptions.OwnMapRules = True
    FormatOptions.MapRules = <
      item
      end>
    Active = True
    Left = 40
    Top = 16
  end
  object FDPhysIBDriverLink1: TFDPhysIBDriverLink
    Left = 176
    Top = 16
  end
  object FDGUIxWaitCursor1: TFDGUIxWaitCursor
    Provider = 'FMX'
    Left = 176
    Top = 72
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired]
    UpdateOptions.CheckRequired = False
    Left = 120
    Top = 192
  end
end
