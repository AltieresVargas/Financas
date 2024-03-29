program Financas;

uses
  Vcl.Forms,
  unit_Principal in 'unit_Principal.pas' {form_principal},
  unit_Dados in 'unit_Dados.pas' {form_Dados: TDataModule},
  unit_CadCliente in 'unit_CadCliente.pas' {form_CadCliente},
  unit_Funcoes in 'unit_Funcoes.pas',
  classe.conexao in 'classe.conexao.pas',
  unit_Menssagens in 'unit_Menssagens.pas' {form_Menssagens},
  System.SysUtils {form_Menssagens},
  classe.Cliente in 'classe.Cliente.pas',
  classe.RegistroFinancas in 'classe.RegistroFinancas.pas',
  unit_ConfigServidor in 'unit_ConfigServidor.pas' {form_ConfigServidor};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(Tform_Dados, form_Dados);

 if form_dados.Conexao.fnc_conectar_banco_dados then
    begin
      Application.CreateForm(Tform_principal, form_principal);
      Application.CreateForm(Tform_CadCliente, form_CadCliente);
      Application.Run;
   end
 else
   begin
           frc_criar_msg('CONEX�O AO BANCO DE DADOS',
                'ERRO AO TENTAR CONECTAR BANCO DE DADOS',
                'N�o foi poss�vel conectar ao banco de dados, poss�veis causas: ' +
                form_Dados.Conexao.MsgErro ,
                ExtractFilePath(Application.ExeName) +'\icones\db_error_icon_128.bmp',
                'OK');

           Application.CreateForm(Tform_Login, form_Login);
           form_Login.ShowModal;

   end;

end.
