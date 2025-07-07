unit Pedidos.Controller;

interface

uses
  SysUtils, Classes,
  Pedidos.Controller.Interfaces,
  Pedidos.Model.Entidade.Interfaces;

Type
   TController = class(TInterfacedObject, IController)
   private
      { Private declarations }
      class var fInstance: IController;
      fModelEntidades: IModelEntidadesFactory;
      constructor Create;
   public
      { Public declarations }
      destructor Destroy; override;
      class function GetInstance: IController;
      function Entidades: IModelEntidadesFactory;
   end;

implementation

uses
   Pedidos.Model.Entidade.Factory;

{ TController }

constructor TController.Create;
begin
   fModelEntidades := TModelEntidadesFactory.New;
end;

destructor TController.Destroy;
begin
  inherited;
end;

function TController.Entidades: IModelEntidadesFactory;
begin
   Result := fModelEntidades;
end;

class function TController.GetInstance: IController;
begin
   if not Assigned(fInstance) then
      fInstance := Create;
   Result := fInstance;
end;

end.
