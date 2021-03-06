program Project2;

{$APPTYPE CONSOLE}

uses
{$IFDEF LINUX} Libc, {$ENDIF}
   IniFiles,
  SysUtils,
  StrUtils,
  IdComponent,
  Classes,
  IdTCPServer,
  IdGlobal,
  IdBaseComponent,
  IdThreadMgr,
  IdThreadMgrDefault,
  IdThreadMgrPool,
  IdIntercept,
  IdIOHandlerSocket,
  IdCustomHTTPServer,
  idSocketHandle, SyncObjs,
  ZConnection, ZAbstractRODataset, ZAbstractDataset, ZDataset,
  {$IFDEF MSWINDOWS} FileCtrl, {$ENDIF}
   IdStack;

  type
  TSettings = record
     host:shortstring;
     port:shortstring;
     user:shortstring;
     pass:shortstring;
     proto:shortstring;
     db:shortstring;
  end;


type
  TSimpleClient = class(TObject)
    DNS,
    Name        : String;
    ListLink    : Integer;
    Thread      : Pointer;
  end;



type 
  TAuthServer = class(TObject)
    tcpServer: TIdTCPServer;
    HandlerSocket: TIdIOHandlerSocket; 
   constructor create;
  private
    function  activateServer (VAR Component: TIdTCPServer; Port: word): boolean;
    procedure commandohandler(com,msg:string;AThread: TidPeerThread);
    procedure ServerConnect(AThread: TidPeerThread);
    procedure ServerDisconnect(AThread: TidPeerThread);
    procedure ServerExecute(AThread: TidPeerThread);
  public
    Clients  : TList;
  end;



 var
 AuthServer :TAuthServer;
 Query: TZQuery;
 Connection :TZConnection;
 ini : TIniFile;
 dbhost,dbuser,dbpass,dbproto,dbport,dbank:string;

procedure read_ini;
begin
ini:= TIniFile.Create(ExtractFilePath(Paramstr(0))+ 'settings.ini');
dbhost:=ini.ReadString('daten','host','');
dbuser:=ini.ReadString('daten','user','');
dbpass:=ini.ReadString('daten','passwort','');
dbproto:=ini.ReadString('daten','proto','');
dbport:=ini.ReadString('daten','port','');
dbank:=ini.ReadString('daten','datenbank','');
end;





constructor TAuthServer.Create;
begin
inherited Create;
  HandlerSocket := TidIOHandlerSocket.Create(HandlerSocket);
  tcpServer := TIdTCPServer.Create(tcpServer);
  Clients := TList.Create;
  with tcpServer do
  begin
    OnConnect    := ServerConnect;
    OnDisconnect := ServerDisconnect;
    OnExecute    := ServerExecute;
  end;
end;






function TAuthServer.activateServer (VAR Component: TIdTCPServer; Port: word): boolean;
begin 
  with Component do 
  begin 
    active := false;
    Bindings.Clear;
    DefaultPort := Port; 
    Bindings.DefaultPort := Port; 
    Bindings.Add; 
    Active := true; 
  end; 
end;

procedure TAuthServer.ServerConnect(AThread: TidPeerThread);
var
  Client : TSimpleClient;
begin
  Client := TSimpleClient.Create;
  Client.DNS  := AThread.Connection.LocalName;
  Client.Name := 'ohne';
  Client.Thread := AThread;
  AThread.Data := Client;
  Clients.Add(Client);
  AThread.Connection.WriteLn('000010|');
  writeln('verbunden '+Client.Name);
end;

procedure TAuthServer.commandohandler(com,msg:string;AThread: TidPeerThread);
begin
writeln('Commando >'+com);
writeln('Message >'+msg);
if com = '000010' then begin
//rzrichedit1.Lines.Add('Commando > Login');
//TCPClient.WriteLn('000012|'+useredit.Text+'|'+passedit.Text);
exit;
end;
 end;


procedure TAuthServer.ServerExecute(AThread: TidPeerThread);
var
  Client : TSimpleClient;
  Com,     // System command
  Msg    : String;
begin
  Msg    := AThread.Connection.ReadLn;
  Client := Pointer(AThread.Data);
  if Client.Name = 'ohne' then
    begin
      AThread.Connection.WriteLn('000020|');
    { if not, assign the name and announce the client }
      Client.Name := Msg;
      writeln('connect'+client.dns);
      //BroadcastMessage('System', Msg + ' has just logged in.');
      //AThread.Connection.WriteLn(memEntry.Lines.Text);
    end
  else
      Com := Copy(Msg, 1, Pos('|', Msg) -1);
      Msg := Copy(Msg, Pos('|', Msg) +1, Length(Msg));

      commandohandler(trim(com),msg,client.Thread);

end;

procedure TAuthServer.ServerDisconnect(AThread: TidPeerThread); 
var
  Client : TSimpleClient;
begin
  Client := Pointer(AThread.Data);
  Clients.Delete(Client.ListLink);
  Client.Free;
  AThread.Data := nil;
end;


begin
  read_ini;
  Connection :=TZConnection.Create(nil);
  Connection.HostName:=dbhost;
  Connection.Port:=strtoint(dbport);
  Connection.User:=dbuser;
  Connection.Password:=dbpass;
  Connection.Protocol:=dbproto;
  Connection.Database:=dbank;
  Query:= TZQuery.Create(nil);
  Query.Connection:=Connection;
  AuthServer:= TAuthServer.Create;
  if AuthServer.activateServer(AuthServer.TCPServer, 300)
    then begin
           writeln('Auth-Server Port: '
                    +inttostr(AuthServer.TCPServer.Defaultport));
         end;

       
readln;
  { TODO -oUser -cConsole Main : Hier Code einf�gen }
end.
