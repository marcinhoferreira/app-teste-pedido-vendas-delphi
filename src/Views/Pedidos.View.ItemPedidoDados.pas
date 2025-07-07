unit Pedidos.View.ItemPedidoDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls,
  Vcl.Mask, Vcl.DBCtrls,
  Pedidos.Classe.ItemPedido;

type
  TframeItemPedidoDados = class(TFrame)
    lblItemPedidoDados: TLabel;
    panItemPedidoDados: TPanel;
    lblProdutoCodigo: TLabel;
    edtProdutoCodigo: TEdit;
    lblProdutoDescricao: TLabel;
    lblProdutoQuantidade: TLabel;
    edtProdutoQuantidade: TEdit;
    edtProdutoValorUnitario: TEdit;
    lblProdutoValorUnitario: TLabel;
    edtProdutoDescricao: TEdit;
    btnConfirmar: TButton;
    procedure edtProdutoCodigoKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutoValorUnitarioKeyPress(Sender: TObject; var Key: Char);
    procedure edtProdutoCodigoChange(Sender: TObject);
    procedure edtProdutoCodigoEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inicializa(const ItemPedido: TItemPedido);
    procedure ExibeControles;
    procedure OcultaControles;
    procedure SetProdutoDescricao(const Value: String);
    procedure SetProdutoQuantidade(const Value: Integer);
    procedure SetProdutoValorUnitario(const Value: Double);
  end;

implementation


{$R *.dfm}


{ TframeItemPedidoDados }

procedure TframeItemPedidoDados.edtProdutoCodigoChange(Sender: TObject);
begin
   if TEdit(Sender).Text = '' then
      OcultaControles;
end;

procedure TframeItemPedidoDados.edtProdutoCodigoEnter(Sender: TObject);
begin
   TEdit(Sender).Text := '';
end;

procedure TframeItemPedidoDados.edtProdutoCodigoKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not CharInSet(Key, ['0'..'9', #8]) then
      Key := #0;
   if Key = #13 then
      Key := #9;
end;

procedure TframeItemPedidoDados.edtProdutoValorUnitarioKeyPress(Sender: TObject;
  var Key: Char);
begin
   if not CharInSet(Key, ['0'..'9', ',', #8]) then
      Key := #0;
   if (Key = ',') and (Pos(',', TEdit(Sender).Text) > 0) then
      Key := #0;
   if Key = #13 then
      Key := #9;
end;

procedure TframeItemPedidoDados.ExibeControles;
begin
   lblProdutoDescricao.Visible := True;
   edtProdutoDescricao.Visible := True;
   lblProdutoQuantidade.Visible := True;
   edtProdutoQuantidade.Visible := True;
   lblProdutoValorUnitario.Visible := True;
   edtProdutoValorUnitario.Visible := True;
   btnConfirmar.Visible := True;
end;

procedure TframeItemPedidoDados.Inicializa(const ItemPedido: TItemPedido);
begin
   edtProdutoCodigo.Text := '';
   edtProdutoDescricao.Text := '';
   edtProdutoQuantidade.Text := '1';
   edtProdutoValorUnitario.Text := '0,00';
   btnConfirmar.Caption := 'Inserir';
   if not Assigned(ItemPedido) then
      OcultaControles
   else
      begin
         edtProdutoCodigo.Text := ItemPedido.Produto.Codigo.ToString;
         edtProdutoDescricao.Text := ItemPedido.Produto.Descricao;
         edtProdutoQuantidade.Text := ItemPedido.Quantidade.ToString;
         edtProdutoValorUnitario.Text := FloatToStr(ItemPedido.ValorUnitario);
         if ItemPedido.Id = -1 then
            btnConfirmar.Caption := 'Inserir'
         else
            btnConfirmar.Caption := 'Alterar';
         ExibeControles;
      end;
   edtProdutoCodigo.Enabled := btnConfirmar.Caption = 'Inserir';
end;

procedure TframeItemPedidoDados.OcultaControles;
begin
   lblProdutoDescricao.Visible := False;
   edtProdutoDescricao.Visible := False;
   lblProdutoQuantidade.Visible := False;
   edtProdutoQuantidade.Visible := False;
   lblProdutoValorUnitario.Visible := False;
   edtProdutoValorUnitario.Visible := False;
   btnConfirmar.Visible := False;
end;

procedure TframeItemPedidoDados.SetProdutoValorUnitario(const Value: Double);
begin
   edtProdutoValorUnitario.Text := Format('%.2f', [Value]);
end;

procedure TframeItemPedidoDados.SetProdutoDescricao(const Value: String);
begin
   edtProdutoDescricao.Text := Value;
end;

procedure TframeItemPedidoDados.SetProdutoQuantidade(const Value: Integer);
begin
   edtProdutoQuantidade.Text := Value.ToString;
end;

end.
