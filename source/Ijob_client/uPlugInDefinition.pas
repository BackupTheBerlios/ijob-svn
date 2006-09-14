unit uPlugInDefinition;

interface

uses
  Windows,Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms;

type
  TEventNotification = (evnFileNew, evnFileOpen, evnFileSave, evnFileSaveAs,
      evnCut, evnCopy, evnPaste, evnClose);
  TEventAction = (evnContinue, evnAbort);

  TPlugIn = class
  private
    FParent: THandle;
    procedure SetParent(const Value: THandle);
  public
    constructor Create(aParent: THandle);
    // information strings
    function GetName: ShortString; virtual; stdcall; abstract;
    function GetAuthor: ShortString; virtual; stdcall; abstract;
    function GetComment: ShortString; virtual; stdcall; abstract;
    // menu data
    function GetMenuText: ShortString; virtual; stdcall; abstract;
    function GetEnabled: Boolean; virtual; stdcall; abstract;
    // launch the Expert
    procedure Execute; virtual; stdcall; abstract;
    // event handler
    function EventHandler(EventNotification: TEventNotification): TEventAction;
        virtual; stdcall; abstract;
    // properties
    property Parent: THandle read FParent write SetParent;
  end;

  TLoadPlugIn = function(Parent: THandle; var PlugIn: TPlugIn): Boolean;

implementation

{ TPlugIn }

constructor TPlugIn.Create(aParent: THandle);
begin
  inherited Create;
  FParent := aParent;
end;

procedure TPlugIn.SetParent(const Value: THandle);
begin
  FParent := Value;
end;

end.
