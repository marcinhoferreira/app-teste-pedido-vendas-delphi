unit Pedidos.View.Pedido;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Pedidos.Controller.Interfaces,
  Pedidos.Classe.Cliente,
  Pedidos.Classe.Produto,
  Pedidos.Classe.Pedido,
  Pedidos.Classe.ItemPedido,
  Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.ExtCtrls,
  Vcl.StdCtrls, Pedidos.View.ClienteDados, Pedidos.View.ItemPedidoDados,
  Vcl.ToolWin, Vcl.ComCtrls, System.ImageList, Vcl.ImgList, System.Actions,
  Vcl.ActnList, Vcl.Buttons, Datasnap.DBClient, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS,
  FireDAC.Phys.Intf, FireDAC.DApt.Intf, FireDAC.Comp.DataSet,
  FireDAC.Comp.Client;

type
  TfrmPedido = class(TForm)
    dsClientes: TDataSource;
    dsProdutos: TDataSource;
    dsPedidos: TDataSource;
    dsItensPedido: TDataSource;
    panDadosPedido: TPanel;
    grdItensPedido: TDBGrid;
    panTotaisPedido: TPanel;
    lblCodigoCliente: TLabel;
    edtCodigoCliente: TEdit;
    frameCliente: TframeClienteDados;
    frameItemPedido: TframeItemPedidoDados;
    panItensPedido: TPanel;
    imglstBarradeFerramentas: TImageList;
    panBarraDeFerramentas: TPanel;
    actlstAcoes: TActionList;
    actBuscarPedido: TAction;
    btnBuscarPedido: TSpeedButton;
    actGravarPedido: TAction;
    btnGravarPedido: TSpeedButton;
    lblPedidoValorTotal: TLabel;
    edtPedidoValorTotal: TEdit;
    lblPedidoDataEmissao: TLabel;
    edtPedidoDataEmissao: TEdit;
    lblPedidoNumero: TLabel;
    edtPedidoNumero: TEdit;
    memItensPedido: TFDMemTable;
    memItensPedidoid: TLargeintField;
    memItensPedidonumero_pedido: TLargeintField;
    memItensPedidocodigo_produto: TLargeintField;
    memItensPedidodescricao_produto: TStringField;
    memItensPedidoquantidade: TIntegerField;
    memItensPedidovalor_unitario: TFloatField;
    memItensPedidovalor_total: TFloatField;
    actCancelarPedido: TAction;
    btnCancelarPedido: TSpeedButton;
    procedure FormCreate(Sender: TObject);
    procedure edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure edtCodigoClienteEnter(Sender: TObject);
    procedure edtCodigoClienteExit(Sender: TObject);
    procedure edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure edtCodigoClienteChange(Sender: TObject);
    procedure frameItemPedidoedtProdutoCodigoKeyDown(Sender: TObject;
      var Key: Word; Shift: TShiftState);
    procedure actBuscarPedidoExecute(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frameItemPedidobtnConfirmarClick(Sender: TObject);
    procedure actGravarPedidoExecute(Sender: TObject);
    procedure grdItensPedidoKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure memItensPedidoAfterScroll(DataSet: TDataSet);
    procedure actCancelarPedidoExecute(Sender: TObject);
  private
    { Private declarations }
    fController: IController;
    fCliente: TCliente;
    fProduto: TProduto;
    fPedido: TPedido;
    fItemPedido: TItemPedido;
    procedure ExibeClienteDados;
    procedure ExibeProdutoDados;
    procedure ExibePedidoDados;
    procedure ExibeControles;
    procedure OcultaControles;
    procedure AtualizaGridItensPedido(const ItensPedido: TItensPedido);
  public
    { Public declarations }
  end;

var
  frmPedido: TfrmPedido;

implementation

uses
   Pedidos.Controller;

{$R *.dfm}

{ TfrmPedido }

procedure TfrmPedido.actBuscarPedidoExecute(Sender: TObject);
var
   ANumeroPedido: Integer;
begin
   try
      ANumeroPedido := InputBox('Buscar Pedido', 'Número do Pedido', '0').ToInteger;
      if ANumeroPedido > 0 then
         begin
            fPedido := fController
                           .Entidades
                           .Pedido
                           .Find(ANumeroPedido);

            if not Assigned(fPedido) then
               begin
                  fController
                     .Entidades
                     .Pedido
                     .Close;
                  ShowMessage('Pedido não encontrado!');
               end;

            edtCodigoCliente.Text := fPedido.Cliente.Codigo.ToString;

            fCliente := fController
                              .Entidades
                              .Cliente
                              .Find(fPedido.Cliente.Codigo);

            frameCliente.Inicializa(fCliente);

            ExibePedidoDados;

            AtualizaGridItensPedido(fPedido.Itens);

            edtPedidoValorTotal.Text := Format('%.2f',[fPedido.ValorTotal]);

            ExibeControles;

            frameItemPedido.edtProdutoCodigo.Enabled := True;

            FocusControl(frameItemPedido.edtProdutoCodigo);
         end;
   except
      on E: EConvertError do
         ShowMessage('Número inválido!');
   end;
end;

procedure TfrmPedido.actCancelarPedidoExecute(Sender: TObject);
var
   ANumeroPedido: Integer;
begin
   try
      ANumeroPedido := InputBox('Buscar Pedido', 'Número do Pedido', '0').ToInteger;
      if ANumeroPedido > 0 then
         begin
            fPedido := fController
                           .Entidades
                           .Pedido
                           .Find(ANumeroPedido);

            if not Assigned(fPedido) then
               begin
                  fController
                     .Entidades
                     .Pedido
                     .Close;
                  ShowMessage('Pedido não encontrado!');
               end;

            edtCodigoCliente.Text := fPedido.Cliente.Codigo.ToString;

            fCliente := fController
                              .Entidades
                              .Cliente
                              .Find(fPedido.Cliente.Codigo);

            frameCliente.Inicializa(fCliente);

            ExibePedidoDados;

            AtualizaGridItensPedido(fPedido.Itens);

            edtPedidoValorTotal.Text := Format('%.2f',[fPedido.ValorTotal]);

            ExibeControles;

            frameItemPedido.edtProdutoCodigo.Enabled := True;

            if MessageDlg('Deseja realmente cancelar o pedido ?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes then
               begin
                  fController
                     .Entidades
                     .Pedido
                     .Cancela(fPedido.Numero);
               end;
            fPedido := Nil;
            edtCodigoCliente.Text := '';
            FocusControl(edtCodigoCliente);
         end;
   except
      on E: EConvertError do
         ShowMessage('Número inválido!');
   end;
end;

procedure TfrmPedido.actGravarPedidoExecute(Sender: TObject);
begin
   fController
      .Entidades
      .Pedido
      .Salva(fPedido);
  TAction(Sender).Enabled := False;
end;

procedure TfrmPedido.AtualizaGridItensPedido(const ItensPedido: TItensPedido);
var
   AItemPedido: TItemPedido;
begin
   memItensPedido.DisableControls;
   memItensPedido.EmptyDataSet;
   for AItemPedido in ItensPedido do
      begin
         memItensPedido.Append;
         memItensPedido.FieldByName('id').AsInteger := AItemPedido.Id;
         memItensPedido.FieldByName('numero_pedido').AsInteger := fPedido.Numero;
         memItensPedido.FieldByName('codigo_produto').AsInteger := AItemPedido.Produto.Codigo;
         memItensPedido.FieldByName('descricao_produto').AsString := AItemPedido.Produto.Descricao;
         memItensPedido.FieldByName('quantidade').AsInteger := AItemPedido.Quantidade;
         memItensPedido.FieldByName('valor_unitario').AsFloat := AItemPedido.ValorUnitario;
         memItensPedido.FieldByName('valor_total').AsFloat := AItemPedido.ValorTotal;
         memItensPedido.Post;
      end;
   memItensPedido.EnableControls;
end;

procedure TfrmPedido.edtCodigoClienteChange(Sender: TObject);
begin
   if TEdit(Sender).Text = '' then
      OcultaControles;
   actBuscarPedido.Enabled := TEdit(Sender).Text = '';
   actCancelarPedido.Enabled := TEdit(Sender).Text = '';
   actGravarPedido.Enabled := False;
end;

procedure TfrmPedido.edtCodigoClienteEnter(Sender: TObject);
begin
   KeyPreview := False;
   TEdit(Sender).Text := '';
end;

procedure TfrmPedido.edtCodigoClienteExit(Sender: TObject);
begin
   KeyPreview := True;
end;

procedure TfrmPedido.edtCodigoClienteKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      begin
         if TEdit(Sender).Text <> '' then
            begin
               fCliente := fController
                              .Entidades
                              .Cliente
                              .Find(StrToInt(TEdit(Sender).Text));

               if not Assigned(fCliente) then
                 begin
                    OcultaControles;
                    ShowMessage('Cliente não encontrado!');
                    TEdit(Sender).Text := '';
                    Exit;
                 end;

               frameCliente.Inicializa(fCliente);

               fPedido := fController
                              .Entidades
                              .Pedido
                              .Find(fCliente);

               ExibePedidoDados;

               AtualizaGridItensPedido(fPedido.Itens);

               edtPedidoValorTotal.Text := Format('%.2f',[fPedido.ValorTotal]);

               ExibeControles;

               frameItemPedido.edtProdutoCodigo.Enabled := True;

               FocusControl(frameItemPedido.edtProdutoCodigo);
            end;
      end;
end;

procedure TfrmPedido.edtCodigoClienteKeyPress(Sender: TObject; var Key: Char);
begin
   if not CharInSet(Key, ['0'..'9', #8]) then
      Key := #0;
end;

procedure TfrmPedido.ExibeClienteDados;
begin
   frameCliente.Inicializa(fCliente);
end;

procedure TfrmPedido.ExibeControles;
begin
   frameCliente.Visible := True;
   lblPedidoNumero.Visible := True;
   edtPedidoNumero.Visible := True;
   lblPedidoDataEmissao.Visible := True;
   edtPedidoDataEmissao.Visible := True;
   panItensPedido.Visible := True;
end;

procedure TfrmPedido.ExibePedidoDados;
begin
   edtPedidoNumero.Text := 'NOVO';
   edtPedidoDataEmissao.Text := DateTimeToStr(Now());
   if Assigned(fPedido) then
      begin
         edtPedidoNumero.Text := fPedido.Numero.ToString;
         edtPedidoDataEmissao.Text := DateTimeToStr(fPedido.DataEmissao);
         AtualizaGridItensPedido(fPedido.Itens);
      end;
end;

procedure TfrmPedido.ExibeProdutoDados;
begin
   if Assigned(fProduto) then
      begin
         frameItemPedido.SetProdutoDescricao(fProduto.Descricao);
         frameItemPedido.SetProdutoValorUnitario(fProduto.PrecoVenda);
         frameItemPedido.ExibeControles;
      end;
end;

procedure TfrmPedido.FormCreate(Sender: TObject);
begin
   fController := TController.GetInstance;
end;

procedure TfrmPedido.FormDestroy(Sender: TObject);
begin
   if Assigned(fCliente) then
      FreeAndNil(fCliente);
   if Assigned(fProduto) then
      FreeAndNil(fProduto);
   if Assigned(fPedido) then
      FreeAndNil(fPedido);
end;

procedure TfrmPedido.FormKeyPress(Sender: TObject; var Key: Char);
begin
   if key = #9 then
      begin
         Key := #0;
         Perform(WM_NEXTDLGCTL, 0, 0);
      end;
end;

procedure TfrmPedido.FormShow(Sender: TObject);
begin
   actGravarPedido.Enabled := False;

   frameItemPedido.OcultaControles;

   OcultaControles;

   memItensPedido.CreateDataSet;

   FocusControl(edtCodigoCliente);
end;

procedure TfrmPedido.frameItemPedidobtnConfirmarClick(Sender: TObject);
begin
   if not Assigned(fPedido) then
      begin
         fPedido := TPedido.Create;
         fPedido.Numero := -1;
         fPedido.DataEmissao := StrToDateTime(edtPedidoDataEmissao.Text);
         fPedido.Cliente := TCliente.FromCliente(fCliente);
      end;
   fItemPedido.Quantidade := StrToInt(frameItemPedido.edtProdutoQuantidade.Text);
   fItemPedido.ValorUnitario := StrToFloat(frameItemPedido.edtProdutoValorUnitario.Text);
   fPedido.RegistraItemVendido(fItemPedido);
   AtualizaGridItensPedido(fPedido.Itens);
   edtPedidoValorTotal.Text := Format('%.2f',[fPedido.ValorTotal]);
   actGravarPedido.Enabled := True;
   fItemPedido := Nil;
end;

procedure TfrmPedido.frameItemPedidoedtProdutoCodigoKeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
   if Key = VK_RETURN then
      begin
         if TEdit(Sender).Text <> '' then
            begin
               fProduto := fController
                              .Entidades
                              .Produto
                              .Find(StrToInt(TEdit(Sender).Text));

               if not Assigned(fProduto) then
                 begin
                    ShowMessage('Produto não encontrado!');
                    TEdit(Sender).Text := '';
                    Exit;
                 end;
               fItemPedido := TItemPedido.Create;
               fItemPedido.Id := -1;
               fItemPedido.Produto := TProduto.FromProduto(fProduto);
               fItemPedido.Quantidade := 1;
               fItemPedido.ValorUnitario := fProduto.PrecoVenda;
               frameItemPedido.Inicializa(fItemPedido);
               FocusControl(frameItemPedido.edtProdutoQuantidade);
          end;
      end;
end;

procedure TfrmPedido.grdItensPedidoKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if Key = VK_RETURN then
      begin
         fItemPedido := TItemPedido.Create;
         with TDBGrid(Sender).DataSource do
            begin
               fItemPedido.Id := DataSet.FieldByName('id').AsInteger;
               fItemPedido.Produto := TProduto.FromProduto(fController.Entidades.Produto.Find(DataSet.FieldByName('codigo_produto').AsInteger));
               fItemPedido.Quantidade := DataSet.FieldByName('quantidade').AsInteger;
               fItemPedido.ValorUnitario := DataSet.FieldByName('valor_unitario').AsFloat;
            end;
         frameItemPedido.Inicializa(fItemPedido);
      end;
   // Teclou DEL
   if Key = VK_DELETE then
      begin
         fItemPedido := TItemPedido.Create;
         with TDBGrid(Sender).DataSource do
            begin
               fItemPedido.Id := DataSet.FieldByName('id').AsInteger;
               fItemPedido.Produto := TProduto.FromProduto(fController.Entidades.Produto.Find(DataSet.FieldByName('codigo_produto').AsInteger));
               fItemPedido.Quantidade := DataSet.FieldByName('quantidade').AsInteger;
               fItemPedido.ValorUnitario := DataSet.FieldByName('valor_unitario').AsFloat;
            end;
         if MessageDlg('Deseja realmente excluir o item ' + fItemPedido.Produto.Descricao + ' do pedido ?', TMsgDlgType.mtConfirmation, [TMsgDlgBtn.mbYes, TMsgDlgBtn.mbNo], 0, TMsgDlgBtn.mbNo) = mrYes then
            begin

            end;
      end;
end;

procedure TfrmPedido.memItensPedidoAfterScroll(DataSet: TDataSet);
begin
   if Assigned(fItemPedido) then
      begin
         fItemPedido := nil;
         frameItemPedido.Inicializa(nil);
      end;
end;

procedure TfrmPedido.OcultaControles;
begin
   frameCliente.Visible := False;
   lblPedidoNumero.Visible := False;
   edtPedidoNumero.Visible := False;
   lblPedidoDataEmissao.Visible := False;
   edtPedidoDataEmissao.Visible := False;
   panItensPedido.Visible := False;
end;

end.
