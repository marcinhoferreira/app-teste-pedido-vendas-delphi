unit Pedidos.Model.Entidade.Produto;

interface

uses
   SysUtils, Data.DB,
   Pedidos.Classe.Produto,
   Pedidos.Model.Conexao.Interfaces,
   Pedidos.Model.Entidade.Interfaces;

type
   TModelEntidadeProduto = class(TInterfacedObject, IProdutoEntidade)
   private
      { Private declarations }
      fQuery: IModelQuery;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      class function New: IProdutoEntidade;
      function DataSet(const Value: TDataSource): IProdutoEntidade; overload;
      function DataSet(const Value: TDataSet): IProdutoEntidade; overload;
      procedure Open(const ClausulaWhere: String = '');
      function Find(const Value: Integer): TProduto;
      procedure Close;
   end;

implementation

uses
   Pedidos.Model.Conexao.Factory;

{ TModelEntidadeProduto }

procedure TModelEntidadeProduto.Close;
begin
   fQuery.Query.Close;
end;

constructor TModelEntidadeProduto.Create;
begin
   fQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeProduto.DataSet(const Value: TDataSet): IProdutoEntidade;
begin
   Result := Self;
   Value.Assign(fQuery.Query);
end;

function TModelEntidadeProduto.DataSet(const Value: TDataSource): IProdutoEntidade;
begin
   Result := Self;
   Value.DataSet := fQuery.Query;
end;

destructor TModelEntidadeProduto.Destroy;
begin

  inherited;
end;

function TModelEntidadeProduto.Find(const Value: Integer): TProduto;
begin
   Result := nil;
   Open(Format('WHERE codigo = %d', [Value]));
   with fQuery do
      if not Query.IsEmpty then
         Result := TProduto.FromDataSet(Query);
end;

class function TModelEntidadeProduto.New: IProdutoEntidade;
begin
   Result := Create;
end;

procedure TModelEntidadeProduto.Open(const ClausulaWhere: String);
var
   AInstrucaoSQL: String;
begin
   AInstrucaoSQL := '';
   AInstrucaoSQL := AInstrucaoSQL + 'SELECT ';
   AInstrucaoSQL := AInstrucaoSQL + '   codigo, ';
   AInstrucaoSQL := AInstrucaoSQL + '   descricao, ';
   AInstrucaoSQL := AInstrucaoSQL + '   preco_venda ';
   AInstrucaoSQL := AInstrucaoSQL + 'FROM produtos ';
   if ClausulaWhere <> '' then
      AInstrucaoSQL := AInstrucaoSQL + ClausulaWhere + ' ';
   AInstrucaoSQL := AInstrucaoSQL + 'ORDER BY codigo';
   fQuery.Query.Open(AInstrucaoSQL);
end;

end.
