unit Pedidos.Classe.ItemPedido;

interface

uses
   SysUtils, Classes, Data.DB,
   Pedidos.Classe.Produto;

type
   TItemPedido = class(TObject)
   private
      { Private declarations }
      fId: Integer;
      fProduto: TProduto;
      fQuantidade: Integer;
      fValorUnitario: Double;
      function GetId: Integer;
      function GetProduto: TProduto;
      function GetQuantidade: Integer;
      function GetValorUnitario: Double;
      procedure SetId(const Value: Integer);
      procedure SetProduto(const Value: TProduto);
      procedure SetQuantidade(const Value: Integer);
      procedure SetValorUnitario(const Value: Double);
      function GetValorTotal: Double;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      property Id: Integer Read GetId Write SetId;
      property Produto: TProduto Read GetProduto Write SetProduto;
      property Quantidade: Integer Read GetQuantidade Write SetQuantidade;
      property ValorUnitario: Double Read GetValorUnitario Write SetValorUnitario;
      property ValorTotal: Double Read GetValorTotal;
   end;

   TItemPedidoHelper = class helper for TItemPedido
   private
      { Private declarations }
   protected
      { Protected declarations }
   public
      { Public declarations }
      class function FromItemPedido(const AItemPedido: TItemPedido): TItemPedido;
   end;

implementation

{ TItemPedido }

constructor TItemPedido.Create;
begin
   fProduto := TProduto.Create;
end;

destructor TItemPedido.Destroy;
begin
   FreeAndNil(fProduto);
  inherited;
end;

function TItemPedido.GetId: Integer;
begin
   Result := fId;
end;

function TItemPedido.GetProduto: TProduto;
begin
   Result := fProduto;
end;

function TItemPedido.GetQuantidade: Integer;
begin
   Result := fQuantidade;
end;

function TItemPedido.GetValorTotal: Double;
begin
   Result := fValorUnitario * fQuantidade;
end;

function TItemPedido.GetValorUnitario: Double;
begin
   Result := fValorUnitario;
end;

procedure TItemPedido.SetId(const Value: Integer);
begin
   if Value <> fId then
      fId := Value;
end;

procedure TItemPedido.SetProduto(const Value: TProduto);
begin
   fProduto := Value;
end;

procedure TItemPedido.SetQuantidade(const Value: Integer);
begin
   if Value <> fQuantidade then
      fQuantidade := Value;
end;

procedure TItemPedido.SetValorUnitario(const Value: Double);
begin
   if Value <> fValorUnitario then
      fValorUnitario := Value;
end;

{ TItemPedidoHelper }

class function TItemPedidoHelper.FromItemPedido(
  const AItemPedido: TItemPedido): TItemPedido;
begin
   Result := TItemPedido.Create;
   Result.Id := AItemPedido.Id;
   Result.Produto := TProduto.FromProduto(AItemPedido.Produto);
   Result.Quantidade := AItemPedido.Quantidade;
   Result.ValorUnitario := AItemPedido.ValorUnitario;
end;

end.
