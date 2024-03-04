unit unit_ConfigServidor;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  Tform_Login = class(TForm)
    shp_fundo: TShape;
    pnl_Fundo: TPanel;
    pnl_Bottom: TPanel;
    pnl_Meio: TPanel;
    pnl_Topo: TPanel;
    img_BaseDados: TImage;
    Label1: TLabel;
    Label2: TLabel;
    pnl_Botoes: TPanel;
    pnl_Nao: TPanel;
    btn_Confirma: TSpeedButton;
    pnl_Sim: TPanel;
    btn_Cancela: TSpeedButton;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    edt_NomeBDAtual: TEdit;
    edt_NomeServidorAtual: TEdit;
    edt_LoginAtual: TEdit;
    edt_SenhaAtual: TEdit;
    edt_PortaAtual: TEdit;
    Panel3: TPanel;
    Label6: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label15: TLabel;
    edt_NomeServidor: TEdit;
    edt_Porta: TEdit;
    edt_NomeBD: TEdit;
    edt_Login: TEdit;
    edt_Senha: TEdit;
    Panel1: TPanel;
    Label3: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    cbx_BaseDados: TComboBox;
    StaticText3: TStaticText;
    StaticText1: TStaticText;
    cbx_BaseDadosAtual: TComboBox;
    cbx_DefineBD: TComboBox;
    procedure btn_ConfirmaClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_CancelaClick(Sender: TObject);
//    procedure cbx_MysqlClick(Sender: TObject);
//    procedure cbx_FirebirdClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_Login: Tform_Login;

implementation

uses
  unit_Dados,
  unit_Funcoes;

{$R *.dfm}

procedure Tform_Login.btn_ConfirmaClick(Sender: TObject);
var
  str_DriveBD : string;
begin
     if (edt_NomeBD.Text <> '') and
        (edt_NomeServidor.Text <> '') and
        (edt_Login.Text <> '') and
        (edt_Senha.Text  <> '') and
        (edt_Porta.Text  <> '') and
        (cbx_BaseDados.ItemIndex > -1)
     then
       begin
        cbx_DefineBD.ItemIndex := cbx_BaseDados.ItemIndex;
         form_Dados.Conexao.Servidor :=  edt_NomeServidor.Text;
         form_Dados.Conexao.Base     :=  edt_NomeBD.Text;
         form_Dados.Conexao.Login    :=  edt_Login.Text;
         form_Dados.Conexao.Senha    :=  edt_Senha.Text;
         form_Dados.Conexao.Porta    :=  edt_Porta.Text;
         form_Dados.Conexao.Drive    :=  cbx_DefineBD.Text;
         form_Dados.Conexao.Id_Drive :=  cbx_DefineBD.ItemIndex;
//         if cbx_Mysql.checked = true then
//              form_Dados.Conexao.Drive := 'MySQL'
//            else
//              form_Dados.Conexao.Drive := 'FB';

         form_dados.Conexao.prc_GravarArquivoINI;

        if form_dados.Conexao.fnc_conectar_banco_dados then
          begin
            frc_criar_msg('CONEX�O AO BANCO DE DADOS',
                'CONECTADO AO BANCO DE DADOS',
                'Conex�o com o Banco de Dados, Realizado com SUCESSO ' +
                ' O Sistema deve ser Reiniciado! ',
                ExtractFilePath(Application.ExeName) +'\icones\Conectado_database_icon.bmp',
                'OK');
            Application.Terminate;
          end
        else
          begin
            frc_criar_msg('CONEX�O AO BANCO DE DADOS',
                'ERRO AO TENTAR CONECTAR BANCO DE DADOS',
                'N�o foi poss�vel conectar ao banco de dados, poss�veis causas: ' +
                form_Dados.Conexao.MsgErro ,
                ExtractFilePath(Application.ExeName) +'\icones\falha_database_icon.bmp',
                'OK');
            edt_NomeBD.SetFocus;
          end;
       end
     else
        begin
           frc_criar_msg('CONEX�O AO BANCO DE DADOS',
                'ERRO AO PREENCHER OS DADOS',
                'N�o foi poss�vel conectar ao banco de dados, poss�veis causas: ' +
                'Todos os campos devem ser preenchidos!!',
                ExtractFilePath(Application.ExeName) +'\icones\falha_database_icon.bmp',
                'OK');
        end;

end;

{
procedure Tform_Login.cbx_FirebirdClick(Sender: TObject);
begin
  if cbx_Firebird.checked = true then
     cbx_Mysql.Enabled := false
  else
     cbx_Mysql.Enabled := true;
end;

procedure Tform_Login.cbx_MysqlClick(Sender: TObject);
begin
  if cbx_Mysql.checked = true then
     cbx_Firebird.Enabled := false
  else
     cbx_Firebird.Enabled := true;
end;
}
procedure Tform_Login.btn_CancelaClick(Sender: TObject);
begin
         close;
end;



procedure Tform_Login.FormShow(Sender: TObject);
begin
       if form_dados.Conexao.fnc_LerArquivoINI then
       begin
         edt_NomeServidorAtual.Text    :=  form_Dados.Conexao.Servidor;
         edt_NomeBDAtual.Text          :=  form_Dados.Conexao.Base;
         edt_LoginAtual.Text           :=  form_Dados.Conexao.Login;
         edt_SenhaAtual.Text           :=  form_Dados.Conexao.Senha;
         edt_PortaAtual.Text           :=  form_Dados.Conexao.Porta;
         cbx_BaseDadosAtual.ItemIndex  :=  form_Dados.Conexao.Id_Drive;
         {
          if form_Dados.Conexao.Drive <> '' then
            if  form_Dados.Conexao.Drive = 'MySQL'then
              cbx_MysqlAtual.checked := true
            else
              cbx_FirebirdAtual.checked := true;
          }
       end;

end;

end.
