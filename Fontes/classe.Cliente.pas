unit classe.Cliente;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms;

Type
	TCliente = Class
	private
    Fid_cliente       : integer;
    Fstr_nomecliente  : string;
    Fdt_nascimento    : TDATEtime;
    Fdt_alterado      : TDATEtime;
    Fstr_cpf          : string;
    Fdt_cadastro      : TDATEtime;
    Fstr_endereco     : string;
    Fstr_num          : string;
    Fstr_complemento  : string;
    Fstr_bairro       : string;
    Fstr_cidade       : string;
    Fstr_uf           : string;
    Fstr_telefone     : string;
    Fstr_obs          : string;
    FConexao          : TFDConnection;
    Fstr_cep          : string;
	public
		constructor Create ( Conexao : TFdConnection );
    Destructor  Destroy ; Override;

    function fnc_InserirAlterar (tipoOperacao: string; out Erro: string): boolean;
    procedure prc_Deleta (id_Chave: integer);
    function fnc_Cosulta (texto: string): TFDQuery;

    property id_cliente       : integer       Read Fid_cliente        Write Fid_cliente;
    property str_nomecliente  : string        Read Fstr_nomecliente   Write Fstr_nomecliente;
    property dt_nascimento    : TDATEtime     Read Fdt_nascimento     Write Fdt_nascimento;
    property dt_alterado      : TDATEtime     Read Fdt_alterado       Write Fdt_alterado;
    property str_cpf          : string        Read Fstr_cpf           Write Fstr_cpf;
    property dt_cadastro      : TDATEtime     Read Fdt_cadastro       Write Fdt_cadastro;
    property str_endereco     : string        Read Fstr_endereco      Write Fstr_endereco;
    property str_num          : string        Read Fstr_num           Write Fstr_num;
    property str_complemento  : string        Read Fstr_complemento   Write Fstr_complemento;
    property str_bairro       : string        Read Fstr_bairro        Write Fstr_bairro;
    property str_cidade       : string        Read Fstr_cidade        Write Fstr_cidade;
    property str_uf           : string        Read Fstr_uf            Write Fstr_uf;
    property str_telefone     : string        Read Fstr_telefone      Write Fstr_telefone;
    property str_cep          : string        Read Fstr_cep           Write Fstr_cep;
    property str_obs          : string        Read Fstr_obs           Write Fstr_obs;
    property Conexao          : TFDConnection Read FConexao           Write FConexao;

  End;


var
	  QryConsulta : TFDQuery;

implementation

uses
    unit_Funcoes;
{ TCliente }

constructor TCliente.Create(Conexao: TFdConnection);
begin
  FConexao := Conexao;
  	QryConsulta := TFDQuery.Create( nil );
	  QryConsulta.Connection := FConexao;
end;

destructor TCliente.Destroy;
begin
  QryConsulta.Destroy;
  FConexao.Connected := False;

  inherited;
end;



function TCliente.fnc_Cosulta( texto: string): TFDQuery;

begin
  try
	  FConexao.Connected := False;
	  FConexao.Connected := True;

	  QryConsulta.Close;
	  QryConsulta.SQL.Clear;
    QryConsulta.SQL.Add('Select id_cliente, str_nome, str_cpf, str_telefone,dt_nascimento,');
    QryConsulta.SQL.Add('dt_cadastro, dt_alterado, str_endereco, str_num, str_cep, str_complemento,');
    QryConsulta.SQL.Add('str_bairro, str_cidade, str_uf, str_obs');
    QryConsulta.SQL.Add('from tb_clientes where  (str_cpf like  :p_Texto  or ');
    QryConsulta.SQL.Add('                        str_nome like  :p_Texto )');

    QryConsulta.ParamByName('p_Texto').AsString := '%' + texto + '%';
    QryConsulta.SQL.SaveToFile(ExtractFilePath (Application.ExeName) +'\SqlGerados\ConsultaCliente.txt');

    QryConsulta.Open
  finally
    result :=  QryConsulta;
  end;

end;


function TCliente.fnc_InserirAlterar(tipoOperacao: string;
  out Erro: string): boolean;
  var
	    QryInsert : TFDQuery;
      tipoQry   : string;
begin
    try
      try
    	  FConexao.Connected := False;
	      FConexao.Connected := True;

        QryInsert := TFDQuery.Create( nil );
	      QryInsert.Connection := FConexao;

        QryInsert.Close;
	      QryInsert.SQL.Clear;

        if tipoOperacao = 'Salvar' then
          begin

            QryInsert.SQL.Add('Insert into tb_clientes ( str_nome, str_cpf, str_telefone,dt_nascimento,');
            QryInsert.SQL.Add('dt_cadastro, dt_alterado, str_endereco, str_num, str_cep, str_complemento,');
            QryInsert.SQL.Add('str_bairro, str_cidade, str_uf, str_obs)');
            QryInsert.SQL.Add('values( :p_str_nome, :p_str_cpf, :p_str_telefone, :p_dt_nascimento, ');
            QryInsert.SQL.Add(':p_dt_cadastro, :p_dt_alterado, :p_str_endereco, :p_str_num, :p_str_cep,');
            QryInsert.SQL.Add(' :p_str_complemento, :p_str_bairro, :p_str_cidade, :p_str_uf, :p_str_obs);');

            QryInsert.ParamByName('p_dt_cadastro').AsDateTime     := Fdt_cadastro;

             tipoQry := 'InsertCliente';
          end
        else
          begin

            QryInsert.SQL.Add('Update tb_clientes set            ');
            QryInsert.SQL.Add('str_nome         = :p_str_nome,      ');
            QryInsert.SQL.Add('str_cpf          = :p_str_cpf,    ');
            QryInsert.SQL.Add('str_telefone     = :p_str_telefone,               ');
            QryInsert.SQL.Add('dt_nascimento    = :p_dt_nascimento,               ');
         //   QryInsert.SQL.Add('dt_cadastro      = :p_dt_cadastro,          ');
            QryInsert.SQL.Add('dt_alterado      = :p_dt_alterado,            ');
            QryInsert.SQL.Add('str_endereco     = :p_str_endereco,                ');
            QryInsert.SQL.Add('str_num          = :p_str_num,                ');
            QryInsert.SQL.Add('str_complemento  = :p_str_complemento,                ');
            QryInsert.SQL.Add('str_cep          = :p_str_cep,                ');
            QryInsert.SQL.Add('str_bairro       = :p_str_bairro,                ');
            QryInsert.SQL.Add('str_cidade       = :p_str_cidade,                ');
            QryInsert.SQL.Add('str_uf           = :p_str_uf,                ');
            QryInsert.SQL.Add('str_obs          = :p_str_obs                ');
            QryInsert.SQL.Add('where id_cliente = :p_id_cliente              ');


        QryInsert.ParamByName('p_id_cliente').AsInteger := Fid_cliente;
        tipoQry := 'UpdateCliente';

        end;

        QryInsert.ParamByName('p_str_nome').AsString          := Fstr_nomecliente;
        QryInsert.ParamByName('p_str_cpf').AsString           := Fstr_cpf;
        QryInsert.ParamByName('p_str_telefone').AsString      := Fstr_telefone;
        QryInsert.ParamByName('p_dt_nascimento').AsDate       := Fdt_nascimento;
        QryInsert.ParamByName('p_dt_alterado').AsDateTime     := Fdt_alterado;
        QryInsert.ParamByName('p_str_endereco').AsString      := Fstr_endereco;
        QryInsert.ParamByName('p_str_num').AsString           := Fstr_num;
        QryInsert.ParamByName('p_str_complemento').AsString   := Fstr_complemento;
        QryInsert.ParamByName('p_str_cep').AsString           := Fstr_cep;
        QryInsert.ParamByName('p_str_bairro').AsString        := Fstr_bairro;
        QryInsert.ParamByName('p_str_cidade').AsString        := Fstr_cidade;
        QryInsert.ParamByName('p_str_uf').AsString            := Fstr_uf;
        QryInsert.ParamByName('p_str_obs').AsString           := Fstr_obs;

        QryInsert.SQL.SaveToFile(ExtractFilePath (Application.ExeName) +'\SqlGerados\'+tipoQry+'.txt');

        QryInsert.ExecSQL;
        result := true;
      except
         on e: Exception do
          begin
	          Erro   := e.Message;
	          Result := false;
          end;

      end;
    finally
        QryInsert.Destroy;
    end;
end;


procedure TCliente.prc_Deleta(id_Chave: integer);
begin

      if frc_criar_msg('Confirmação', 'Excluir Dados',
			                  'Tem Certeza que deseja EXCLUIR esse CLIENTE? ' +
                        'Todos os Dados Financeiros vinculados as esse CLIENTE seram Excluidos junto!',
			ExtractFilePath (Application.ExeName) +'\icones\Alerta_Atencao_128.bmp',
      'CONFIRMAR') then
      begin

        FConexao.Connected := False;
        FConexao.Connected := True;
         Fconexao.ExecSQL('Delete from tb_operacao_financeira  where cli_id_cliente = :id_chave',
                                                                                          [id_Chave]);
        Fconexao.ExecSQL('Delete from tb_clientes where id_cliente = :id_chave', [id_Chave]);
      end;
end;

end.
