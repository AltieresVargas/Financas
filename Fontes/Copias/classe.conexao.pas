unit classe.conexao;

interface

uses
  FireDAC.Comp.Client, FireDAC.Stan.Intf, System.IniFiles, System.SysUtils,
  unit_Funcoes;
type
Tconexao = class
	private
    FServidor: String;
    FMsgErro: String;
    FSenha: String;
    FBase: String;
    FLogin: String;
    FPorta: String;
    FDrive: String;
    FId_Drive : Integer;
    FConexao: TFDConnection;
	public

	  constructor Create ( NomeConexao : TFDConnection );
	  destructor Destroy; override;
	  function fnc_conectar_banco_dados: boolean;
    procedure prc_GravarArquivoINI;
    function fnc_LerArquivoINI: boolean;

	   property Conexao  : TFDConnection Read FConexao Write FConexao;
	   property Servidor : String  Read FServidor  Write FServidor;
	   property Base     : String  Read FBase      Write FBase;
	   property Login    : String  Read FLogin     Write FLogin;
	   property Senha    : String  Read FSenha     Write FSenha;
	   property Porta    : String  Read FPorta     Write FPorta;
	   property Drive    : String  Read FDrive     Write FDrive;
	   property Id_Drive : Integer Read FId_Drive  Write FId_Drive;
	   property MsgErro  : String  Read FMsgErro   Write FMsgErro;

end;
implementation

uses
  Vcl.Forms;

{ Tconexao }

constructor Tconexao.Create(NomeConexao: TFDConnection);
begin
  FConexao := NomeConexao;
end;

destructor Tconexao.Destroy;
begin
  FConexao.Connected := False;
  inherited;
end;

function Tconexao.fnc_conectar_banco_dados: boolean;
begin
      result := True;
  FConexao.Params.Clear;

  if not fnc_LerArquivoINI then
  begin
     result := false;
     FMsgErro :=  'O Arquivo de Configura��o n�o foi Encontrado!';
  end
  else
  begin

      FConexao.Params.Add('Server'      + FServidor);
      FConexao.Params.Add('user_name='  + FLogin);
      FConexao.Params.Add('password='   + FSenha);
      FConexao.Params.Add('port='       + FPorta);
      FConexao.Params.Add('Database='   + FBase);
      FConexao.Params.Add('DriverID='   + FDrive);
//      FConexao.Params.Add('DriverID='   + 'MySQL');

      Try
	      FConexao.Connected := True;
      Except
	      on e:Exception do
	      begin
          FMsgErro := e.Message;
	  	    Result:= False;
      	end;
      end;
  End;
end;



procedure Tconexao.prc_GravarArquivoINI;
var
	str_IniFile : String;
	str_Senha : String;
	Ini	: TiniFile;
begin

  str_IniFile := ChangeFileExt (Application.Exename, '.ini');
  Ini         := TIniFile.Create(str_Inifile);

  Try
		ini.WriteString('Configuracao','Servidor',FServidor );
		ini.WriteString('Configuracao','Base',FBase);
		ini.WriteString('Configuracao','Porta',FPorta);
		ini.WriteInteger('Configuracao','Id_Drive',FId_Drive);
		ini.WriteString('Configuracao','Base_Dados',FDrive);
		ini.WriteString('Acesso','Login',FLogin);
    str_Senha :=     fnc_Criptografia( FSenha, 'DataCempro9876');
		ini.WriteString('Acesso','Senha',str_Senha);
  Finally
	    Ini.Free;
  end;

end;

function Tconexao.fnc_LerArquivoINI : boolean;
var
	str_IniFile : String;
	Ini	: TiniFile;
begin

  str_IniFile := ChangeFileExt (Application.Exename, '.ini');
  Ini         := TIniFile.Create(str_Inifile);

  if not FileExists (str_IniFile) then
	  Result := false
  else
    begin
      Try

	       FServidor  := ini.ReadString('Configuracao','Servidor','' );
	       FBase      := ini.ReadString('Configuracao','Base','');
	       FPorta     := ini.ReadString('Configuracao','Porta','');
	       FId_Drive  := ini.ReadInteger('Configuracao','Id_Drive',-1);
	       FDrive     := ini.ReadString('Configuracao','Base_Dados','');
      	 FLogin     := ini.ReadString('Acesso','Login','');
	       FSenha     := ini.ReadString('Acesso','Senha','');
         FSenha     := fnc_Criptografia( FSenha, 'DataCempro9876');
      Finally
          result := true;
	        Ini.Free;
      end;
     end;

end;

end.
