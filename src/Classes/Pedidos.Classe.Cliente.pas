unit Pedidos.Classe.Cliente;

interface

uses
   SysUtils, Classes, Data.DB;

type
   TCliente = class(TObject)
   private
      { Private declarations }
      fCodigo: Integer;
      fNome: String;
      fCidade: String;
      fUF: String;
      function GetCodigo: Integer;
      procedure SetCodigo(const Value: Integer);
      function GetNome: String;
      procedure SetNome(const Value: String);
      function GetCidade: String;
      procedure SetCidade(const Value: String);
      function GetUF: String;
      procedure SetUF(const Value: String);
   protected
      { Protected declarations }
   public
      { Public declarations }
      property Codigo: Integer Read GetCodigo Write SetCodigo;
      property Nome: String Read GetNome Write SetNome;
      property Cidade: String Read GetCidade Write SetCidade;
      property UF: String Read GetUF Write SetUF;
   end;

   TClienteHelper = class helper for TCliente
   private
      { Private declarations }
   protected
      { Protected declarations }
   public
      { Public declarations }
      class function FromCliente(const Cliente: TCliente): TCliente;
      class function FromDataSet(const Data: TDataSet): TCliente;
   end;

implementation

{ TCliente }

function TCliente.GetCidade: String;
begin
   Result := fCidade;
end;

function TCliente.GetCodigo: Integer;
begin
   Result := fCodigo;
end;

function TCliente.GetNome: String;
begin
   Result := fNome;
end;

function TCliente.GetUF: String;
begin
   Result := fUF;
end;

procedure TCliente.SetCidade(const Value: String);
begin
   if Value <> fCidade then
      fCidade := Value;
end;

procedure TCliente.SetCodigo(const Value: Integer);
begin
   if Value <> fCodigo then
      fCodigo := Value;
end;

procedure TCliente.SetNome(const Value: String);
begin
   if Value <> fNome then
      fNome := Value;
end;

procedure TCliente.SetUF(const Value: String);
begin
   if Value <> fUF then
      fUF := Value;
end;

{ TClienteHelper }

class function TClienteHelper.FromCliente(const Cliente: TCliente): TCliente;
begin
   Result := TCliente.Create;
   Result.Codigo := Cliente.Codigo;
   Result.Nome := Cliente.Nome;
   Result.Cidade := Cliente.Cidade;
   Result.UF := Cliente.UF;
end;

class function TClienteHelper.FromDataSet(const Data: TDataSet): TCliente;
begin
   Result := TCliente.Create;
   Result.Codigo := Data.FieldByName('codigo').AsInteger;
   Result.Nome := Data.FieldByName('nome').AsString;
   Result.Cidade := Data.FieldByName('cidade').AsString;
   Result.UF := Data.FieldByName('uf').AsString;
end;

end.
