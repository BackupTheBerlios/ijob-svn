program Project1;

uses
  Forms,
  FastCode,
  Unit1 in 'Unit1.pas' {mainform},
  Unit2 in 'Unit2.pas' {Form2},
  kompo in 'kompo.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(Tmainform, mainform);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
