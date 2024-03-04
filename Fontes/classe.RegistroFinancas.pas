unit classe.RegistroFinancas;

interface

uses
  FireDAC.Comp.Client, System.SysUtils, Vcl.Forms;

  Type

	  TRegistroFinancas = Class

	private
    Fstr_obs: string;
    Fid_Operacao: integer;
    Ffl_valor: Currency;
    Ffl_Saldo: Currency;
    Fstr_descricao: string;
    Fstr_NumDoc: string;
    Fdt_Operacao: TDate;
    Fcli_id_cliente: integer;
    Fdt_cadastro: TDATEtime;
    FConexao: TFDConnection;
    Fstr_tipoOperacao: string;
    Fdt_alterado: TDATEtime;

  public
		constructor Create ( Conexao : TFdConnection );
    Destructor  Destroy ; Override;
    function fnc_InserirAlterar (sInsere: string; out Erro: string): boolean;
    procedure prc_Deleta_Item (id_Operacao, id_Cli: integer);
    procedure prc_UpdateOp( id_Cliente, id_Operacao: integer; fSaldo : Currency);
    function fnc_Cosulta (id_Cliente: integer): TFDQuery;
    function fnc_BuscaSaldoAnterior( id_Cliente, id_Operacao: integer): Currency;
    function fnc_BuscaSaldo( id_Cliente : integer): Currency;
    function fnc_CosultaPorPreiodo(dt_inicio,dt_fim : TDateTime; id_Cliente: integer): TFDQuery;

    property id_Operacao      : integer       Read Fid_Operacao       Write Fid_Operacao;
    property cli_id_cliente   : integer       Read Fcli_id_cliente    Write Fcli_id_cliente;
    property str_NumDoc       : string        Read Fstr_NumDoc        Write Fstr_NumDoc;
    property fl_valor         : Currency      Read Ffl_valor          Write Ffl_valor;
    property fl_Saldo         : Currency      Read Ffl_Saldo          Write Ffl_Saldo;
    property str_descricao    : string        Read Fstr_descricao     Write Fstr_descricao;
    property dt_Operacao      : TDate         Read Fdt_Operacao       Write Fdt_Operacao;
    property dt_alterado      : TDATEtime     Read Fdt_alterado       Write Fdt_alterado;
    property dt_cadastro      : TDATEtime     Read Fdt_cadastro       Write Fdt_cadastro;
    property str_obs          : string        Read Fstr_obs           Write Fstr_obs;
    property str_tipoOperacao : string        Read Fstr_tipoOperacao  Write Fstr_tipoOperacao;
    property Conexao          : TFDConnection Read FConexao           Write FConexao;


  End;

  var
	QryConsulta : TFDQuery;

implementation

uses
    unit_Funcoes;

{ TRegistroFinancas }

constructor TRegistroFinancas.Create(Conexao: TFdConnection);
begin
  FConexao := Conexao;
  QryConsulta := TFDQuery.Create( nil );
	QryConsulta.Connection := FConexao;

end;

destructor TRegistroFinancas.Destroy;
begin
  QryConsulta.Destroy;
  FConexao.Connected := False;
  inherited;
end;

function TRegistroFinancas.fnc_Cosulta( id_Cliente: integer): TFDQuery;

begin
  try
	  FConexao.Connected := False;
	  FConexao.Connected := True;

    QryConsulta.Close;
	  QryConsulta.SQL.Clear;
    QryConsulta.SQL.Add('Select id_operacao, cli_id_cliente, str_tipo_operacao, str_num_doc,');
    QryConsulta.SQL.Add(' fl_valor,fl_saldo, str_descricao, dt_operacao, dt_alterado, dt_cadastro, str_obs');
    QryConsulta.SQL.Add('from tb_operacao_financeira  ');
    QryConsulta.SQL.Add('where  cli_id_cliente = :p_Texto order by id_operacao desc');

    QryConsulta.ParamByName('p_Texto').AsInteger := id_Cliente;

    QryConsulta.SQL.SaveToFile(ExtractFilePath (Application.ExeName) +
                                        '\SqlGerados\ConsultaFinanca.txt');

    QryConsulta.Open
  finally
    result :=  QryConsulta;
  end;
end;

function TRegistroFinancas.fnc_CosultaPorPreiodo(dt_inicio, dt_fim: TDateTime;
  id_Cliente: integer): TFDQuery;
begin
  try
	  FConexao.Connected := False;
	  FConexao.Connected := True;

    QryConsulta.Close;
	  QryConsulta.SQL.Clear;
    QryConsulta.SQL.Add('Select id_operacao, cli_id_cliente, str_tipo_operacao, str_num_doc,');
    QryConsulta.SQL.Add(' fl_valor, fl_saldo, str_descricao, dt_operacao, dt_alterado, dt_cadastro, str_obs ');
    QryConsulta.SQL.Add('from tb_operacao_financeira ');
    QryConsulta.SQL.Add('where  cli_id_cliente = :p_Texto and  ');
    QryConsulta.SQL.Add('dt_cadastro BETWEEN ('''+FormatDateTime('YYYY/MM/DD', dt_inicio)+''') ');
    QryConsulta.SQL.Add('AND ('''+FormatDateTime('YYYY/MM/DD', dt_fim)+''') ');
    QryConsulta.SQL.Add('order by id_operacao desc');

    QryConsulta.ParamByName('p_Texto').AsInteger  := id_Cliente;

    QryConsulta.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                    +'\SqlGerados\ConsultaPeriodoFinanca.txt');

    QryConsulta.Open
  finally
    result :=  QryConsulta;
  end;
end;

function TRegistroFinancas.fnc_BuscaSaldoAnterior( id_Cliente, id_Operacao: integer): Currency;
var
  bSaldo      : Boolean;
  TdMinimoID  : TFDQuery;
  fSaldo      : Currency;
  iIdMax      : Integer;
begin
  bSaldo := false;
  fSaldo := 0;
  try
      FConexao.Connected := False;
	    FConexao.Connected := True;

      TdMinimoID := TFDQuery.Create( nil );
	    TdMinimoID.Connection := FConexao;

      TdMinimoID.Close;
	    TdMinimoID.SQL.Clear;
      TdMinimoID.SQL.Text :=
     'SELECT MIN(id_operacao) AS crescente FROM tb_operacao_financeira '+
     'where  cli_id_cliente = '+ IntToStr(id_Cliente); //pega o ultimo
     TdMinimoID.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\MinIdOperacao.txt');
      TdMinimoID.Open;
      iIdMax  := TdMinimoID.fieldbyname('crescente').asinteger;
     if  iIdMax < id_Operacao   then
      begin

        while bSaldo = false do
          begin

          if iIdMax < id_Operacao then
            id_Operacao := id_Operacao  - 1;

          TdMinimoID.Close;
	  	 	  TdMinimoID.SQL.Clear;
          TdMinimoID.SQL.Add('Select fl_saldo ');
          TdMinimoID.SQL.Add('from tb_operacao_financeira  ');
          TdMinimoID.SQL.Add('where id_operacao = :p_id_Operacao and cli_id_cliente = :p_id_Cli ');

          TdMinimoID.ParamByName('p_id_Operacao').AsInteger := id_Operacao;
          TdMinimoID.ParamByName('p_id_Cli').AsInteger := id_Cliente;

          TdMinimoID.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\BuscaSaldoAnterior.txt');
          TdMinimoID.Open;
          if TdMinimoID.RecNo > 0 then
            begin
              fSaldo :=  TdMinimoID.fieldbyname('fl_saldo').AsCurrency;
              bSaldo := true;
            end;
        end;
      end;
  finally
    TdMinimoID.Close;
    TdMinimoID.Destroy;
    result :=  fSaldo;
  end;
end;

function TRegistroFinancas.fnc_BuscaSaldo( id_Cliente : integer): Currency;
var
  TdMaxID     : TFDQuery;
  fSaldo      : Currency;
  iIdMax      : Integer;
begin
  fSaldo := 0;
  try
      FConexao.Connected := False;
	    FConexao.Connected := True;

      TdMaxID := TFDQuery.Create( nil );
	    TdMaxID.Connection := FConexao;

      TdMaxID.Close;
	    TdMaxID.SQL.Clear;
      TdMaxID.SQL.Text :=
     'SELECT Max(id_operacao) AS maxID FROM tb_operacao_financeira '+
     'where  cli_id_cliente = '+ IntToStr(id_Cliente);
     TdMaxID.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\MaxIdOperacao.txt');
      TdMaxID.Open;
      iIdMax  := TdMaxID.fieldbyname('maxID').asinteger;

          TdMaxID.Close;
	  	 	  TdMaxID.SQL.Clear;
          TdMaxID.SQL.Add('Select fl_saldo ');
          TdMaxID.SQL.Add('from tb_operacao_financeira  ');
          TdMaxID.SQL.Add('where id_operacao = :p_id_Operacao and cli_id_cliente = :p_id_Cli ');

          TdMaxID.ParamByName('p_id_Operacao').AsInteger := iIdMax;
          TdMaxID.ParamByName('p_id_Cli').AsInteger := id_Cliente;

          TdMaxID.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\BuscaMaxSaldo.txt');
          TdMaxID.Open;
              fSaldo :=  TdMaxID.fieldbyname('fl_saldo').AsCurrency;

  finally
    TdMaxID.Close;
    TdMaxID.Destroy;
    result :=  fSaldo;
  end;
end;

procedure  TRegistroFinancas.prc_UpdateOp( id_Cliente, id_Operacao: integer; fSaldo : Currency);
var
  qryQuery, qryUpdate      : TFDQuery;
begin
  try
      FConexao.Connected := False;
	    FConexao.Connected := True;

      qryQuery := TFDQuery.Create( nil );
	    qryQuery.Connection := FConexao;
      qryUpdate := TFDQuery.Create( nil );
	    qryUpdate.Connection := FConexao;

      qryQuery.Close;
	    qryQuery.SQL.Clear;
      qryQuery.SQL.Text :=
        'SELECT id_operacao, str_tipo_operacao, fl_valor FROM tb_operacao_financeira '+
          'where id_operacao > '+ IntToStr(id_Operacao) +
          ' and cli_id_cliente = '+ IntToStr(id_Cliente); //pega o ultimo
      qryQuery.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\ConsultaOoSaldo.txt');
      qryQuery.Open;
      qryQuery.First;
        While not (qryQuery.Eof) do
          begin
            if qryQuery.fieldbyname('str_tipo_operacao').AsString  = 'ENTRADA' then
              begin
                 fSaldo :=  ( fSaldo ) + ( qryQuery.fieldbyname('fl_valor').AsCurrency )
              end
            else
              begin
                 fSaldo :=  ( fSaldo ) - ( qryQuery.fieldbyname('fl_valor').AsCurrency  )
              end;

            qryUpdate.Close;
            qryUpdate.SQL.Clear;
            qryUpdate.SQL.Add('Update tb_operacao_financeira set    ');
            qryUpdate.SQL.Add('fl_saldo             = :p_fl_saldo            ');
            qryUpdate.SQL.Add('where cli_id_cliente = :p_id_Cli              ');
            qryUpdate.SQL.Add(' and id_operacao     = :p_id_operacao         ');

            qryUpdate.ParamByName('p_fl_saldo').AsCurrency    := fSaldo;
            qryUpdate.ParamByName('p_id_Cli').AsInteger       := id_Cliente;
            qryUpdate.ParamByName('p_id_Operacao').AsInteger  := qryQuery.fieldbyname('id_operacao').AsInteger;

            qryUpdate.SQL.SaveToFile(ExtractFilePath (Application.ExeName)
                                                         +'\SqlGerados\UpDateOpSaldo.txt');
            qryUpdate.ExecSQL;
            qryQuery.Next;
          end;

  finally
    qryUpdate.Close;
    qryUpdate.Destroy;
    qryQuery.Close;
    qryQuery.Destroy;
  end;
end;

function TRegistroFinancas.fnc_InserirAlterar( sInsere : string;
  out Erro: string): boolean;
  var
	    QryInsert : TFDQuery;
      sTipoQry   : string;
      fSaldoAntes : Currency;
begin
    try
      try
    	  FConexao.Connected := False;
	      FConexao.Connected := True;

        QryInsert := TFDQuery.Create( nil );
	      QryInsert.Connection := FConexao;

        QryInsert.Close;
	      QryInsert.SQL.Clear;

        if sInsere = 'Incluir' then
          begin
            QryInsert.SQL.Add('Insert into tb_operacao_financeira (cli_id_cliente, str_tipo_operacao,');
            QryInsert.SQL.Add(' str_num_doc, fl_valor,fl_saldo, str_descricao, dt_operacao,');
            QryInsert.SQL.Add(' dt_alterado, dt_cadastro, str_obs)');
            QryInsert.SQL.Add('values(:p_cli_id_cliente, :p_str_tipo_operacao, :p_str_num_doc,');
            QryInsert.SQL.Add(' :p_fl_valor, :p_fl_saldo, :p_str_descricao, :p_dt_operacao, ');
            QryInsert.SQL.Add(':p_dt_alterado, :p_dt_cadastro, :p_str_obs)');

            QryInsert.ParamByName('p_cli_id_cliente').AsInteger   := Fcli_id_cliente;
            QryInsert.ParamByName('p_dt_cadastro').AsDateTime     := Fdt_cadastro;
            QryInsert.ParamByName('p_fl_valor').AsCurrency        := Ffl_valor;
            QryInsert.ParamByName('p_fl_saldo').AsCurrency        := Ffl_Saldo;
             sTipoQry := 'InsertCliente';
          end
        else
          begin
            QryInsert.SQL.Add('Update tb_operacao_financeira set             ');
            QryInsert.SQL.Add('str_tipo_operacao   = :p_str_tipo_operacao,   ');
            QryInsert.SQL.Add('str_num_doc         = :p_str_num_doc,         ');
            QryInsert.SQL.Add('fl_valor            = :p_fl_valor,            ');
            QryInsert.SQL.Add('fl_saldo            = :p_fl_saldo,            ');
            QryInsert.SQL.Add('str_descricao       = :p_str_descricao,       ');
            QryInsert.SQL.Add('dt_operacao         = :p_dt_operacao,         ');
            QryInsert.SQL.Add('dt_alterado         = :p_dt_alterado,         ');
            QryInsert.SQL.Add('str_obs             = :p_str_obs              ');
            QryInsert.SQL.Add('where id_operacao   = :p_id_operacao          ');

            fSaldoAntes := fnc_BuscaSaldoAnterior(Fcli_id_cliente,Fid_Operacao);
            if (fSaldoAntes > 0) or (fSaldoAntes < 0) then
              begin
                if Fstr_tipoOperacao = 'ENTRADA' then
                     Ffl_Saldo :=  ( fSaldoAntes ) + ( Ffl_valor )
                else
                     Ffl_Saldo :=  ( fSaldoAntes ) - ( Ffl_valor )
              end
            else
               Ffl_Saldo   := Ffl_valor;

            QryInsert.ParamByName('p_fl_valor').AsCurrency           := Ffl_valor;
            QryInsert.ParamByName('p_fl_saldo').AsCurrency           := Ffl_Saldo;

            QryInsert.ParamByName('p_id_operacao').AsInteger := Fid_Operacao;
            sTipoQry := 'UpdateCliente';
          end;


        QryInsert.ParamByName('p_str_tipo_operacao').AsString := Fstr_tipoOperacao;
        QryInsert.ParamByName('p_str_num_doc').AsString       := Fstr_NumDoc;
        QryInsert.ParamByName('p_str_descricao').AsString     := Fstr_descricao;
        QryInsert.ParamByName('p_dt_operacao').AsDate         := Fdt_Operacao;
        QryInsert.ParamByName('p_dt_alterado').AsDate         := Fdt_alterado;
        QryInsert.ParamByName('p_str_obs').AsString           := Fstr_obs;

        QryInsert.SQL.SaveToFile(ExtractFilePath (Application.ExeName) +'\SqlGerados\'+sTipoQry+'.txt');

        QryInsert.ExecSQL;
        if sTipoQry = 'UpdateCliente' then
         prc_UpdateOp( Fcli_id_cliente, Fid_Operacao, Ffl_Saldo);
        result := true;
      except
         on e: Exception do
          begin
	          Erro   := e.Message;
	          Result := false;
          end;

      end;
    finally
        QryInsert.Close;
        QryInsert.Destroy;
    end;
end;

procedure TRegistroFinancas.prc_Deleta_Item(id_Operacao, id_Cli: integer);
var
  fSaldo : Currency;

begin
       if frc_criar_msg('Confirmação', 'Excluir Dados',
			                  'Tem Certeza que deseja EXCLUIR esse Registro? ',
			ExtractFilePath (Application.ExeName) +'\icones\Alerta_Atencao_128.bmp',
      'CONFIRMAR') then
      begin
        fSaldo := fnc_BuscaSaldoAnterior(id_Cli, id_Operacao);
        prc_UpdateOp( id_Cli, id_Operacao, fSaldo);
        FConexao.Connected := False;
        FConexao.Connected := True;

        Fconexao.ExecSQL('Delete from tb_operacao_financeira  where id_operacao  = :p_id_Operacao', [id_Operacao]);

      end;
end;

end.
