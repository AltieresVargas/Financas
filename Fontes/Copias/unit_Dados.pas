unit unit_Dados;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf, FireDAC.Stan.Def,
  FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys, FireDAC.Phys.MySQL,
  FireDAC.Phys.MySQLDef, FireDAC.VCLUI.Wait, FireDAC.Comp.UI, Data.DB,
  FireDAC.Comp.Client, classe.conexao, classe.RegistroFinancas, classe.Cliente,
  FireDAC.Phys.FBDef, FireDAC.Phys.IBBase, FireDAC.Phys.FB, FireDAC.Phys.PGDef,
  FireDAC.Phys.PG;

type
  Tform_dados = class(TDataModule)
    FDConnection: TFDConnection;
    FDPhysMySQLDriverLink: TFDPhysMySQLDriverLink;
    FDGUIxWaitCursor: TFDGUIxWaitCursor;
    FD_FBDriver: TFDPhysFBDriverLink;
    PostgDriver: TFDPhysPgDriverLink;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private

    { Private declarations }
  public
    Conexao : Tconexao;
    RegistroFinancas : TRegistroFinancas;
    Cliente : TCliente;
    { Public declarations }
  end;

var
  form_dados: Tform_dados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure Tform_dados.DataModuleCreate(Sender: TObject);
begin
	  Conexao := Tconexao.Create(FDConnection);
end;

procedure Tform_dados.DataModuleDestroy(Sender: TObject);
begin
    Conexao.Destroy;
end;

end.
