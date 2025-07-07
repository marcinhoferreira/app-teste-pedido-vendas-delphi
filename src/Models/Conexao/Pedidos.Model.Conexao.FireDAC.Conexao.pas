unit Pedidos.Model.Conexao.FireDAC.Conexao;

interface

uses
  SysUtils, Classes, Data.DB,
  Pedidos.Model.Conexao.Interfaces,
  FireDAC.Stan.Intf, FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf,
  FireDAC.Phys.Intf, FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async,
  FireDAC.Phys, FireDAC.ConsoleUI.Wait, FireDAC.Comp.Client, FireDAC.Comp.DataSet,
  FireDAC.Phys.MySQLDef, FireDAC.Phys.MySQL;

type
   TModelConexaoFireDACConexao = class(TInterfacedObject, IModelConexao)
   private
      { Private declarations }
      fDriverLink: TFDPhysDriverLink;
      fConexao: TFDConnection;
      procedure CarregaConfiguracao;
      procedure GravaConfiguracao;
   protected
      { Protected declarations }
   public
      { Public declarations }
      constructor Create;
      destructor Destroy; override;
      class function New: IModelConexao;
      function Conexao: TFDConnection;
   end;

implementation

uses
   System.IOUtils, System.IniFiles;

{ TModelConexaoFireDACConexao }

function TModelConexaoFireDACConexao.Conexao: TFDConnection;
begin
   Result := fConexao;
end;

procedure TModelConexaoFireDACConexao.CarregaConfiguracao;
var
   AConfiguracao: TIniFile;
begin
   AConfiguracao := TIniFile.Create('./conexao.ini');
   try
      // Configurando o compoente de conexão
      with fConexao do
         begin
            ConnectedStoredUsage := ConnectedStoredUsage - [auDesignTime, auRunTime];
            Params.DriverID := 'MySQL';
            Params.Values['Server'] := AConfiguracao.ReadString('DB', 'Server', '127.0.0.1');
            Params.Values['Port'] := IntToStr(AConfiguracao.ReadInteger('DB', 'Port', 3306));
            Params.DataBase := AConfiguracao.ReadString('DB', 'Database', 'teste_wk');
            Params.UserName := AConfiguracao.ReadString('DB', 'Username', 'root');
            Params.Password := AConfiguracao.ReadString('DB', 'Password', 'Le@l#3101');
         end;
      // Caminho da biblioteca de acesso ao banco de dados
      fDriverLink.VendorHome := AConfiguracao.ReadString('DB', 'LibraryPath', ExtractFilePath(ParamStr(0)));
   finally
      FreeAndNil(AConfiguracao);
   end;
end;

constructor TModelConexaoFireDACConexao.Create;
begin
   // MySQL driver link
   fDriverLink := TFDPhysMySQLDriverLink.Create(Nil);
   // Connection create
   fConexao := TFDConnection.Create(Nil);
   with fConexao do
      begin
         try
            CarregaConfiguracao;
            Connected := True;
         except
            on E: Exception do
               raise Exception.Create('Erro ao tentar estabelecer uma conexão com servidor ' + Params.Values['Server'] + ':'#10 + E.Message);
         end;
      end;
   if fConexao.Connected then
      GravaConfiguracao;
end;

destructor TModelConexaoFireDACConexao.Destroy;
begin
   FreeAndNil(fConexao);
   FreeAndNil(fDriverLink);
   inherited;
end;

procedure TModelConexaoFireDACConexao.GravaConfiguracao;
var
   AConfiguracao: TIniFile;
begin
   AConfiguracao := TIniFile.Create('./conexao.ini');
   try
      with fConexao do
         begin
            AConfiguracao.WriteString('DB', 'Server', Params.Values['Server']);
            AConfiguracao.WriteInteger('DB', 'Port', StrToIntDef(Params.Values['Port'], 3306));
            AConfiguracao.WriteString('DB', 'Database', Params.DataBase);
            AConfiguracao.WriteString('DB', 'Username', Params.UserName);
            AConfiguracao.WriteString('DB', 'Password', Params.Password);
            AConfiguracao.WriteString('DB', 'LibraryPath', fDriverLink.VendorHome);
         end;
   finally
      FreeAndNil(AConfiguracao);
   end;
end;

class function TModelConexaoFireDACConexao.New: IModelConexao;
begin
   Result := Create;
end;

end.
