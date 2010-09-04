unit glavnoe_okno;

interface

uses
  world,
  globals,
  crazy_tank,
  tanks,
  user_tank,
  my_tank,
  my_tank2,
  my_tank3,
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Panel1: TPanel;
    PaintBox1: TPaintBox;
    ListBox1: TListBox;
    Timer2: TTimer;
    StatusBar: TStatusBar;
    procedure Timer1Timer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { Private declarations }
  public
    mouseFiring:boolean;
    userTank:TUserTank;
    { Public declarations }
  end;

var
  tick:integer;
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.Timer1Timer(Sender: TObject);
begin
 inc(tick);
 if mouseFiring then userTank.firing:=true;

 getWorld.processEvents;
 getWorld.draw(PaintBox1.Canvas);
 Caption:='Tanks: '+IntToStr(getworld.tanks.Count)+'   '+
 'Bullets: '+IntToStr(getworld.bullets.Count)+'   '+
 'Tick: '+IntToStr(tick);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 tick:=0;
 mouseFiring:=false;
 initWorld(PaintBox1.Width,PaintBox1.Height);

 getWorld.tanks.Add(TMyTank.Create(40,30,0,'Stupid 1'));
 getWorld.tanks.Add(TMyTank.Create(230,60,1,'Stupid 2'));
 getWorld.tanks.Add(TMyTank.Create(130,130,2,'Stupid 3'));
 getWorld.tanks.Add(TMyTank.Create(150,230,3,'Stupid 4'));
 getWorld.tanks.Add(TCrazyTank.Create(20,100,4,'Tormoz 1'));
 getWorld.tanks.Add(TCrazyTank.Create(290,180,4,'Tormoz 2'));
 getWorld.tanks.Add(TGeniusTank.Create(60,170,5,'Kill nearest 1(red)'));
 getWorld.tanks.Add(TGeniusTank.Create(100,30,6,'Kill nearest 2'));
 getWorld.tanks.Add(TBorisCleverTank.Create(50,80,6,'Kill weak 1 (green)'));
 getWorld.tanks.Add(TBorisCleverTank.Create(300,30,6,'Kill weak 2'));
 userTank:=TUserTank.Create(130,190,0,'User');
 getWorld.tanks.Add(userTank);

 Button1Click(Sender);
end;

procedure TForm1.Button1Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to getWorld.tanks.Count-1 do
 getWorld.tanks.at(i).setAcceleration(5)
end;

procedure TForm1.Timer2Timer(Sender: TObject);
var i:integer;
begin
 ListBox1.Items.Clear;
 for i:=0 to getworld.tanks.Count-1 do
  ListBox1.Items.Add(getWorld.tanks.at(i).getName+':'+IntToStr(getworld.tanks.at(i).getHP));

 StatusBar.SimpleText:='Hits: '+IntToStr(userTank.getHits)+
                      ' Frags:'+IntToStr(userTank.getFrags);

{ ListBox1.Items.Add('X:'+FloatToStr(userTank.getX));
 ListBox1.Items.Add('Y:'+FloatToStr(userTank.getY));
 ListBox1.Items.Add('alfa:'+FloatToStr(round(userTank.getAlfa*360/(2*Pi))));
}
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 freeWorld;
end;

procedure TForm1.Button2Click(Sender: TObject);
var i:integer;
begin
 for i:=0 to getWorld.tanks.Count-1 do
 getWorld.tanks.at(i).setAcceleration(-1)
end;

procedure TForm1.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var da:double; //dalfa
begin
 da:=0.04;
with userTank do
 begin
 if Key in [VK_UP,VK_DOWN,VK_SHIFT,VK_LEFT,VK_RIGHT] then userTank.movingToPoint:=false;
 if Key = VK_UP then
    moving:=Fwd;
 if Key = VK_DOWN then
    moving:=Back;
 if Key = VK_SHIFT then
    moving:=None;
 if (Key = VK_SPACE) then
    firing:=true;
 user_alfa:=getCurrentNewAlfa;
 if Key = VK_RIGHT then
    user_alfa:=user_alfa+da;
 if Key = VK_LEFT then
    user_alfa:=user_alfa-da;
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
 if CanFocus then SetFocus
end;

procedure TForm1.PaintBox1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbRight then
   userTank.setDirection(x,y);
 if Button=mbLeft then
   mouseFiring:=true
end;

procedure TForm1.PaintBox1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
 if Button=mbLeft then
    mouseFiring:=false
end;

end.

