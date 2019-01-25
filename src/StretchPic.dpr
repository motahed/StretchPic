program StretchPic;

uses
  Forms,
  Unit1 in 'Unit1.pas' {frm1},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(Tfrm1, frm1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
