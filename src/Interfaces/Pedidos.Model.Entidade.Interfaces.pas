unit Pedidos.Model.Entidade.Interfaces;

interface

uses
  Data.DB,
  Pedidos.Classe.Cliente,
  Pedidos.Classe.Produto,
  Pedidos.Classe.Pedido,
  Pedidos.Classe.ItemPedido;

type
   IModelEntidade = interface
      ['{BE1C1D2D-891E-430C-B177-3311322C7046}']
      procedure Open(const ClausulaWhere: String = '');
      procedure Close;
   end;

   IClienteEntidade = interface(IModelEntidade)
      ['{37A97C98-27A7-463F-8141-E3C275038AC9}']
      function Find(const Value: Integer): TCliente;
   end;

   IProdutoEntidade = interface(IModelEntidade)
      ['{5021857F-AD8F-451B-90BC-DFE0DAD5C429}']
      function Find(const Value: Integer): TProduto;
   end;

   IPedidoEntidade = interface(IModelEntidade)
      ['{0B1BFE6E-BD1E-4CBE-BFFD-52646114E231}']
      function Find(const Value: Integer): TPedido; overload;
      function Find(const Cliente: TCliente): TPedido; overload;
      procedure Salva(Pedido: TPedido);
      procedure Cancela(const Value: Integer);
   end;

   IItemPedidoEntidade = interface(IModelEntidade)
      ['{E78D4169-6E23-4476-858C-44333AACD78A}']
      function Find(const Value: Integer): TItemPedido;
   end;

   IModelEntidadesFactory = interface
      ['{8ECAABC4-9FC2-4A60-8C4C-444E898F67C8}']
      function Cliente: IClienteEntidade;
      function Produto: IProdutoEntidade;
      function Pedido: IPedidoEntidade;
      function ItemPedido: IItemPedidoEntidade;
   end;

implementation


end.
