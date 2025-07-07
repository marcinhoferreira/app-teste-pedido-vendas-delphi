program Pedidos;

uses
  Vcl.Forms,
  FireDAC.VCLUI.Wait,
  Pedidos.Classe.Cliente in 'src\Classes\Pedidos.Classe.Cliente.pas',
  Pedidos.Classe.Produto in 'src\Classes\Pedidos.Classe.Produto.pas',
  Pedidos.Classe.ItemPedido in 'src\Classes\Pedidos.Classe.ItemPedido.pas',
  Pedidos.Classe.Pedido in 'src\Classes\Pedidos.Classe.Pedido.pas',
  Pedidos.Model.Conexao.Interfaces in 'src\Interfaces\Pedidos.Model.Conexao.Interfaces.pas',
  Pedidos.Model.Conexao.FireDAC.Conexao in 'src\Models\Conexao\Pedidos.Model.Conexao.FireDAC.Conexao.pas',
  Pedidos.Model.Conexao.FireDAC.Query in 'src\Models\Conexao\Pedidos.Model.Conexao.FireDAC.Query.pas',
  Pedidos.Model.Conexao.FireDAC.StoredProc in 'src\Models\Conexao\Pedidos.Model.Conexao.FireDAC.StoredProc.pas',
  Pedidos.Model.Conexao.Factory in 'src\Models\Conexao\Pedidos.Model.Conexao.Factory.pas',
  Pedidos.Model.Entidade.Interfaces in 'src\Interfaces\Pedidos.Model.Entidade.Interfaces.pas',
  Pedidos.Model.Entidade.Cliente in 'src\Models\Entidade\Pedidos.Model.Entidade.Cliente.pas',
  Pedidos.Model.Entidade.Produto in 'src\Models\Entidade\Pedidos.Model.Entidade.Produto.pas',
  Pedidos.Model.Entidade.Pedido in 'src\Models\Entidade\Pedidos.Model.Entidade.Pedido.pas',
  Pedidos.Model.Entidade.ItemPedido in 'src\Models\Entidade\Pedidos.Model.Entidade.ItemPedido.pas',
  Pedidos.Model.Entidade.Factory in 'src\Models\Entidade\Pedidos.Model.Entidade.Factory.pas',
  Pedidos.View.ClienteDados in 'src\Views\Pedidos.View.ClienteDados.pas' {frameClienteDados: TFrame},
  Pedidos.View.ItemPedidoDados in 'src\Views\Pedidos.View.ItemPedidoDados.pas' {frameItemPedidoDados: TFrame},
  Pedidos.View.Pedido in 'src\Views\Pedidos.View.Pedido.pas' {frmPedido},
  Pedidos.Controller.Interfaces in 'src\Interfaces\Pedidos.Controller.Interfaces.pas',
  Pedidos.Controller in 'src\Controllers\Pedidos.Controller.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TfrmPedido, frmPedido);
  Application.Run;
end.
