library system_dg;

uses
  SysUtils,
  Classes,
  Windows,
  uPlugInDefinition in '..\Shared Units\uPlugInDefinition.pas',
  Unit1 in 'Unit1.pas' {Form1};

{$R *.res}

type
  TPlugIn01 = class(TPlugIn)
  public
    // information strings
    function GetName: ShortString; override; stdcall;
    function GetAuthor: ShortString; override; stdcall;
    function GetComment: ShortString; override; stdcall;
    // menu data
    function GetMenuText: ShortString; override; stdcall;
    function GetEnabled: Boolean; override; stdcall;
    // launch the Expert
    procedure Execute; override; stdcall;
    // event handler
    function EventHandler(EventNotification: TEventNotification): TEventAction;
        override; stdcall;
  end;

{ TPlugIn01 }


function TPlugIn01.EventHandler(EventNotification: TEventNotification):
    TEventAction;
begin
  // nothing to do
  Result := evnContinue;
end;

procedure TPlugIn01.Execute;
begin
Form1.Show;

end;


function TPlugIn01.GetAuthor: ShortString;
begin
  Result := 'Ronny Grobel';
end;

function TPlugIn01.GetComment: ShortString;
begin
  Result := 'Settings Editor';
end;

function TPlugIn01.GetEnabled: Boolean;
begin
  Result := True;
end;

function TPlugIn01.GetMenuText: ShortString;
begin
  Result := 'Settings';
end;

function TPlugIn01.GetName: ShortString;
begin
  Result := 'Keiner';
end;

function LoadPlugin(Parent: THandle; var PlugIn: TPlugIn): Boolean; export;
begin
  try
    PlugIn := TPlugIn01.Create(Parent);
    Form1 := TForm1.Create(nil);
    form1.ParentWindow:=parent;
    Result := True;
  except
    Result := False;
  end;
end;

exports
  LoadPlugIn name 'LoadPlugIn';

begin
  MessageBeep(0);
end.
