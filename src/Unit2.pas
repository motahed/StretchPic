unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls;

type
  TForm2 = class(TForm)
    Image2: TImage;
    procedure FormResize(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1;

{$R *.DFM}

procedure TForm2.FormResize(Sender: TObject);
begin
 caption:=inttostr(clientwidth)+'x'+inttostr(clientheight)+
 ' [image resize by direct pixel copy using simple memory pointer]';
 frm1.ResizeImage(nil)
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 doublebuffered:=true
end;

end.
