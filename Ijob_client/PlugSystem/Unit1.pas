unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,uPlugInDefinition, StdCtrls, RzPanel, RzButton, ImgList, ExtCtrls,
  JvExControls, JvComponent, JvXPCore, JvXPButtons, RzBckgnd;

type
  TForm1 = class(TForm)
    ImageList1: TImageList;
    RzPanel1: TRzPanel;
    JvXPToolButton1: TJvXPToolButton;
    procedure JvXPToolButton1Click(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form1: TForm1;

implementation



{$R *.dfm}

procedure TForm1.JvXPToolButton1Click(Sender: TObject);
begin
close;
end;

end.
 