unit Pedidos.Model.Entidade.Pedido;

interface

uses
   SysUtils, Data.DB, Generics.Collections,
   Pedidos.Classe.Cliente,
   Pedidos.Classe.Pedido,
   Pedidos.Classe.ItemPedido,
   Pedidos.Model.Conexao.Interfaces,
   Pedidos.Model.Entidade.Interfaces;

type
   TModelEntidadePedido = class(TInterfacedObject, IPedidoEntidade)
   private
      { Private declarations }
      fQuery: IModelQuery;
   protected
      { Protected declarations }
      function GetItens: TItensPedido;
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      class function New: IPedidoEntidade;
      function DataSet(const Value: TDataSource): IPedidoEntidade; overload;
      function DataSet(const Value: TDataSet): IPedidoEntidade; overload;
      procedure Open(const ClausulaWhere: String = '');
      function Find(const Value: Integer): TPedido; overload;
      function Find(const Cliente: TCliente): TPedido; overload;
      procedure Salva(Pedido: TPedido);
      procedure Cancela(const Value: Integer);
      procedure Close;
   end;

implementation

uses
   Pedidos.Model.Conexao.Factory,
   Pedidos.Model.Entidade.Cliente,
   Pedidos.Model.Entidade.ItemPedido,
   Pedidos.Model.Entidade.Produto;

{ TModelEntidadePedido }

procedure TModelEntidadePedido.Cancela(const Value: Integer);
var
   AQuery: IModelQuery;
begin
   AQuery := TModelConexaoFactory.New.Query;
   with AQuery do
      begin
         // Iniciando a transação
         Query.Connection.StartTransaction;
         try
            // Deletando os itens do pedido
            Query.ExecSQL('DELETE FROM itens_pedido ' +
                          'WHERE ' +
                          '   numero_pedido = ' + Value.ToString);
            // Deeletando os dados gerais do pedido
            Query
               .ExecSQL('DELETE FROM pedidos ' +
                        'WHERE ' +
                        '   numero_pedido = ' + Value.ToString);
            // Finalizando a transação
            Query.Connection.Commit;
         except
            Query.Connection.Rollback;
            raise;
         end;
      end;
end;

procedure TModelEntidadePedido.Close;
begin
   fQuery.Query.Close;
end;

constructor TModelEntidadePedido.Create;
begin
   fQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadePedido.DataSet(const Value: TDataSet): IPedidoEntidade;
begin
   Result := Self;
   Value.Assign(fQuery.Query);
end;

function TModelEntidadePedido.DataSet(const Value: TDataSource): IPedidoEntidade;
begin
   Result := Self;
   Value.DataSet := fQuery.Query;
end;

destructor TModelEntidadePedido.Destroy;
begin

  inherited;
end;

function TModelEntidadePedido.Find(const Cliente: TCliente): TPedido;
begin
   Result := nil;
   Open(Format('WHERE codigo_cliente = %d', [Cliente.Codigo]));
   with fQuery do
      if not Query.IsEmpty then
         begin
            Result := TPedido.Create;
            Result.Numero := Query.FieldByName('numero').AsInteger;
            Result.DataEmissao := Query.FieldByName('data_emissao').AsDateTime;
            Result.Cliente := TCliente.FromCliente(Cliente);
            Result.Itens := GetItens;
         end;
end;

function TModelEntidadePedido.GetItens: TItensPedido;
var
   AQuery: IModelQuery;
   AInstrucaoSQL: String;
   AItemPedido: TItemPedido;
   AProduto: IProdutoEntidade;
begin
   Result := TItensPedido.Create;
   AQuery := TModelConexaoFactory.New.Query;
   AInstrucaoSQL := '';
   AInstrucaoSQL := AInstrucaoSQL + 'SELECT ';
   AInstrucaoSQL := AInstrucaoSQL + '   id, ';
   AInstrucaoSQL := AInstrucaoSQL + '   numero_pedido, ';
   AInstrucaoSQL := AInstrucaoSQL + '   codigo_produto, ';
   AInstrucaoSQL := AInstrucaoSQL + '   quantidade, ';
   AInstrucaoSQL := AInstrucaoSQL + '   valor_unitario ';
   AInstrucaoSQL := AInstrucaoSQL + 'FROM itens_pedido ';
   AInstrucaoSQL := AInstrucaoSQL + Format('WHERE numero_pedido = %d ', [fQuery.Query.FieldByName('numero').AsInteger]);
   AInstrucaoSQL := AInstrucaoSQL + 'ORDER BY id';
   AQuery.Query.Open(AInstrucaoSQL);
   with AQuery do
      begin
         if not Query.IsEmpty then
            begin
               Query.First;
               while not Query.Eof do
                  begin
                     AItemPedido := TItemPedido.Create;
                     AItemPedido.Id := Query.FieldByName('id').AsInteger;
                     AProduto := TModelEntidadeProduto.New;
                     AItemPedido.Produto := TModelEntidadeProduto(AProduto).Find(Query.FieldByName('codigo_produto').AsInteger);
                     AItemPedido.Quantidade := Query.FieldByName('quantidade').AsInteger;
                     AItemPedido.ValorUnitario := Query.FieldByName('valor_unitario').AsFloat;
                     Result.Add(AItemPedido);
                     Query.Next;
                  end;
            end;
      end;
end;

function TModelEntidadePedido.Find(const Value: Integer): TPedido;
var
   AClienteEntidade: IClienteEntidade;
begin
   Result := nil;
   Open(Format('WHERE numero = %d', [Value]));
   with fQuery do
      if not Query.IsEmpty then
         begin
            Result := TPedido.Create;
            Result.Numero := Query.FieldByName('numero').AsInteger;
            Result.DataEmissao := Query.FieldByName('data_emissao').AsDateTime;
            AClienteEntidade := TModelEntidadeCliente.New;
            Result.Cliente := TModelEntidadeCliente(AClienteEntidade).Find(Query.FieldByName('codigo_cliente').AsInteger);
            Result.Itens := GetItens;
         end;
end;

class function TModelEntidadePedido.New: IPedidoEntidade;
begin
   Result := Create;
end;

procedure TModelEntidadePedido.Open(const ClausulaWhere: String);
var
   AInstrucaoSQL: String;
begin
   AInstrucaoSQL := '';
   AInstrucaoSQL := AInstrucaoSQL + 'SELECT ';
   AInstrucaoSQL := AInstrucaoSQL + '   numero, ';
   AInstrucaoSQL := AInstrucaoSQL + '   data_emissao, ';
   AInstrucaoSQL := AInstrucaoSQL + '   codigo_cliente, ';
   AInstrucaoSQL := AInstrucaoSQL + '   valor_total ';
   AInstrucaoSQL := AInstrucaoSQL + 'FROM pedidos ';
   if ClausulaWhere <> '' then
      AInstrucaoSQL := AInstrucaoSQL + ClausulaWhere + ' ';
   AInstrucaoSQL := AInstrucaoSQL + 'ORDER BY numero';
   fQuery.Query.Open(AInstrucaoSQL);
end;

procedure TModelEntidadePedido.Salva(Pedido: TPedido);
var
   AQuery: IModelQuery;
   AFormato: TFormatSettings;
   AItemPedido: TItemPedido;
begin
   AQuery := TModelConexaoFactory.New.Query;
   AFormato := TFormatSettings.Create('US');
   AFormato.ShortDateFormat := 'yyyy-mm-dd';
   with AQuery do
      begin
         // Iniciando a transação
         Query.Connection.StartTransaction;
         try
            if Pedido.Numero = -1 then
               begin
                  // Inserindo os dados gerais do pedido
                  Query
                     .Open('INSERT INTO pedidos ' +
                           '   (data_emissao, codigo_cliente, valor_total) ' +
                           'VALUES ' +
                           '   (' + QuotedStr(DateTimeToStr(Pedido.DataEmissao, AFormato)) + ', ' + Pedido.Cliente.Codigo.ToString + ', ' + FloatToStr(Pedido.ValorTotal, AFormato) + ') ' +
                           'RETURNING numero');
                  Pedido.Numero := Query.FieldByName('numero').AsInteger;
               end;
            // Inserindo os itens do pedido
            For AItemPedido in Pedido.Itens do
               begin
                  if AItemPedido.Id = -1 then
                     begin
                        Query.ExecSQL('INSERT INTO itens_pedido ' +
                                      '   (numero_pedido, codigo_produto, quantidade, valor_unitario, valor_total) ' +
                                      'VALUES ' +
                                      '   (' + Pedido.Numero.ToString + ', ' + AItemPedido.Produto.Codigo.ToString + ', ' + AItemPedido.Quantidade.ToString + ', ' + FloatToStr(AItemPedido.ValorUnitario, AFormato) + ', ' + FloatToStr(AItemPedido.ValorTotal, AFormato) + ')');
                     end
                  else
                     begin
                        Query.ExecSQL('UPDATE itens_pedido ' +
                                      '   SET codigo_produto = ' + AItemPedido.Produto.Codigo.ToString + ', ' +
                                      '       quantidade = ' + AItemPedido.Quantidade.ToString + ', ' +
                                      '       valor_unitario = ' + FloatToStr(AItemPedido.ValorUnitario, AFormato) + ', ' +
                                      '       valor_total = ' + FloatToStr(AItemPedido.ValorTotal, AFormato) + ' ' +
                                      'WHERE ' +
                                      '   id = ' + AItemPedido.Id.ToString);
                     end;
               end;
            // Finalizando a transação
            Query.Connection.Commit;
         except
            Query.Connection.Rollback;
            raise;
         end;
      end;
end;

end.
