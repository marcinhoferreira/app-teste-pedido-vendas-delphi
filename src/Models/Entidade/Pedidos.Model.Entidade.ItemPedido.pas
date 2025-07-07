unit Pedidos.Model.Entidade.ItemPedido;

interface

uses
   SysUtils, Data.DB,
   Pedidos.Classe.ItemPedido,
   Pedidos.Model.Conexao.Interfaces,
   Pedidos.Model.Entidade.Interfaces;

type
   TModelEntidadeItemPedido = class(TInterfacedObject, IItemPedidoEntidade)
   private
      { Private declarations }
      fQuery: IModelQuery;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      class function New: IItemPedidoEntidade;
      function DataSet(const Value: TDataSource): IItemPedidoEntidade; overload;
      function DataSet(const Value: TDataSet): IItemPedidoEntidade; overload;
      procedure Open(const ClausulaWhere: String = '');
      function Find(const Value: Integer): TItemPedido;
      procedure Close;
   end;

implementation

uses
   Pedidos.Model.Conexao.Factory,
   Pedidos.Classe.Produto,
   Pedidos.Model.Entidade.Produto;

{ TModelEntidadeItemPedido }

procedure TModelEntidadeItemPedido.Close;
begin
   fQuery.Query.Close;
end;

constructor TModelEntidadeItemPedido.Create;
begin
   fQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeItemPedido.DataSet(const Value: TDataSet): IItemPedidoEntidade;
begin
   Result := Self;
   Value.Assign(fQuery.Query);
end;

function TModelEntidadeItemPedido.DataSet(const Value: TDataSource): IItemPedidoEntidade;
begin
   Result := Self;
   Value.DataSet := fQuery.Query;
end;

destructor TModelEntidadeItemPedido.Destroy;
begin

  inherited;
end;

function TModelEntidadeItemPedido.Find(const Value: Integer): TItemPedido;
var
  AProdutoModel: IModelEntidade;
begin
   Result := nil;
   Open(Format('WHERE id = %d', [Value]));
   with fQuery do
      if not Query.IsEmpty then
         begin
            Result := TItemPedido.Create;
            Result.Id := Query.FieldByName('id').AsInteger;
            AProdutoModel := TModelEntidadeProduto.New;
            Result.Produto := TModelEntidadeProduto(AProdutoModel).Find(Query.FieldByName('codigo_produto').AsInteger) as TProduto;
            Result.Quantidade := Query.FieldByName('quantidade').AsInteger;
            Result.ValorUnitario := Query.FieldByName('valor_unitario').AsFloat;
         end;
end;

class function TModelEntidadeItemPedido.New: IItemPedidoEntidade;
begin
   Result := Create;
end;

procedure TModelEntidadeItemPedido.Open(const ClausulaWhere: String);
var
   AInstrucaoSQL: String;
begin
   AInstrucaoSQL := '';
   AInstrucaoSQL := AInstrucaoSQL + 'SELECT ';
   AInstrucaoSQL := AInstrucaoSQL + '   id, ';
   AInstrucaoSQL := AInstrucaoSQL + '   numero_pedido, ';
   AInstrucaoSQL := AInstrucaoSQL + '   codigo_produto, ';
   AInstrucaoSQL := AInstrucaoSQL + '   quantidade, ';
   AInstrucaoSQL := AInstrucaoSQL + '   valor_unitario, ';
   AInstrucaoSQL := AInstrucaoSQL + '   valor_total ';
   AInstrucaoSQL := AInstrucaoSQL + 'FROM itens_pedido ';
   if ClausulaWhere <> '' then
      AInstrucaoSQL := AInstrucaoSQL + ClausulaWhere + ' ';
   AInstrucaoSQL := AInstrucaoSQL + 'ORDER BY id';
   fQuery.Query.Open(AInstrucaoSQL);
end;

end.
