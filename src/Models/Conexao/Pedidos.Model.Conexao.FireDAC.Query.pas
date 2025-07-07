unit Pedidos.Model.Conexao.FireDAC.Query;

interface

uses
  SysUtils, Classes, Data.DB,
  Pedidos.Model.Conexao.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TModelConexaoFireDACQuery = class(TInterfacedObject, IModelQuery)
   private
      { Private declarations }
      fConexao: IModelConexao;
      fQuery: TFDQuery;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create(const Conexao: IModelConexao);
      destructor Destroy; override;
      class function New(const Conexao: IModelConexao): IModelQuery;
      function Query: TFDQuery;
   end;

implementation

{ TModelConexaoFireDACQuery }

constructor TModelConexaoFireDACQuery.Create(const Conexao: IModelConexao);
begin
   fConexao := Conexao;
   fQuery := TFDQuery.Create(Nil);
   fQuery.Connection := fConexao.Conexao;
end;

destructor TModelConexaoFireDACQuery.Destroy;
begin
   fQuery.Destroy;
   inherited;
end;

class function TModelConexaoFireDACQuery.New(const Conexao: IModelConexao): IModelQuery;
begin
   Result := Create(Conexao);
end;

function TModelConexaoFireDACQuery.Query: TFDQuery;
begin
   Result := fQuery;
end;

end.
