unit Pedidos.Classe.Produto;

interface

uses
   SysUtils, Classes, Data.DB;

type
   TProduto = class(TObject)
   private
      { Private declarations }
      fCodigo: Integer;
      fDescricao: String;
      fPrecoVenda: Double;
      function GetCodigo: Integer;
      function GetDescricao: String;
      function GetPrecoVenda: Double;
      procedure SetCodigo(const Value: Integer);
      procedure SetDescricao(const Value: String);
      procedure SetPrecoVenda(const Value: Double);
   protected
      { Protected declarations }
   public
      { Public declarations }
      property Codigo: Integer Read GetCodigo Write SetCodigo;
      property Descricao: String Read GetDescricao Write SetDescricao;
      property PrecoVenda: Double Read GetPrecoVenda Write SetPrecoVenda;
   end;

   TProdutoHelper = class helper for TProduto
   private
      { Private declarations }
   protected
      { Protected declarations }
   public
      { Public declarations }
      class function FromProduto(const Produto: TProduto): TProduto;
      class function FromDataSet(const Data: TDataSet): TProduto;
   end;

implementation

{ TProduto }

function TProduto.GetCodigo: Integer;
begin
   Result := fCodigo;
end;

function TProduto.GetDescricao: String;
begin
   Result := fDescricao;
end;

function TProduto.GetPrecoVenda: Double;
begin
   Result := fPrecoVenda;
end;

procedure TProduto.SetCodigo(const Value: Integer);
begin
   if Value <> fCodigo then
      fCodigo := Value;
end;

procedure TProduto.SetDescricao(const Value: String);
begin
   if Value <> fDescricao then
      fDescricao := Value;
end;

procedure TProduto.SetPrecoVenda(const Value: Double);
begin
   if Value <> fPrecoVenda then
      fPrecoVenda := Value;
end;

{ TProdutoHelper }

class function TProdutoHelper.FromDataSet(const Data: TDataSet): TProduto;
begin
   Result := TProduto.Create;
   Result.Codigo := Data.FieldByName('codigo').AsInteger;
   Result.Descricao := Data.FieldByName('descricao').AsString;
   Result.PrecoVenda := Data.FieldByName('preco_venda').AsFloat;
end;

class function TProdutoHelper.FromProduto(const Produto: TProduto): TProduto;
begin
   Result := TProduto.Create;
   Result.Codigo := Produto.Codigo;
   Result.Descricao := Produto.Descricao;
   Result.PrecoVenda := Produto.PrecoVenda;
end;

end.
