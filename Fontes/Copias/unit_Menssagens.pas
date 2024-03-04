unit unit_Menssagens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Buttons;

type
  Tform_Menssagens = class(TForm)
    pnl_fundo: TPanel;
    shp_Fundo: TShape;
    pnl_Linha: TPanel;
    lb_TituloJanela: TLabel;
    img_Imagem: TImage;
    lb_TituloMsg: TLabel;
    lb_Msg: TLabel;
    pnl_Botoes: TPanel;
    pnl_Nao: TPanel;
    btn_Nao: TSpeedButton;
    pnl_Sim: TPanel;
    btn_Sim: TSpeedButton;
    procedure btn_NaoClick(Sender: TObject);
    procedure btn_SimClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    bRespostaMSG    : Boolean;
    sTituloJanela   : string;
    sTituloMsg      : string;
    sMsg            : string;
    sCaminhoImg, sTipo     : string;
  end;

var
  form_Menssagens: Tform_Menssagens;

implementation

{$R *.dfm}

procedure Tform_Menssagens.btn_NaoClick(Sender: TObject);
begin

  bRespostaMSG := False;
  close;
end;

procedure Tform_Menssagens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
end;

procedure Tform_Menssagens.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = vk_return then
    btn_SimClick(self)
  else
    if key = vk_escape then
    btn_NaoClick(self);
end;

procedure Tform_Menssagens.FormShow(Sender: TObject);
begin

  bRespostaMSG := False;

  lb_TituloJanela.Caption   := sTituloJanela;
  lb_TituloMsg.Caption      := sTituloMsg;
  lb_Msg.Caption            := sMsg;
  img_Imagem.Picture.LoadFromFile(sCaminhoImg);

  if sTipo = 'OK' then
begin
  pnl_nao.Visible := False;
  btn_sim.Caption := 'OK (ENTER)';
end;
end;

procedure Tform_Menssagens.btn_SimClick(Sender: TObject);
begin

  bRespostaMSG := True;
  close;
end;

end.
