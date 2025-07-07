unit Pedidos.Classe.Pedido;

interface

uses
   SysUtils, Classes, Generics.Collections,
   Pedidos.Classe.Cliente,
   Pedidos.Classe.ItemPedido;

type
   TItensPedido = TObjectList<TItemPedido>;

   TPedido = class(TObject)
   private
      { Private declarations }
      fNumero: Integer;
      fDataEmissao: TDateTime;
      fCliente: TCliente;
      fItens: TItensPedido;
      function GetCliente: TCliente;
      function GetDataEmissao: TDateTime;
      function GetNumero: Integer;
      function GetValorTotal: Double;
      procedure SetCliente(const Value: TCliente);
      procedure SetDataEmissao(const Value: TDateTime);
      procedure SetNumero(const Value: Integer);
      function GetItens: TItensPedido;
      procedure SetItens(const Value: TItensPedido);
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      procedure RegistraItemVendido(const Item: TItemPedido);
      property Numero: Integer Read GetNumero Write SetNumero;
      property DataEmissao: TDateTime Read GetDataEmissao Write SetDataEmissao;
      property Cliente: TCliente Read GetCliente Write SetCliente;
      property Itens: TItensPedido Read GetItens Write SetItens;
      property ValorTotal: Double Read GetValorTotal;
   end;

implementation

{ TPedido }

constructor TPedido.Create;
begin
   fCliente := TCliente.Create;
   fItens := TItensPedido.Create;
end;

destructor TPedido.Destroy;
begin
   FreeAndNil(fCliente);
   FreeAndNil(fItens);
  inherited;
end;

function TPedido.GetCliente: TCliente;
begin
   Result := fCliente;
end;

function TPedido.GetDataEmissao: TDateTime;
begin
   Result := fDataEmissao;
end;

function TPedido.GetItens: TItensPedido;
begin
   Result := fItens;
end;

function TPedido.GetNumero: Integer;
begin
   Result := fNumero;
end;

function TPedido.GetValorTotal: Double;
var
   AItem: TItemPedido;
begin
   Result := 0;
   for AItem in fItens do
      Result := Result + AItem.ValorTotal;
end;

procedure TPedido.RegistraItemVendido(const Item: TItemPedido);
var
   AIndex: Integer;
begin
   if Item.Id = -1 then
      fItens.Add(TItemPedido.FromItemPedido(Item))
   else
      for AIndex := 0 to fItens.Count - 1 do
         begin
            if fItens[AIndex].Id = Item.Id then
               begin
                  fItens[AIndex] := Nil;
                  fItens[AIndex] := TItemPedido.FromItemPedido(Item);
                  Exit;
               end;
         end;

end;

procedure TPedido.SetCliente(const Value: TCliente);
begin
   fCliente := Value;
end;

procedure TPedido.SetDataEmissao(const Value: TDateTime);
begin
   if Value <> fDataEmissao then
      fDataEmissao := Value;
end;

procedure TPedido.SetItens(const Value: TItensPedido);
begin
   fItens := Value;
end;

procedure TPedido.SetNumero(const Value: Integer);
begin
   if Value <> fNumero then
      fNumero := Value;
end;

end.
