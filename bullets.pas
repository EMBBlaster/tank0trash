unit bullets;

interface
uses
 Classes;

const
 BULLET_RADIUS=3;
 BULLET_SPEED=29;
 BULLET_HIT_HP=5;

type
 TBullet=class
  private
   x,y,alfa:extended;
   ownerTank:TObject;
  public
   isCollided:boolean;
   constructor Create(x,y,alfa:extended; ownerTank:TObject);
   function getX:Extended;
   function getY:Extended;
   function getAlfa:Extended;
   procedure doMove;
  end;

TBulletList=class(TList)
 public
  function at(i:integer):TBullet;
end;

implementation

uses
  globals,
  tanks,
  world;

{ TBullet }

constructor TBullet.Create(x, y, alfa: extended; ownerTank:TObject);
begin
 Self.ownerTank:=ownerTank;
 Self.x:=x;
 Self.y:=y;
 Self.alfa:=alfa;
end;

procedure TBullet.doMove;
var
 dr,
 dx,dy,
 xnew,ynew:extended;
 i:integer;
 tank:TTank;
begin
 isCollided:=false;
 dr:=BULLET_SPEED/5;
 xnew:=x+dr*cos(alfa);
 ynew:=y+dr*sin(alfa);
 x:=xnew;
 y:=ynew;

 if (x<0) or (y<0) or
   (x>getWorld.width) or (y>getWorld.height) then
   isCollided:=true;

 for i:=0 to getWorld.tanks.count-1 do
  begin
   tank:=getWorld.tanks.at(i);
   dx:=(tank.getX-xnew);
   dy:=(tank.getY-ynew);
   if tank<>ownerTank then
   if dx*dx+dy*dy<sqr(BULLET_RADIUS+TANK_RADIUS) then
    begin
     tank.decHP(BULLET_HIT_HP);
     isCollided:=true;
     try
     if (ownerTank as TTank).isAssigned then
       begin
       (ownerTank as TTank).incHits();
       if tank.getHP<=0 then
        (ownerTank as TTank).incFrags();
       end;
     except
     end;
     break
    end;
  end;
end;

function TBullet.getAlfa: Extended;
begin
 Result:=alfa;
end;

function TBullet.getX: Extended;
begin
 Result:=x
end;

function TBullet.getY: Extended;
begin
 Result:=y
end;


{ TBulletList }

function TBulletList.at(i: integer): TBullet;
begin
 Result:=TBullet(Items[i]);
end;

end.
