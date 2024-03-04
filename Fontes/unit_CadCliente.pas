unit unit_CadCliente;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, unit_Dados, MaskUtils;

type
  Tform_CadCliente = class(TForm)
    pnl_PesqCliente: TPanel;
    edt_CompEnd: TLabeledEdit;
    edt_Telefone: TLabeledEdit;
    edt_Cep: TLabeledEdit;
    edt_Endereco: TLabeledEdit;
    edt_NumEnd: TLabeledEdit;
    edt_Cidade: TLabeledEdit;
    edt_UF: TLabeledEdit;
    edt_Bairro: TLabeledEdit;
    pnl_Grid: TPanel;
    Panel2: TPanel;
    Label3: TLabel;
    dbg_Clientes: TDBGrid;
    db_Clientes: TDataSource;
    Label15: TLabel;
    edt_ConsCPF: TLabeledEdit;
    lb_dtNascimento: TLabel;
    pnl_Botao: TPanel;
    btn_Deletar: TButton;
    btn_Limpar: TButton;
    btn_Incluir: TButton;
    btn_Pesquisar: TButton;
    btn_Editar: TButton;
    edt_NomeCliente: TLabeledEdit;
    edt_DtNascimento: TDateTimePicker;
    memo_Obs: TMemo;
    lb_Obs: TStaticText;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure dbg_ClientesKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_DeletarClick(Sender: TObject);
    procedure btn_PesquisarClick(Sender: TObject);
    procedure btn_IncluirClick(Sender: TObject);
    procedure btn_LimparClick(Sender: TObject);
    procedure dbg_ClientesDblClick(Sender: TObject);
    procedure btn_EditarClick(Sender: TObject);
    procedure prc_EnableCampos(condicao: Boolean);
    procedure edt_ConsCPFExit(Sender: TObject);
  //  procedure edt_ConsCPFKeyPress(Sender: TObject; var Key: Char; Key2: Word);
    procedure edt_ConsCPFEnter(Sender: TObject);
    procedure edt_TelefoneEnter(Sender: TObject);
    procedure edt_TelefoneExit(Sender: TObject);
    procedure edt_CepEnter(Sender: TObject);
    procedure edt_CepExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_CadCliente: Tform_CadCliente;

implementation
uses
  unit_Funcoes;
{$R *.dfm}

procedure Tform_CadCliente.btn_DeletarClick(Sender: TObject);
begin
    if( NOT (dbg_Clientes.DataSource.DataSet.IsEmpty)) then
    begin
        form_dados.Cliente.prc_Deleta(dbg_Clientes.DataSource.DataSet.FieldByName('id_cliente').AsInteger);
        db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');

        btn_LimparClick(Sender);
    end;

end;


procedure Tform_CadCliente.btn_IncluirClick(Sender: TObject);
var
   Erro, InsertOuUpdate, Msg : string;
begin
    prc_ValidaCamposObrigatorios( form_CadCliente );

{    if (edt_ConsCPF.Text = '') or (edt_NomeCliente.Text = '') then
      begin

        if (edt_ConsCPF.Text = '') then
          begin
            edt_ConsCPF.SetFocus;
          end
         else
            edt_NomeCliente.SetFocus;

      end
    else
      begin
  }        InsertOuUpdate := btn_Incluir.Caption;

          form_Dados.Cliente.str_nomecliente  :=  edt_NomeCliente.Text;
          form_Dados.Cliente.str_cpf          :=  edt_ConsCPF.Text;
          form_Dados.Cliente.dt_alterado      :=  Now();
          form_Dados.Cliente.dt_cadastro      :=  Now();
          form_Dados.Cliente.dt_nascimento    :=  edt_DtNascimento.Date;
          form_Dados.Cliente.str_endereco     :=  edt_Endereco.Text;
          form_Dados.Cliente.str_num          :=  edt_NumEnd.Text;
          form_Dados.Cliente.str_complemento  :=  edt_CompEnd.Text;
          form_Dados.Cliente.str_cep          :=  edt_Cep.Text;
          form_Dados.Cliente.str_bairro       :=  edt_Bairro.Text;
          form_Dados.Cliente.str_cidade       :=  edt_Cidade.Text;
          form_Dados.Cliente.str_uf           :=  edt_UF.Text;
          form_Dados.Cliente.str_telefone     :=  edt_Telefone.Text;
          form_Dados.Cliente.str_obs          :=  memo_Obs.Text;


        if form_dados.Cliente.fnc_InserirAlterar( InsertOuUpdate , Erro) then
         begin
              frc_criar_msg('INSERINDO DADOS',
                 InsertOuUpdate + ' Novo Cliente!',
                'Cliente '+ InsertOuUpdate + ' com SUCESSO! ',
                ExtractFilePath(Application.ExeName) +'\icones\success_128.bmp',
                'OK');

            db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');

            btn_LimparClick(Sender);

          end else
             begin
                frc_criar_msg('INSERINDO DADOS',
                'ERRO ao '+ InsertOuUpdate + ' Cliente!',
                'N�o foi poss�vel '+ InsertOuUpdate + ' o Cliente, poss�veis causas: ' +
                Erro ,
                ExtractFilePath(Application.ExeName) +'\icones\error_128.bmp',
                'OK');

                db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');

                edt_ConsCPF.SetFocus;
            end;
//    end;

end;

procedure Tform_CadCliente.btn_LimparClick(Sender: TObject);
begin
       edt_NomeCliente.Clear;
       edt_ConsCPF.Clear;
       edt_DtNascimento.Date := now();
       edt_Endereco.Clear;
       edt_NumEnd.Clear;
       edt_CompEnd.Clear;
       edt_Cep.Clear;
       edt_Bairro.Clear;
       edt_Cidade.Clear;
       edt_UF.Clear;
       edt_Telefone.Clear;
       memo_Obs.Clear;
       btn_Incluir.Caption := 'Salvar';
       btn_Editar.Enabled := false;
       db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');
       prc_EnableCampos(true);
end;

procedure Tform_CadCliente.btn_PesquisarClick(Sender: TObject);
begin
    if (edt_ConsCPF.Text = '') and (edt_NomeCliente.Text = '') then

      begin
        db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');
      end
    else
      begin
         if (edt_ConsCPF.Text <> '') then
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
                  db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');
                  edt_NomeCliente.SetFocus;
              end;
      end;
end;

procedure Tform_CadCliente.dbg_ClientesDblClick(Sender: TObject);
begin
       form_dados.Cliente.id_cliente  := dbg_Clientes.DataSource.DataSet.FieldByName('id_cliente').AsInteger;
       edt_NomeCliente.Text  := dbg_Clientes.DataSource.DataSet.FieldByName('str_nome').AsString;
       edt_ConsCPF.Text      := dbg_Clientes.DataSource.DataSet.FieldByName('str_cpf').AsString;
       edt_DtNascimento.Date := dbg_Clientes.DataSource.DataSet.FieldByName('dt_nascimento').AsDateTime;
       edt_Endereco.Text     := dbg_Clientes.DataSource.DataSet.FieldByName('str_endereco').AsString;
       edt_NumEnd.Text       := dbg_Clientes.DataSource.DataSet.FieldByName('str_num').AsString;
       edt_CompEnd.Text      := dbg_Clientes.DataSource.DataSet.FieldByName('str_complemento').AsString;
       edt_Cep.Text          := dbg_Clientes.DataSource.DataSet.FieldByName('str_cep').AsString;
       edt_Bairro.Text       := dbg_Clientes.DataSource.DataSet.FieldByName('str_bairro').AsString;
       edt_Cidade.Text       := dbg_Clientes.DataSource.DataSet.FieldByName('str_cidade').AsString;
       edt_UF.Text           := dbg_Clientes.DataSource.DataSet.FieldByName('str_uf').AsString;
       edt_Telefone.Text     := dbg_Clientes.DataSource.DataSet.FieldByName('str_telefone').AsString;
       memo_Obs.Text         := dbg_Clientes.DataSource.DataSet.FieldByName('str_obs').AsString;
       btn_Editar.Enabled    := true;
       prc_EnableCampos(false);

end;

procedure Tform_CadCliente.btn_EditarClick(Sender: TObject);
begin
       btn_Incluir.Caption := 'Atualizar';
       prc_EnableCampos(true);
end;
procedure Tform_CadCliente.dbg_ClientesKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
    if( NOT (dbg_Clientes.DataSource.DataSet.IsEmpty)) AND (Key = VK_DELETE) then
         btn_DeletarClick(sender);
end;

procedure Tform_CadCliente.edt_CepEnter(Sender: TObject);
begin
    edt_Cep.Text := '';
end;

procedure Tform_CadCliente.edt_CepExit(Sender: TObject);
begin
  if edt_Cep.text <>'' then
    edt_Cep.text := FormatMaskText('00000-000;0;', edt_Cep.text);
end;

procedure Tform_CadCliente.edt_ConsCPFEnter(Sender: TObject);
begin
    edt_ConsCPF.Text := '';
end;

procedure Tform_CadCliente.edt_ConsCPFExit(Sender: TObject);
begin
  if edt_ConsCPF.text <>'' then
    edt_ConsCPF.text := FormatMaskText('000\.000\.000\-00;0;', edt_ConsCPF.text);
end;

procedure Tform_CadCliente.edt_TelefoneEnter(Sender: TObject);
begin
    edt_Telefone.Text := '';
end;

procedure Tform_CadCliente.edt_TelefoneExit(Sender: TObject);
begin
  if edt_Telefone.text <>'' then
    edt_Telefone.text := FormatMaskText('(00) 00000-0000;0;', edt_Telefone.text);
end;

{
procedure Tform_CadCliente.edt_ConsCPFKeyPress(Sender: TObject; var Key: Char; Key2: Word);
begin
  if not ((key in ['1','2','3','4','5','6','7','8','9','0']) and (key2 in[VK_BACK, VK_RETURN])) then
    key :=#0;
end;
 }
procedure Tform_CadCliente.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;


procedure Tform_CadCliente.FormShow(Sender: TObject);
begin
   db_Clientes.DataSet := form_dados.Cliente.fnc_Cosulta('');
   edt_DtNascimento.Date := now();
end;

procedure Tform_CadCliente.prc_EnableCampos(condicao : Boolean);
begin

       edt_NomeCliente.Enabled := condicao;
       edt_ConsCPF.Enabled := condicao;
       edt_DtNascimento.Enabled := condicao;
       edt_Endereco.Enabled := condicao;
       edt_NumEnd.Enabled := condicao;
       edt_CompEnd.Enabled := condicao;
       edt_Cep.Enabled := condicao;
       edt_Bairro.Enabled := condicao;
       edt_Cidade.Enabled := condicao;
       edt_UF.Enabled := condicao;
       edt_Telefone.Enabled := condicao;
       memo_Obs.Enabled := condicao;
       btn_Incluir.Enabled := condicao;
       lb_dtNascimento.Enabled := condicao;
       lb_Obs.Enabled := condicao;

end;

end.
