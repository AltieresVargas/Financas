unit unit_Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Mask, Vcl.Grids, unit_Funcoes, unit_CadCliente,
  unit_ConfigServidor, Data.DB, Vcl.DBGrids, classe.RegistroFinancas,
  classe.Cliente, FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param,
  FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf,
  FireDAC.Stan.Async, FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  Vcl.ComCtrls, MaskUtils, unit_Dados;

type
  Tform_principal = class(TForm)
    pnl_Fundo: TPanel;
    pnl_Grid: TPanel;
    db_RegistroFinancas: TDataSource;
    dbg_RegistroFinancas: TDBGrid;
    pnl_Edicao: TPanel;
    pnl_TipoOp: TPanel;
    cbx_Deposito: TCheckBox;
    cbx_Despesa: TCheckBox;
    StaticText3: TStaticText;
    pnl_EditaInfo: TPanel;
    Label1: TLabel;
    edt_Valor: TLabeledEdit;
    edt_Descricao: TLabeledEdit;
    dt_DataOperacao: TDateTimePicker;
    StaticText1: TStaticText;
    edt_NumDoc: TLabeledEdit;
    pnl_Botoes: TPanel;
    btn_Incluir: TButton;
    btn_Delete: TButton;
    btn_Limpar: TButton;
    pnl_FundoPesquisa: TPanel;
    edt_SaldoAtual: TLabeledEdit;
    edt_ConsCPF: TLabeledEdit;
    edt_NomeCliente: TLabeledEdit;
    btn_Pesquisa: TButton;
    btn_CadCli: TButton;
    Panel2: TPanel;
    Label3: TLabel;
    memo_Obs: TMemo;
    pnl_PesqPeriodo: TPanel;
    dt_Inicio: TDateTimePicker;
    Label4: TLabel;
    Label5: TLabel;
    dt_Fim: TDateTimePicker;
    Label6: TLabel;
    db_Clientes: TDataSource;
    btn_PesqPeriodo: TButton;
    btn_Servidor: TButton;
    procedure btn_CadCliClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_ServidorClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cbx_DespesaClick(Sender: TObject);
    procedure cbx_DepositoClick(Sender: TObject);
    procedure btn_PesqPeriodoClick(Sender: TObject);
    procedure btn_PesquisaClick(Sender: TObject);
    procedure btn_IncluirClick(Sender: TObject);
    procedure edt_ValorExit(Sender: TObject);
    procedure edt_SaldoAtualExit(Sender: TObject);
    procedure edt_ValorKeyPress(Sender: TObject; var Key: Char);
    procedure edt_ValorEnter(Sender: TObject);
    procedure edt_NomeClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
//    procedure edt_ConsCPFKeyPress(Sender: TObject; var Key: Char; Key2: Word);
    procedure edt_ConsCPFEnter(Sender: TObject);
    procedure edt_ConsCPFExit(Sender: TObject);
    procedure btn_LimparClick(Sender: TObject);
    procedure db_RegistroFinancasDataChange(Sender: TObject; Field: TField);
    procedure dbg_RegistroFinancasDblClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure edt_ConsCPFKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dbg_RegistroFinancasDrawColumnCell(Sender: TObject;
      const Rect: TRect; DataCol: Integer; Column: TColumn;
      State: TGridDrawState);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_principal: Tform_principal;
  id_Cli  : integer;

implementation


{$R *.dfm}


procedure Tform_principal.btn_CadCliClick(Sender: TObject);
begin

    try
        if id_Cli <> 0 then
          begin
            btn_Pesquisa.caption := 'Nova Pesquisa';
            btn_PesquisaClick(Sender);
          end;
        form_CadCliente := Tform_CadCliente.Create( Self );
        form_CadCliente.ShowModal;
    finally
      btn_Pesquisa.caption := 'Pesquisar';
	      form_CadCliente.Free
    end;
end;

procedure Tform_principal.btn_DeleteClick(Sender: TObject);
begin
       if( NOT (dbg_RegistroFinancas.DataSource.DataSet.IsEmpty)) then
    begin
        form_dados.RegistroFinancas.prc_Deleta_Item(dbg_RegistroFinancas.DataSource.
                                    DataSet.FieldByName('id_operacao').AsInteger, id_Cli);

            edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
                                              form_dados.RegistroFinancas.fnc_BuscaSaldo(id_Cli));

        db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.fnc_Cosulta(id_Cli);
//        edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
//                                   db_RegistroFinancas.DataSet.FieldByName('fl_saldo').AsCurrency);
        btn_LimparClick(Sender);
    end;
end;

procedure Tform_principal.btn_IncluirClick(Sender: TObject);
var
  dValor, dSaldo  :  Currency;
  sValor, Erro, InsertOuUpdate : string;

begin

    if (cbx_Deposito.checked = false) and (cbx_Despesa.checked = false) then
      begin
         frc_criar_msg('INSERINDO DADOS',
                'ERRO AO INSERIR AS INFORMA��ES!!',
                'N�o foi poss�vel salvar as informa��es, poss�veis causas: ' +
                'Tipo de opera��o n�o definina.' ,
                ExtractFilePath(Application.ExeName) +'\icones\error_128.bmp',
                'OK');
      end
    else
      begin
          InsertOuUpdate := btn_Incluir.Caption;

          form_dados.RegistroFinancas.cli_id_cliente   := id_Cli;
          form_dados.RegistroFinancas.str_NumDoc       := edt_NumDoc.Text;
          form_dados.RegistroFinancas.str_descricao    := edt_descricao.Text;
          form_dados.RegistroFinancas.dt_Operacao      := dt_DataOperacao.Date;
          form_Dados.RegistroFinancas.dt_alterado      :=  Now();
          form_Dados.RegistroFinancas.dt_cadastro      :=  Now();
          form_dados.RegistroFinancas.str_obs          := memo_Obs.Text;


          sValor := StringReplace(edt_Valor.text,'.', '', [rfReplaceAll]);
          sValor := StringReplace(sValor,'R$', '', [rfReplaceAll]);
          sValor := StringReplace(sValor,' ', '', [rfReplaceAll]);
          dValor := StrToCurr(sValor);
          form_dados.RegistroFinancas.fl_valor         := dValor;
           sValor := '';
          sValor := StringReplace(edt_SaldoAtual.text,'.', '', [rfReplaceAll]);
          sValor := StringReplace(sValor,'R$', '', [rfReplaceAll]);
          sValor := StringReplace(sValor,' ', '', [rfReplaceAll]);
          dSaldo := StrToCurr(sValor);

          if cbx_Deposito.checked = true then
            begin
              form_dados.RegistroFinancas.str_tipoOperacao := 'ENTRADA';
              form_dados.RegistroFinancas.fl_Saldo         := ( dSaldo ) + ( dValor );
            end
          else
            begin
              form_dados.RegistroFinancas.str_tipoOperacao := 'SA�DA';
              form_dados.RegistroFinancas.fl_Saldo         := ( dSaldo ) - ( dValor );
            end;


          if form_dados.RegistroFinancas.fnc_InserirAlterar( InsertOuUpdate , Erro) then
             begin
                  frc_criar_msg('INSERINDO DADOS',
                    'INFORMA��ES INSERIDADAS!!',
                    'Novas Informa��es Cadastradas com SUCESSO! ',
                    ExtractFilePath(Application.ExeName) +'\icones\success_128.bmp',
                    'OK');

                edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
                                              form_dados.RegistroFinancas.fnc_BuscaSaldo(id_Cli));

                db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.fnc_Cosulta(id_Cli);

//                edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
//                                       db_RegistroFinancas.DataSet.FieldByName('fl_saldo').AsCurrency);

                btn_LimparClick(Sender);

              end
          else
              begin
                    frc_criar_msg('INSERINDO DADOS',
                    'ERRO AO INSERIR AS INFORMA��ES!!',
                    'N�o foi poss�vel salvar as informa��es, poss�veis causas: ' +
                    Erro ,
                    ExtractFilePath(Application.ExeName) +'\icones\error_128.bmp',
                    'OK');

                    db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.fnc_Cosulta(id_Cli);

                    edt_NumDoc.SetFocus;
              end;

     end;
end;


procedure Tform_principal.btn_LimparClick(Sender: TObject);
begin
       cbx_Deposito.Checked := false;
       cbx_Despesa.Checked  := false;
       edt_descricao.Text   := '';
       edt_Valor.Text       := '';
       edt_NumDoc.Text      := '';
       dt_DataOperacao.Date := Now();
       memo_Obs.Text        := '';
       btn_Incluir.Caption  := 'Incluir';
end;

procedure Tform_principal.btn_PesqPeriodoClick(Sender: TObject);
begin
     edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
                                        form_dados.RegistroFinancas.fnc_BuscaSaldo(id_Cli));

     db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.
                                        fnc_CosultaPorPreiodo(dt_Inicio.Date, dt_Fim.Date, id_Cli);

end;

procedure Tform_principal.btn_PesquisaClick(Sender: TObject);
begin
 if  (btn_Pesquisa.caption = 'Pesquisar') then
   begin
      if ((edt_ConsCPF.Text = '') or (edt_ConsCPF.Text = '   .   .   -  ')) and
          (edt_NomeCliente.Text = '') then
          begin
            edt_NomeCliente.SetFocus;
          end
        else
          begin
            if (edt_ConsCPF.Text <> '') and (edt_ConsCPF.Text <> '   .   .   -  ') then
              begin
                db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta(edt_ConsCPF.Text);
              end
            else
              db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta(edt_NomeCliente.Text);

            if (db_Clientes.DataSet.FieldByName('id_cliente').AsInteger <= 0) and
                (db_Clientes.DataSet.FieldByName('str_nome').AsString = '') then
              begin
                frc_criar_msg('Aten��o!!!',
                    'Cliente n�o encontrado!!',
                    'Informa��es de pesquisa n�o encontradas entre os clientes cadastrados na base de dados!!',
                    ExtractFilePath(Application.ExeName) +'\icones\Alerta_Atencao_128.bmp',
                    'OK');
                  edt_NomeCliente.SetFocus;
              end
            else
              begin
                edt_NomeCliente.Text := db_Clientes.DataSet.FieldByName('str_nome').AsString;
                edt_ConsCPF.Text := db_Clientes.DataSet.FieldByName('str_cpf').AsString;
                id_Cli := db_Clientes.DataSet.FieldByName('id_cliente').AsInteger;
                edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',
                                              form_dados.RegistroFinancas.fnc_BuscaSaldo(id_Cli));

                db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.
                                            fnc_Cosulta(id_Cli);
                pnl_Edicao.Enabled      := true;
                pnl_PesqPeriodo.Enabled := true;
                btn_Pesquisa.caption    := 'Nova Pesquisa';
              end;
         end;
   end
  else
    begin

      db_Clientes.DataSet.Close;
      db_RegistroFinancas.DataSet.Close;
      btn_Pesquisa.caption := 'Pesquisar';
      edt_NomeCliente.Text := '';
      edt_ConsCPF.Text     := '';
      id_Cli               := 0;
      edt_SaldoAtual.text  := '';
      pnl_Edicao.Enabled := false;
      pnl_PesqPeriodo.Enabled := false;
      btn_LimparClick(Sender);
    end;
end;

procedure Tform_principal.btn_ServidorClick(Sender: TObject);
begin
    try
      form_Login := Tform_Login.Create( Self );
      form_Login.ShowModal;
    finally
	    form_Login.Free
    end;
end;

procedure Tform_principal.cbx_DepositoClick(Sender: TObject);
begin
        if cbx_Deposito.checked = true then
           cbx_Despesa.Enabled := false
        else
           cbx_Despesa.Enabled := true;
end;

procedure Tform_principal.cbx_DespesaClick(Sender: TObject);
begin
        if cbx_Despesa.checked = true then
           cbx_Deposito.Enabled := false
        else
           cbx_Deposito.Enabled := true;
end;



procedure Tform_principal.dbg_RegistroFinancasDblClick(Sender: TObject);
begin

  btn_LimparClick(Sender);
  form_dados.RegistroFinancas.id_Operacao  := dbg_RegistroFinancas.DataSource.DataSet.
                                                                FieldByName('id_operacao').AsInteger;
  form_dados.RegistroFinancas.cli_id_cliente  := dbg_RegistroFinancas.DataSource.DataSet.
                                                                FieldByName('cli_id_cliente').AsInteger;
  edt_NumDoc.Text       := dbg_RegistroFinancas.DataSource.DataSet.FieldByName('str_num_doc').AsString;
  edt_valor.Text        := dbg_RegistroFinancas.DataSource.DataSet.FieldByName('fl_valor').AsString;
  dt_DataOperacao.Date  := dbg_RegistroFinancas.DataSource.DataSet.FieldByName('dt_operacao').AsDateTime;
  edt_Descricao.Text    := dbg_RegistroFinancas.DataSource.DataSet.FieldByName('str_descricao').AsString;
  memo_Obs.Text         := dbg_RegistroFinancas.DataSource.DataSet.FieldByName('str_obs').AsString;
  if dbg_RegistroFinancas.DataSource.DataSet.FieldByName('str_tipo_operacao').AsString = 'ENTRADA' then
    begin
           cbx_Deposito.checked := true;
           cbx_Despesa.Enabled := false;
    end
  else
    begin
           cbx_Despesa.checked  := true;
           cbx_Deposito.Enabled := false;
    end;
  btn_Incluir.Caption   := 'Alterar';
end;

procedure Tform_principal.dbg_RegistroFinancasDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
// alterando a cor da linha atual selecionada
    if (gdSelected in State) or (gdFocused in State) then
       TDBGrid(Sender).Canvas.Brush.Color := clGradientInactiveCaption
    else
        TDBGrid(Sender).Canvas.Brush.Color := clWindow;

// alterando a cor da fonte
  if db_RegistroFinancas.DataSet.FieldByName('str_tipo_operacao').AsString = 'SA�DA' then
    TDBGrid(Sender).Canvas.Font.Color := clRed
  else
    TDBGrid(Sender).Canvas.Font.Color := clBlue;

//  atualizando a visualiza��o do DBGrid
    TDBGrid(Sender).Canvas.FillRect(Rect);
    TDBGrid(Sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure Tform_principal.db_RegistroFinancasDataChange(Sender: TObject;
  Field: TField);
begin
    TNumericField(db_RegistroFinancas.DataSet.FieldByName('fl_valor')).
                                    DisplayFormat := 'R$ #,###,##0.00';
    TNumericField(db_RegistroFinancas.DataSet.FieldByName('fl_saldo')).
                                    DisplayFormat := 'R$ #,###,##0.00';

end;

procedure Tform_principal.edt_ConsCPFEnter(Sender: TObject);
begin
     edt_ConsCPF.text :='';
end;

procedure Tform_principal.edt_ConsCPFExit(Sender: TObject);
begin
  if edt_ConsCPF.text <>'' then
    edt_ConsCPF.text := FormatMaskText('000\.000\.000\-00;0;', edt_ConsCPF.text);
end;

procedure Tform_principal.edt_ConsCPFKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if(Key =  VK_RETURN ) then
     btn_PesquisaClick(Sender);
end;
{
procedure Tform_principal.edt_ConsCPFKeyPress(Sender: TObject; var Key: Char; Key2: Word);
begin
  if not (key in ['1','2','3','4','5','6','7','8','9','0',',','.',#8,#9]) then
    key :=#0;
end;
  }
procedure Tform_principal.edt_NomeClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if(Key =  VK_RETURN ) then
     btn_PesquisaClick(Sender);
end;

procedure Tform_principal.edt_SaldoAtualExit(Sender: TObject);
begin
    edt_SaldoAtual.text := FormatFloat('R$ #,###,##0.00',strtofloat(edt_SaldoAtual.text));
end;

procedure Tform_principal.edt_ValorEnter(Sender: TObject);
begin
     edt_Valor.text :='';
end;

procedure Tform_principal.edt_ValorExit(Sender: TObject);
begin
  if edt_Valor.text ='' then
    edt_Valor.text := '0,00';
    edt_Valor.text := FormatFloat('R$ #,###,##0.00',strtofloat(edt_Valor.text));
end;



procedure Tform_principal.edt_ValorKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['1','2','3','4','5','6','7','8','9','0',',','.',#8,#9]) then
    key :=#0;
end;

procedure Tform_principal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
   form_Dados.Cliente.Destroy;
  form_Dados.RegistroFinancas.Destroy;
  Action := caFree;
end;

procedure Tform_principal.FormCreate(Sender: TObject);
begin
    form_Dados.Cliente := TCliente.Create(form_Dados.FDConnection);
    form_Dados.RegistroFinancas := TRegistroFinancas.Create(form_Dados.FDConnection);

end;

procedure Tform_principal.FormShow(Sender: TObject);
begin

       dt_DataOperacao.Date := now();
       dt_Inicio.Date := now();
       dt_Fim.Date := now();
  //  db_RegistroFinancas.DataSet := form_dados.RegistroFinancas.fnc_Cosulta(1);
end;

end.
