unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls;

type
  Tfrm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Image2: TImage;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure ResizeImage(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  var
  frm1: Tfrm1;
  destbitmap,sourcebitmap : tbitmap;
implementation

uses Unit2;

{$R *.DFM}

type trw = array[0..maxint div 8] of integer; // just a duumy array

procedure Tfrm1.FormShow(Sender: TObject);
begin image2.Picture.Bitmap:=destbitmap;
 form2.Show
end;
//memory address of bitmap T is the last scanlines i.e T.scanlines[T.height-1]
procedure Tfrm1.ResizeImage(Sender: TObject);
var x,y,i,j,dw,dh,sw,sh : integer;
    dest : Tbitmap;
    p1,q1 : ^trw;
begin
 dest:=Tbitmap.Create; dest.PixelFormat:=pf32bit;
 dest.Width:=form2.Image2.Width; dest.Height:=form2.Image2.Height;
 dw:=dest.Width; dh:=dest.Height;
 sw:=sourcebitmap.Width; sh:=sourcebitmap.Height;
 with dest.Canvas do
 begin
  q1:=dest.ScanLine[dh-1];  //get the pointer to dest bitmap memory
  p1:=sourcebitmap.ScanLine[sh-1]; //get the pointer to source bitmap memory
  //we now simply map each pixel of destination proportionaly somewhere in source bitmap
  //x,y is coordinate of destination pixel, x,y is coordinate of source pixel
     for y:=0 to dh-1 do
     begin
         for x:=0 to dw-1 do
         begin
           i:=x*sw div dw;
           j:=y*sh div dh;
           q1[dw*y+x]:=p1[sw*j+i]
         end;
     end
  end;
  form2.Image2.Picture.Bitmap.Assign(dest);
  dest.Free;
end;

procedure Tfrm1.FormCreate(Sender: TObject);
begin
 destbitmap:=tbitmap.Create;
 destbitmap.Width:=image2.Width; destbitmap.Height:=image2.Height;

 destbitmap.Canvas.Brush.Color:=clblack;
 destbitmap.Canvas.FillRect(rect(0,0,destbitmap.Width,destbitmap.Height));

 destbitmap.PixelFormat:=pf32bit;
 sourcebitmap:=Tbitmap.Create; sourcebitmap.Assign(image1.picture.bitmap);
 sourcebitmap.PixelFormat:=pf32bit;
end;

procedure Tfrm1.FormDestroy(Sender: TObject);
begin
 destbitmap.Free; sourcebitmap.Free
end;

procedure Tfrm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,Y: Integer);
var dw,dh,sw,sh : integer;
    i,j : integer;
    p1,q1 : ^trw ;
begin
 dw:=destbitmap.Width; dh:=destbitmap.Height;
 sw:=sourcebitmap.Width; sh:=sourcebitmap.Height;
 q1:=destbitmap.ScanLine[dh-1];  //get the pointer to dest bitmap memory
 p1:=sourcebitmap.ScanLine[sh-1]; //get the pointer to source bitmap memory
 i:=dw*(dh-y)+ x;
 j:=sw*(dh-y)+ x;
 q1[i]:=p1[j];

 image2.Picture.Bitmap:=destbitmap
end;

end.
