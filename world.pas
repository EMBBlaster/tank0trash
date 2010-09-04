unit world;

interface
uses
 SysUtils,
 Classes,
 Windows,
 Graphics,
 mem_utils,
 bullets,
 tanks;

 type
  TWorld=class
  tanks:TTankList;
  bullets:TBulletList;
  width,height:integer;
  public
   constructor Create(w,h:integer);
   destructor Destroy; override;
   procedure processEvents;
   procedure addBullet(b:TBullet);
   procedure draw(Canvas:TCanvas);
  end;
implementation

{ TWorld }

procedure TWorld.addBullet(b: TBullet);
begin
 bullets.add(b);
end;

constructor TWorld.Create(w,h:integer);
begin
 width:=w;
 height:=h;
 tanks:=TTankList.Create;
 bullets:=TBulletList.Create;;
end;

destructor TWorld.Destroy;
begin
  freeObj(tanks);
  freeObj(bullets);
  inherited;
end;

procedure TWorld.draw(Canvas: TCanvas);
var r:trect;
 i:integer;
 bullet:TBullet;
 tank:TTank;
 x,y,alfa:double;
 x1,y1:integer;
 L:integer;

  procedure drawTrack(sign:integer);
  var x3,y3,x4,y4,x1,y1,x2,y2:integer;
     da:double;
  begin
    L:=10;
    da:=Pi/6*sign;
    x1:=trunc(x+L*cos(alfa+da));
    y1:=trunc(y+L*sin(alfa+da));

    x2:=trunc(x+L*cos(Pi+alfa-da));
    y2:=trunc(y+L*sin(Pi+alfa-da));

    L:=12;
    da:=Pi/4*sign;
    x3:=trunc(x+L*cos(alfa+da));
    y3:=trunc(y+L*sin(alfa+da));

    x4:=trunc(x+L*cos(Pi+alfa-da));
    y4:=trunc(y+L*sin(Pi+alfa-da));


    Canvas.Brush.Color:=clGreen;
    Canvas.MoveTo(x1,y1);
    Canvas.LineTo(x2,y2);
    Canvas.LineTo(x4,y4);
    Canvas.LineTo(x3,y3);
    Canvas.LineTo(x1,y1);
  end;

  procedure drawTower;
  begin
   Canvas.Brush.Color:=tank.getTankColor;
   L:=6;
   Canvas.Ellipse(trunc(x-L),trunc(y-L),trunc(x+L),trunc(y+L));
  end;

  procedure drawBullet;
  begin
   Canvas.Brush.Color:=clRed;
   L:=BULLET_RADIUS;
   Canvas.Ellipse(trunc(x-L),trunc(y-L),trunc(x+L),trunc(y+L));
  end;

  procedure drawMuzzle;
  begin
   Canvas.Brush.Color:=clWhite;
   Canvas.MoveTo(trunc(x),trunc(y));
   L:=12;
   x1:=trunc(x+L*cos(alfa));
   y1:=trunc(y+L*sin(alfa));
   Canvas.LineTo(x1,y1);
  end;

begin
 r.Left:=0;
 r.Top:=0;
 r.Bottom:=height;
 r.Right:=width;
 Canvas.Brush.Color:=clWhite;
 Canvas.FillRect(r);

 for i:=0 to tanks.Count-1 do
  begin
   tank:=tanks.at(i);
   x:=tank.getX;
   y:=tank.getY;
   alfa:=tank.getAlfa;

   drawTrack(1); //right
   drawTrack(-1);//left
   drawTower;
   drawMuzzle;
  end;

 for i:=0 to bullets.Count-1 do
  begin
   bullet:=bullets.at(i);
   x:=bullet.getX;
   y:=bullet.getY;
   alfa:=bullet.getAlfa;
   drawBullet;
  end;

end;

procedure TWorld.processEvents;
var i:integer;
 bullet:TBullet;
 tank:TTank;
begin
 for i:=tanks.count-1 downto 0 do
  begin
   tank:=tanks.at(i);
   if tank.getHP>0 then
    tank.DoMove else
    begin
     freeObj(tank);
     tanks.Delete(i);
    end;
  end;

 for i:=bullets.count-1 downto 0 do
  begin
  bullet:=bullets.at(i);
  bullet.doMove;
  if bullet.isCollided then
    begin
      FreeObj(bullet);
      bullets.Delete(i);
    end;
  end;
end;

end.


