unit Pedidos.Model.Entidade.Cliente;

interface

uses
   SysUtils, Data.DB,
   Pedidos.Classe.Cliente,
   Pedidos.Model.Conexao.Interfaces,
   Pedidos.Model.Entidade.Interfaces;

type
   TModelEntidadeCliente = class(TInterfacedObject, IClienteEntidade)
   private
      { Private declarations }
      fQuery: IModelQuery;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      class function New: IClienteEntidade;
      function DataSet(const Value: TDataSource): IClienteEntidade; overload;
      function DataSet(const Value: TDataSet): IClienteEntidade; overload;
      procedure Open(const ClausulaWhere: String = '');
      function Find(const Value: Integer): TCliente;
      procedure Close;
   end;

implementation

uses
   Pedidos.Model.Conexao.Factory;

{ TModelEntidadeCliente }

procedure TModelEntidadeCliente.Close;
begin
   fQuery.Query.Close;
end;

constructor TModelEntidadeCliente.Create;
begin
   fQuery := TModelConexaoFactory.New.Query;
end;

function TModelEntidadeCliente.DataSet(const Value: TDataSet): IClienteEntidade;
begin
   Result := Self;
   Value.Assign(fQuery.Query);
end;

function TModelEntidadeCliente.DataSet(const Value: TDataSource): IClienteEntidade;
begin
   Result := Self;
   Value.DataSet := fQuery.Query;
end;

destructor TModelEntidadeCliente.Destroy;
begin

  inherited;
end;

function TModelEntidadeCliente.Find(const Value: Integer): TCliente;
begin
   Result := nil;
   Open(Format('WHERE codigo = %d', [Value]));
   with fQuery do
      if not Query.IsEmpty then
         Result := TCliente.FromDataSet(Query);
end;

class function TModelEntidadeCliente.New: IClienteEntidade;
begin
   Result := Create;
end;

procedure TModelEntidadeCliente.Open(const ClausulaWhere: String);
var
   AInstrucaoSQL: String;
begin
   AInstrucaoSQL := '';
   AInstrucaoSQL := AInstrucaoSQL + 'SELECT ';
   AInstrucaoSQL := AInstrucaoSQL + '   codigo, ';
   AInstrucaoSQL := AInstrucaoSQL + '   nome, ';
   AInstrucaoSQL := AInstrucaoSQL + '   cidade, ';
   AInstrucaoSQL := AInstrucaoSQL + '   uf ';
   AInstrucaoSQL := AInstrucaoSQL + 'FROM clientes ';
   if ClausulaWhere <> '' then
      AInstrucaoSQL := AInstrucaoSQL + ClausulaWhere + ' ';
   AInstrucaoSQL := AInstrucaoSQL + 'ORDER BY codigo';
   fQuery.Query.Open(AInstrucaoSQL);
end;

end.
