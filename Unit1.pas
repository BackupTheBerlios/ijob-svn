unit Unit1;

interface

uses
  Windows,uxtheme,Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, jpeg, ExtCtrls, StdCtrls, RzLabel,
  RzStatus,NB30, RzBckgnd,uPlugInDefinition, RzPanel,
  JvExControls, JvComponent, JvXPCore, JvXPBar, RzLine, JvXPContainer,
  JvNavigationPane, RzLstBox, ComCtrls,JvExComCtrls, JvListView, ImgList,
  JvGIF, Unit3, RzTreeVw, RzButton, Mask,
  RzEdit, RzCmboBx, JvExStdCtrls, JvHtControls,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,kompo,psapi,Math,
  IdIOHandlerSocket,IdException, JvListBox, JvComboListBox, JvInstallLabel,
  RzPrgres, IdIntercept, IdIOHandler, RzTray, RzForms, RzCommon, DB,
  ZAbstractRODataset, ZAbstractDataset,ZDataset, ZConnection;





type
  TLibrary_A = record
    Handle: Cardinal;
    PlugIn: TPlugIn;
    MenuItem: TMenuItem;
    meine:tHandle;
  end;
type
  Tmainform = class(TForm)
    RzStatusBar1: TRzStatusBar;
    RzClockStatus1: TRzClockStatus;
    RzPanel1: TRzPanel;
    RzLabel1: TRzLabel;
    RzLabel2: TRzLabel;
    MainMenu: TMainMenu;
    jkhj1: TMenuItem;
    hkhjkh1: TMenuItem;
    hjkh1: TMenuItem;
    Pane1: TRzStatusPane;
    RzPanel3: TRzPanel;
    RzSeparator1: TRzSeparator;
    tree: TRzTreeView;
    RzPanel2: TRzPanel;
    ImageList1: TImageList;
    RzPanel4: TRzPanel;
    RzPanel5: TRzPanel;
    RzPanel6: TRzPanel;
    RzLine1: TRzLine;
    RzPanel7: TRzPanel;
    RzLine2: TRzLine;
    RzListBox1: TRzListBox;
    RzLabel7: TRzLabel;
    RzPanel8: TRzPanel;
    RzLine3: TRzLine;
    Status1: TRzGlyphStatus;
    TCPClient: TIdTCPClient;
    JvXPBar1: TJvXPBar;
    RzLabel3: TRzLabel;
    Beenden1: TMenuItem;
    Arbeitgeber1: TMenuItem;
    ermine1: TMenuItem;
    Neu1: TMenuItem;
    Anzeigen1: TMenuItem;
    Anzeigen2: TMenuItem;
    Suchen1: TMenuItem;
    IniFile: TRzRegIniFile;
    RzFormState1: TRzFormState;
    RzTrayIcon1: TRzTrayIcon;
    PopupMenu2: TPopupMenu;
    ffnen1: TMenuItem;
    Beenden2: TMenuItem;
    ImageList2: TImageList;
    RzPanel9: TRzPanel;
    RzBitBtn1: TRzBitBtn;
    RzBitBtn2: TRzBitBtn;
    useredit: TRzEdit;
    RzLabel4: TRzLabel;
    RzLabel5: TRzLabel;
    passedit: TRzMaskEdit;
    Timer1: TTimer;
    Timer2: TTimer;
    Pane2: TRzStatusPane;
    IdIOHandlerSocket1: TIdIOHandlerSocket;
    IdConnectionIntercept1: TIdConnectionIntercept;
    RzPanel10: TRzPanel;
    Memo1: TMemo;
    ProgressBar: TRzProgressBar;
    RzBitBtn3: TRzBitBtn;
    mysqlcon: TZConnection;
    mQuery: TZQuery;
    workimages: TImageList;
    procedure lade_tree;
    procedure FormCreate(Sender: TObject);
    procedure Beenden1Click(Sender: TObject);
    procedure Suchen1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ffnen1Click(Sender: TObject);
    procedure Beenden2Click(Sender: TObject);
    procedure set_offline;
    procedure set_online;
    procedure ladesettings;
    procedure RzBitBtn1Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure TCPClientConnected(Sender: TObject);
    procedure RzBitBtn2Click(Sender: TObject);
    procedure TCPClientDisconnected(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure commandohandler(com,msg:string);
    procedure RzBitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure leeretmp;
  private
    FTime: Longword;
    FBytes: Longword;
    APlugIns: array of TLibrary_A;
    procedure AReloadPluginTexts(Sender: TObject);
    procedure AExecutePlugIn(Sender: TObject);
    procedure ALoadPlugin(DLLName: string);
    procedure ALoadPlugIns;
    procedure AUnloadPlugIns;
    function ARunEvent(EventNotification: TEventNotification): Boolean;
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;


var
  mainform: Tmainform;
  CpuUsage1: TCpuUsage;
  mac:shortstring;
  user,offline,online,oonline,ooffline:tTreeNode;
  Serverhost,Serverport,Username,Passwort:shortstring;
  mhost,muser,mpass,mport,mproto,mdb:shortstring;


implementation

uses IniFiles, Unit2;

{$R *.dfm}


function ProgramVersion : string;
const
   InfoNum = 1;
   InfoStr : array[1..InfoNum] of string = ('FileVersion');
var
   S: string;
   n, Len, i: DWORD;
   Buf: PChar;
   Value: PChar;
begin
   S := Application.ExeName;
   n := GetFileVersionInfoSize(PChar(S), n);
   if n > 0 then
   begin

     Buf := AllocMem(n);
     GetFileVersionInfo(PChar(S), 0, n, Buf);
     for i := 1 to InfoNum do
       if VerQueryValue(Buf, PChar('StringFileInfo\040704E4\' + InfoStr[i]), Pointer(Value), Len) then
          result := result + Value;
     FreeMem(Buf, n);
   end;
end;
  function GetAdapterInfo(Lana: Char): String;
var
  Adapter: TAdapterStatus;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBRESET);
  NCB.ncb_lana_num := Lana;
  if Netbios(@NCB) <> Char(NRC_GOODRET) then 
  begin
    Result := 'mac not found'; 
    Exit;
  end; 

  FillChar(NCB, SizeOf(NCB), 0); 
  NCB.ncb_command := Char(NCBASTAT);
  NCB.ncb_lana_num := Lana;
  NCB.ncb_callname := '*';

  FillChar(Adapter, SizeOf(Adapter), 0);
  NCB.ncb_buffer := @Adapter;
  NCB.ncb_length := SizeOf(Adapter);
  if Netbios(@NCB) <> Char(NRC_GOODRET) then
  begin
    Result := 'mac not found';
    Exit;
  end;
  Result :=
    IntToHex(Byte(Adapter.adapter_address[0]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[1]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[2]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[3]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[4]), 2) + '-' +
    IntToHex(Byte(Adapter.adapter_address[5]), 2);
end;

function GetMACAddress: string;
var
  AdapterList: TLanaEnum;
  NCB: TNCB;
begin
  FillChar(NCB, SizeOf(NCB), 0);
  NCB.ncb_command := Char(NCBENUM);
  NCB.ncb_buffer := @AdapterList;
  NCB.ncb_length := SizeOf(AdapterList);
  Netbios(@NCB);
  if Byte(AdapterList.length) > 0 then
    Result := GetAdapterInfo(AdapterList.lana[0])
  else
    Result := 'mac not found';
end;

procedure Tmainform.lade_tree;
begin
user:=tree.Items.AddChild(nil,'Mitarbeiter');
user.ImageIndex:=3;
user.SelectedIndex:=3;
online:=tree.Items.AddChild(user,'Online');
online.ImageIndex:=1;
online.SelectedIndex:=1;
offline:=tree.Items.AddChild(user,'Offline');
offline.ImageIndex:=0;
offline.SelectedIndex:=0;
tree.FullExpand;
end;

procedure Tmainform.ladesettings;
begin
Serverhost:=inifile.ReadString('Server','Host','');
Serverport:=inifile.ReadString('Server','Port','');
end;

procedure Tmainform.leeretmp;
begin
mhost:='';
muser:='';
mpass:='';
mport:='';
mproto:='';
mdb:='';
end;


procedure Tmainform.FormCreate(Sender: TObject);
begin
leeretmp;
inifile.Path:=ExtractFilePath(ParamStr(0))+'system.ini';
RzFormState1.RegIniFile.Path :=ExtractFilePath(ParamStr(0))+'system.ini';
CpuUsage1 := TCpuUsage.Create;
Timer2.Enabled := true;
RzFormState1.RestoreState;
SetLength(APlugIns, 0);
ALoadPlugIns;
mac:=GetMACAddress;
tree.Items.Clear;
lade_tree;
set_offline;


end;



 procedure Tmainform.AExecutePlugIn(Sender: TObject);
begin
  if Sender = nil then
    Exit;
  if not (Sender is TMenuItem) then
    Exit;
  if APlugIns[TMenuItem(Sender).Tag].PlugIn <> nil then
    APlugIns[TMenuItem(Sender).Tag].PlugIn.Execute;

end;




procedure Tmainform.ALoadPlugin(DLLName: string);
var
  TempHandle: Cardinal;
  ProcAddr: Pointer;
  LoadPlugInProc: TLoadPlugIn;
  TempPlugIn: TPlugIn;
begin
  // is the a full location given?
  if not ((Copy(DLLName, 2, 1) = ':') or (Copy(DLLName, 1, 2) = '\\')) then
    // no, append to own folder
    DLLName := ExtractFilePath(Application.ExeName) + DLLName;
  // load library
  TempHandle := LoadLibrary(PChar(DLLName));
  if (TempHandle <> INVALID_HANDLE_VALUE) and (TempHandle <> 0) then
  begin
    // library loaded, load register function
    ProcAddr := GetProcAddress(TempHandle, 'LoadPlugIn');
    if ProcAddr = nil then
    begin
      // register function not exported
      FreeLibrary(TempHandle);
      Exit;
    end;
    LoadPlugInProc := TLoadPlugIn(ProcAddr);
    try
      TempPlugIn := nil;
      LoadPlugInProc(rzpanel3.Handle, TempPlugIn);
    except
      // register function invalid
      FreeLibrary(TempHandle);
      Exit;
    end;
    // add to array of plug-ins
    SetLength(APlugIns, Succ(Length(APlugIns)));
    APlugIns[High(APlugIns)].Handle := TempHandle;
    // test for plug-in object
    if TempPlugIn <> nil then
    begin
      // plug-in object exists, add to menü
      APlugIns[High(APlugIns)].PlugIn := TempPlugIn;
      APlugIns[High(APlugIns)].MenuItem := TMenuItem.Create(MainMenu);
      APlugIns[High(APlugIns)].MenuItem.Caption := TempPlugIn.GetMenuText;
      APlugIns[High(APlugIns)].MenuItem.Enabled := TempPlugIn.GetEnabled;
      APlugIns[High(APlugIns)].MenuItem.Tag := High(APlugIns);
      APlugIns[High(APlugIns)].MenuItem.OnClick := AExecutePlugIn;
      mainmenu.Items.Add(APlugIns[High(APlugIns)].MenuItem);
    end else begin
      // plug-in does not exist
      APlugIns[High(APlugIns)].PlugIn := nil;
      APlugIns[High(APlugIns)].MenuItem := nil;
    end;
  end;
end;

procedure Tmainform.ALoadPlugIns;
var
  I: Integer;
  PlugInRegistryFile: String;
  IniFile: TIniFile;
  PlugIns: TStringList;
begin
  PlugInRegistryFile := ExtractFilePath(Application.ExeName) + 'system.ini';
  if not FileExists(PlugInRegistryFile) then
    Exit;
  IniFile := TIniFile.Create(PlugInRegistryFile);
  try
    PlugIns := TStringList.Create;
    try
      IniFile.ReadSections(PlugIns);
      for I := 0 to Pred(PlugIns.Count) do
      begin
        // check section type to be "plugin"
        if AnsiCompareText(IniFile.ReadString(PlugIns[I], 'type', ''),
            'plugin') = 0 then
        begin
          // load plug-in
          ALoadPlugin(IniFile.ReadString(PlugIns[I], 'dllname', ''));
        end;
      end;
    finally
      PlugIns.Free;
    end;
  finally
    IniFile.Free;
  end;
end;

 procedure Tmainform.AUnloadPlugIns;
var
  I: Integer;
begin
  if Length(APlugIns) > 0 then
  begin
    for I := 0 to Pred(Length(APlugIns)) do
    try
      if APlugIns[I].MenuItem <> nil then
        APlugIns[I].MenuItem.Free;
      if APlugIns[I].PlugIn <> nil then
        APlugIns[I].PlugIn.Free;
      FreeLibrary(APlugIns[I].Handle);
    except
    end;
    SetLength(APlugIns, 0);
  end;
end;

 function Tmainform.ARunEvent(EventNotification: TEventNotification): Boolean;
var
  I: Integer;
begin
  for I := 0 to High(APlugIns) do
    if APlugIns[I].PlugIn <> nil then
    begin
      if APlugIns[I].PlugIn.EventHandler(EventNotification) = evnAbort then
      begin
        Result := False;
        Exit;
      end;
    end;
    Result := True;
end;
procedure Tmainform.AReloadPluginTexts(Sender: TObject);
var
  I: Integer;
begin
  for I := 0 to High(APlugIns) do
  begin
    if (APlugIns[I].MenuItem <> nil) and (APlugIns[I].PlugIn <> nil) then
    begin
      APlugIns[I].MenuItem.Caption := APlugIns[I].PlugIn.GetMenuText;
      APlugIns[I].MenuItem.Enabled := APlugIns[I].PlugIn.GetEnabled;
    end;
  end;
end;
procedure Tmainform.Beenden1Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.Suchen1Click(Sender: TObject);
begin
  
form2.ParentWindow:=rzpanel3.Handle;
form2.Show
end;

procedure Tmainform.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  RzFormState1.SaveState;
   timer2.Enabled := false; 
  CpuUsage1.Free;
end;

procedure Tmainform.ffnen1Click(Sender: TObject);
begin
 RzTrayIcon1.RestoreApp;
end;

procedure Tmainform.Beenden2Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.set_online;
var
i:integer;
begin
status1.ImageIndex:=1;
status1.Caption:='Online';
RzBitBtn1.Enabled:=false;
RzBitBtn2.Enabled:=true;
useredit.Enabled:=false;
passedit.Enabled:=false;
for i:=0 to MainMenu.Items.count -1 do begin
MainMenu.Items[i].Enabled:=true;
end;

end;

procedure Tmainform.set_offline;
var
i:integer;
begin
  status1.ImageIndex:=0;
  status1.Caption:='Offline';
  timer1.Enabled:=false;
  RzBitBtn1.Enabled:=true;
  RzBitBtn2.Enabled:=false;
  useredit.Enabled:=true;
  passedit.Enabled:=true;

  for i:=0 to MainMenu.Items.count -1 do begin
MainMenu.Items[i].Enabled:=false;
end;
end;

procedure Tmainform.RzBitBtn1Click(Sender: TObject);
begin
if useredit.Text = '' then begin
   showmessage('Keinen Benutzername eingetragen !');
   exit;
   end;
if passedit.Text = '' then begin
   showmessage('Keinen Passwort eingetragen !');
   exit;
   end;
ladesettings;
  timer1.Enabled:=true;
  TCPClient.Host:=serverhost;
  TCPClient.Port:=strtoint(serverport);
  tcpclient.Connect();

end;
{  E = Empfang  S = Senden
--- 000001 - 000009  Key Handling ---
 E 000001 -> S 000002|MAC|
 E 000003 -> Computer Unbekannt
 E 000004 -> Computer Gesperrt
 E 000005 -> Computer OK

--- 000010 - 000025  Login Verhandlungen ---
 E 000010  -> S 000011|User|Passwort|
 E 000012 Benutzer Unbekannt -> Message
 E 000013 Passwort Falsch  -> Message
 E 000020 Login OK

--- 000030 - 000035  Datenbank Zugangsdaten ---

--- 000040 - 000055  Messagesystem ---

--- 000060 - 000075  Datei Transfer ---

--- 000080 - 000085  Mail Transfer ---

--- 000090 - 000200  Rechte Anfragen ---

000210 - ..


}

procedure Tmainform.commandohandler(com,msg:string);
begin
memo1.Lines.add('Commando >'+com);
memo1.Lines.add('Message >'+msg);
// Login
if com = '000010' then begin
TCPClient.WriteLn('000012|'+useredit.Text+'|'+passedit.Text);
exit;
end;
if com = '000011' then begin
showmessage('Benutzer unbekannt!');
exit;
end;
if com = '000012' then begin
showmessage('Passwort Falsch!');
exit;
end;

if com = '000020' then begin
set_online;
exit;
end;

// Datenbank Zugangsdaten
if com = '000030' then begin
mhost:=msg;
exit;
end;
if com = '000031' then begin
mport:=msg;
exit;
end;
if com = '000032' then begin
muser:=msg;
exit;
end;
if com = '000033' then begin
mpass:=msg;
exit;
end;
if com = '000034' then begin
mproto:=msg;
exit;
end;
if com = '000035' then begin
mdb:=msg;
exit;
end;




end;


procedure Tmainform.Timer1Timer(Sender: TObject);
var
  Com,
  Msg : String;
begin

  try
  if not TcpClient.Connected then
    exit;
  // TCPClient.WriteLn('fdsfsdfsdfddddddddddddddddddddddddddddddddddddddddddddd');
  Msg := TCPClient.ReadLn('', 5);

  if Msg <> '' then begin
      begin
        //rzrichedit1.Lines.Add('debug >'+msg);
      { System command }
        Com := Copy(Msg, 1, Pos('|', Msg) -1);
        Msg := Copy(Msg, Pos('|', Msg) +1, Length(Msg));
          if com <> '' then
          commandohandler(trim(com),msg);
      end;

     end;
    except
  on E:EIdSocketError do
   set_offline;
   end;
  // jetzt machen wir hier was 


end;

procedure Tmainform.TCPClientConnected(Sender: TObject);
begin
 RzBitBtn1.Enabled:=false;
RzBitBtn2.Enabled:=true;
useredit.Enabled:=false;
passedit.Enabled:=false;

end;

procedure Tmainform.RzBitBtn2Click(Sender: TObject);
begin
  tcpclient.Disconnect;
end;

procedure Tmainform.TCPClientDisconnected(Sender: TObject);
begin
    timer1.Enabled:=false;
   RzBitBtn1.Enabled:=true;
  RzBitBtn2.Enabled:=false;
  useredit.Enabled:=true;
  passedit.Enabled:=true;
  set_offline;
end;

function GetWorkingSetSize : integer;
var 
  pmc: PPROCESS_MEMORY_COUNTERS; 
  cb: Integer; 
begin 
  cb := SizeOf(_PROCESS_MEMORY_COUNTERS); 
  GetMem(pmc, cb); 
  pmc^.cb := cb; 
  if(GetProcessMemoryInfo(GetCurrentProcess, pmc, cb))then
    result := pmc^.WorkingSetSize
  else
    result := -1; 
  FreeMem(pmc); 
end;

 function ConvertByte(BytesCount:Int64; Short:Boolean):String;
//BytesCount: Anzahl der Bytes
//Short: Falls TRUE wird die Einheit in Kurzform, sonst in voller Schreibweise zurückgegeben.
const 
    ByteShortUnits:array[0..8] of String = ('B', 'KB', 'MB', 'GB', 'TB', 'PB', 'EB', 'ZB', 'YB'); 
    ByteLongUnits:array[0..8] of String = ('Byte', 'KiloByte', 'MegaByte', 
        'GigaByte', 'TeraByte', 'PetaByte', 'ExaByte', 'ZettaByte', 'YottaByte'); 
var 
    cc:Integer; 
    OutputUnit:String; 
begin 
    for cc:=1 to Length(ByteShortUnits) - 1 do 
        if Power(2, cc * 10) > BytesCount then 
            Break; 

    Dec(cc); 

    if Short then 
        OutputUnit:=ByteShortUnits[cc] 
    else 
        OutputUnit:=ByteLongUnits[cc];

    Result:=FloatToStr(RoundTo(BytesCount / Power(2, cc * 10),-2) ) + ' ' + OutputUnit;
end; 


procedure Tmainform.Timer2Timer(Sender: TObject);
begin
 Timer2.Enabled := false;
  ProgressBar.Percent:=strtoint(format('%5.0f%', [CpuUsage1.CpuUsage['dg_client']]));
pane2.Caption := 'RAM '+ConvertByte(GetWorkingSetSize,true);
  Timer2.Enabled := true;

end;


procedure Tmainform.RzBitBtn3Click(Sender: TObject);
begin
close;
end;

procedure Tmainform.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if MessageDlg('Programm beenden ?', mtConfirmation, 
    [mbOk, mbCancel], 0) = mrCancel then 
     CanClose := False;
end;

end.
