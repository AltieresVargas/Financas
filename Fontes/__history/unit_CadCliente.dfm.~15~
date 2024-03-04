object form_CadCliente: Tform_CadCliente
  Left = 0
  Top = 0
  Align = alClient
  BorderStyle = bsSingle
  Caption = 'Finan'#231'as - Cadastro de Clientes'
  ClientHeight = 488
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OldCreateOrder = True
  Position = poDesktopCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 15
  object pnl_PesqCliente: TPanel
    Left = 0
    Top = 0
    Width = 740
    Height = 260
    Align = alTop
    Alignment = taLeftJustify
    Color = clSkyBlue
    ParentBackground = False
    TabOrder = 0
    object Label15: TLabel
      Left = 8
      Top = 60
      Width = 217
      Height = 15
      Caption = '* Campos de preenchimento obrigat'#243'rio.'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clHotLight
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = []
      ParentFont = False
    end
    object lb_dtNascimento: TLabel
      Left = 493
      Top = 12
      Width = 94
      Height = 15
      Caption = 'Data Nascimento:'
    end
    object edt_CompEnd: TLabeledEdit
      Left = 493
      Top = 101
      Width = 102
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 80
      EditLabel.Height = 15
      EditLabel.Caption = 'Complemento:'
      TabOrder = 6
    end
    object edt_Telefone: TLabeledEdit
      Left = 377
      Top = 31
      Width = 97
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'Telefone:'
      MaxLength = 12
      NumbersOnly = True
      TabOrder = 2
      StyleName = 'Windows'
      OnEnter = edt_TelefoneEnter
      OnExit = edt_TelefoneExit
    end
    object edt_Cep: TLabeledEdit
      Left = 8
      Top = 151
      Width = 95
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 24
      EditLabel.Height = 15
      EditLabel.BiDiMode = bdLeftToRight
      EditLabel.Caption = 'CEP:'
      EditLabel.ParentBiDiMode = False
      MaxLength = 9
      NumbersOnly = True
      TabOrder = 7
      OnEnter = edt_CepEnter
      OnExit = edt_CepExit
    end
    object edt_Endereco: TLabeledEdit
      Left = 8
      Top = 101
      Width = 354
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 52
      EditLabel.Height = 15
      EditLabel.Caption = 'Endereco:'
      TabOrder = 4
      StyleName = 'Windows'
    end
    object edt_NumEnd: TLabeledEdit
      Left = 377
      Top = 101
      Width = 97
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 47
      EditLabel.Height = 15
      EditLabel.Caption = 'N'#250'mero:'
      MaxLength = 10
      TabOrder = 5
    end
    object edt_Cidade: TLabeledEdit
      Left = 312
      Top = 151
      Width = 217
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 37
      EditLabel.Height = 15
      EditLabel.Caption = 'Cidade'
      TabOrder = 9
      StyleName = 'Windows'
    end
    object edt_UF: TLabeledEdit
      Left = 544
      Top = 151
      Width = 51
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 45
      EditLabel.Height = 15
      EditLabel.Caption = 'Sigla UF:'
      MaxLength = 2
      TabOrder = 10
    end
    object edt_Bairro: TLabeledEdit
      Left = 130
      Top = 151
      Width = 167
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 31
      EditLabel.Height = 15
      EditLabel.Caption = 'Bairro'
      TabOrder = 8
      StyleName = 'Windows'
    end
    object edt_ConsCPF: TLabeledEdit
      Left = 8
      Top = 31
      Width = 105
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 29
      EditLabel.Height = 15
      EditLabel.Caption = 'CPF:*'
      MaxLength = 11
      NumbersOnly = True
      TabOrder = 0
      OnEnter = edt_ConsCPFEnter
      OnExit = edt_ConsCPFExit
    end
    object pnl_Botao: TPanel
      Left = 601
      Top = 1
      Width = 138
      Height = 258
      Align = alRight
      Color = clSkyBlue
      ParentBackground = False
      TabOrder = 12
      object btn_Deletar: TButton
        Left = 30
        Top = 118
        Width = 68
        Height = 25
        Caption = 'Deletar'
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 2
        StyleName = 'Windows'
        OnClick = btn_DeletarClick
      end
      object btn_Limpar: TButton
        Left = 30
        Top = 163
        Width = 68
        Height = 25
        Caption = 'Limpar'
        TabOrder = 3
        StyleName = 'Windows'
        OnClick = btn_LimparClick
      end
      object btn_Incluir: TButton
        Left = 30
        Top = 73
        Width = 68
        Height = 25
        Caption = 'Salvar'
        DoubleBuffered = False
        ParentDoubleBuffered = False
        TabOrder = 1
        StyleName = 'Windows'
        OnClick = btn_IncluirClick
      end
      object btn_Pesquisar: TButton
        Left = 30
        Top = 29
        Width = 68
        Height = 25
        Caption = 'Pesquisar'
        TabOrder = 0
        StyleName = 'Windows'
        OnClick = btn_PesquisarClick
      end
      object btn_Editar: TButton
        Left = 30
        Top = 209
        Width = 68
        Height = 25
        Caption = 'Editar'
        DoubleBuffered = False
        Enabled = False
        ParentDoubleBuffered = False
        TabOrder = 4
        StyleName = 'Windows'
        OnClick = btn_EditarClick
      end
    end
    object edt_NomeCliente: TLabeledEdit
      Left = 145
      Top = 31
      Width = 217
      Height = 23
      CharCase = ecUpperCase
      EditLabel.Width = 81
      EditLabel.Height = 15
      EditLabel.Caption = 'Nome Cliente:*'
      TabOrder = 1
      StyleName = 'Windows'
    end
    object edt_DtNascimento: TDateTimePicker
      Left = 493
      Top = 31
      Width = 102
      Height = 23
      Date = 44865.000000000000000000
      Time = 0.056988784723216670
      TabOrder = 3
      StyleName = 'Windows'
    end
    object memo_Obs: TMemo
      Left = 8
      Top = 198
      Width = 587
      Height = 57
      CharCase = ecUpperCase
      TabOrder = 11
      StyleName = 'Windows'
    end
    object lb_Obs: TStaticText
      Left = 8
      Top = 180
      Width = 28
      Height = 19
      Caption = 'Obs:'
      TabOrder = 13
    end
  end
  object pnl_Grid: TPanel
    Left = 0
    Top = 260
    Width = 740
    Height = 457
    Align = alTop
    Alignment = taLeftJustify
    TabOrder = 1
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 738
      Height = 24
      Align = alTop
      Color = clWhite
      ParentBackground = False
      TabOrder = 0
      object Label3: TLabel
        Left = 24
        Top = 5
        Width = 344
        Height = 15
        Caption = 
          'Clientes Cadastrados:   (Duplo clic na linha do Cliente para edi' +
          'tar)'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -12
        Font.Name = 'Segoe UI'
        Font.Style = []
        ParentFont = False
        StyleName = 'Windows'
      end
    end
    object dbg_Clientes: TDBGrid
      Left = 1
      Top = 25
      Width = 738
      Height = 431
      Align = alClient
      Anchors = [akLeft, akTop, akRight]
      DataSource = db_Clientes
      DrawingStyle = gdsGradient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = dbg_ClientesDblClick
      OnKeyDown = dbg_ClientesKeyDown
      Columns = <
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'id_cliente'
          Title.Alignment = taCenter
          Title.Caption = 'Id.Codigo'
          Width = 70
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'str_nome'
          Title.Alignment = taCenter
          Title.Caption = 'Nome do Cliente'
          Width = 244
          Visible = True
        end
        item
          Alignment = taRightJustify
          Expanded = False
          FieldName = 'str_cpf'
          Title.Alignment = taCenter
          Title.Caption = 'CPF'
          Width = 100
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'str_telefone'
          Title.Alignment = taCenter
          Title.Caption = 'Telefone'
          Width = 112
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'dt_alterado'
          Title.Alignment = taCenter
          Title.Caption = 'Alterado'
          Width = 115
          Visible = True
        end
        item
          Alignment = taCenter
          Expanded = False
          FieldName = 'dt_cadastro'
          Title.Alignment = taCenter
          Title.Caption = 'Cadastrado'
          Width = 76
          Visible = True
        end>
    end
  end
  object db_Clientes: TDataSource
    Left = 421
    Top = 361
  end
end
