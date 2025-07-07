unit Pedidos.Controller.Interfaces;

interface

uses
   Classes,
   Pedidos.Model.Entidade.Interfaces;

type
   IController = interface
      ['{73935B28-EF09-4FA2-905C-AEA84B89E230}']
      function Entidades: IModelEntidadesFactory;
   end;

implementation

end.
