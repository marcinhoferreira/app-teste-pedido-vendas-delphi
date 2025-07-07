unit Pedidos.Model.Conexao.FireDAC.StoredProc;

interface

uses
  SysUtils, Classes, Data.DB,
  Pedidos.Model.Conexao.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error,
  FireDAC.DatS, FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Stan.Async,
  FireDAC.DApt, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
   TModelConexaoFireDACStoredProc = class(TInterfacedObject, IModelStoredProc)
   private
      { Private declarations }
      fConexao: IModelConexao;
      fStoredProc: TFDStoredProc;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create(const Conexao: IModelConexao);
      destructor Destroy; override;
      class function New(const Conexao: IModelConexao): IModelStoredProc;
      function StoredProc: TFDStoredProc;
   end;

implementation

{ TModelConexaoFireDACStoredProc }

constructor TModelConexaoFireDACStoredProc.Create(const Conexao: IModelConexao);
begin
   fConexao := Conexao;
   fStoredProc := TFDStoredProc.Create(Nil);
   fStoredProc.Connection := fConexao.Conexao;
end;

destructor TModelConexaoFireDACStoredProc.Destroy;
begin
   fStoredProc.Destroy;
   inherited;
end;

class function TModelConexaoFireDACStoredProc.New(const Conexao: IModelConexao): IModelStoredProc;
begin
   Result := Create(Conexao);
end;

function TModelConexaoFireDACStoredProc.StoredProc: TFDStoredProc;
begin
   Result := fStoredProc;
end;

end.
