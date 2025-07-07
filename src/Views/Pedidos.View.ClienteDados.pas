unit Pedidos.View.ClienteDados;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs,
  Vcl.ExtCtrls, Vcl.StdCtrls, Vcl.Mask, Vcl.DBCtrls,
  Pedidos.Classe.Cliente;

type
  TframeClienteDados = class(TFrame)
    panClienteDados: TPanel;
    lblClienteNome: TLabel;
    lblClienteCidade: TLabel;
    lblClienteUF: TLabel;
    lblTituloClienteDados: TLabel;
    edtClienteNome: TEdit;
    edtClienteCidade: TEdit;
    edtClienteUF: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure Inicializa(const Cliente: TCliente);
    procedure SetNome(const Value: String);
    procedure SetCidade(const Value: String);
    procedure SetUF(const Value: String);
  end;

implementation

{$R *.dfm}

{ TframeClienteDados }

procedure TframeClienteDados.Inicializa(const Cliente: TCliente);
begin
   edtClienteNome.Text := '';
   edtClienteCidade.Text := '';
   edtClienteUF.Text := '';
   if Assigned(Cliente) then
      begin
         edtClienteNome.Text := Cliente.Nome;
         edtClienteCidade.Text := Cliente.Cidade;
         edtClienteUF.Text := Cliente.UF;
      end;
end;

procedure TframeClienteDados.SetCidade(const Value: String);
begin
   edtClienteCidade.Text := Value;
end;

procedure TframeClienteDados.SetNome(const Value: String);
begin
   edtClienteNome.Text := Value;
end;

procedure TframeClienteDados.SetUF(const Value: String);
begin
   edtClienteUF.Text := Value;
end;

end.
