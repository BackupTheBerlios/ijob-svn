unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, JvExControls, JvComponent, JvXPCore, JvXPButtons, ExtCtrls,
  RzPanel, RzButton, StdCtrls, RzEdit;

type
  TForm2 = class(TForm)
    RzPanel1: TRzPanel;
    JvXPToolButton1: TJvXPToolButton;
    RzMemo1: TRzMemo;
    RzButton1: TRzButton;
    procedure JvXPToolButton1Click(Sender: TObject);
    procedure RzButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.JvXPToolButton1Click(Sender: TObject);
begin
close;
end;

procedure TForm2.RzButton1Click(Sender: TObject);
begin
rzmemo1.Lines.SaveToFile('d:\Protokoll_Ijob.txt');
end;

procedure TForm2.FormShow(Sender: TObject);
begin
rzmemo1.Lines.LoadFromFile('d:\Protokoll_Ijob.txt');
end;

end.
