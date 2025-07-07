unit Pedidos.Model.Entidade.Factory;

interface

uses
  SysUtils, Classes,
  Pedidos.Model.Conexao.Interfaces,
  Pedidos.Model.Entidade.Interfaces;

type
   TModelEntidadesFactory = class(TInterfacedObject, IModelEntidadesFactory)
   private
      { Private declarations }
      fCliente: IClienteEntidade;
      fProduto: IProdutoEntidade;
      fPedido: IPedidoEntidade;
      fItemPedido: IItemPedidoEntidade;
   public
      { Public declarations }
      destructor Destroy; override;
      class function New: IModelEntidadesFactory;
      function Cliente: IClienteEntidade;
      function Produto: IProdutoEntidade;
      function Pedido: IPedidoEntidade;
      function ItemPedido: IItemPedidoEntidade;
    end;

implementation

uses
   Pedidos.Model.Entidade.Cliente,
   Pedidos.Model.Entidade.Produto,
   Pedidos.Model.Entidade.Pedido,
   Pedidos.Model.Entidade.ItemPedido;

{ TModelEntidadesFactory }

function TModelEntidadesFactory.Cliente: IClienteEntidade;
begin
   if not Assigned(fCliente) then
      fCliente := TModelEntidadeCliente.New;
   Result := fCliente;
end;

destructor TModelEntidadesFactory.Destroy;
begin

   inherited;
end;

function TModelEntidadesFactory.ItemPedido: IItemPedidoEntidade;
begin
   if not Assigned(fItemPedido) then
      fItemPedido := TModelEntidadeItemPedido.New;
   Result := fItemPedido;
end;

class function TModelEntidadesFactory.New: IModelEntidadesFactory;
begin
   Result := Create;
end;

function TModelEntidadesFactory.Pedido: IPedidoEntidade;
begin
   if not Assigned(fPedido) then
      fPedido := TModelEntidadePedido.New;
   Result := fPedido;
end;

function TModelEntidadesFactory.Produto: IProdutoEntidade;
begin
   if not Assigned(fProduto) then
      fProduto := TModelEntidadeProduto.New;
   Result := fProduto;
end;

end.
