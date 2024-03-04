object form_dados: Tform_dados
  OldCreateOrder = True
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 480
  Width = 640
  object FDConnection: TFDConnection
    Params.Strings = (
      'Database=financas'
      'User_Name=root'
      'Password=98765432'
      'Server=localhost'
      'Port=3307'
      'DriverID=MySQL')
    Left = 96
    Top = 128
  end
  object FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink
    VendorLib = 
      'C:\Users\tiere\Desktop\Prova Data Cempro\Financas\Output\libmysq' +
      'l.dll'
    Left = 248
    Top = 224
  end
  object FDGUIxWaitCursor: TFDGUIxWaitCursor
    Provider = 'Forms'
    Left = 248
    Top = 128
  end
  object FD_FBDriver: TFDPhysFBDriverLink
    VendorLib = 'C:\Program Files (x86)\Firebird\Firebird_2_5\bin\fbclient.dll'
    Left = 96
    Top = 224
  end
  object PostgDriver: TFDPhysPgDriverLink
    VendorLib = 
      'C:\Users\tiere\Desktop\Prova Data Cempro\Financas\Output\libpq.d' +
      'll'
    Left = 376
    Top = 208
  end
end
