unit tanks;

interface

uses
 geom,
 math,
 bullets,
 Classes,Graphics,
 SysUtils;

 const
  TANK_RADIUS=11;

  TANK_MAX_HP=50;

  MAX_ROTATION_ANGLE=2*Pi/256;
  MAX_ACCELERATION=0.6;
  MIN_ACCELERATION=-0.4;
  MAX_SPEED=12;
  MIN_SPEED=-5;
  MAX_FIRE_DELAY_DEFAULT=36;
  MAX_FIRE_DELAY_CHEAT=10;

  SPEED_EPSILON=0.08;
 type
  TTank=class
  private
   max_fire_delay:integer;
   fire_delay:integer;
   hitpoints:integer;
   speed,
   new_alfa,alfa:extended;
   x,y,
   acceleration:extended;
   tank_name:string;

   hits:integer;
   frags:integer;

   procedure apply_accelerate;
   procedure apply_move;
   procedure apply_rotate;
   procedure apply_fire;
   procedure apply_actions;
  public
   function isAssigned:boolean;
   function distanceTo(other:TTank):double;
    procedure setAlfa(a:double);
   function getName:String;
   procedure setHP(hp:integer);
   function getHP:integer;
   procedure decHP(hit_hp:integer);
   procedure setMaxFireDelay(delay:integer);
   procedure Init;virtual;
   procedure setAcceleration(acc:double);
   constructor Create(x0,y0,alfa0:double; name:string);
   procedure rotate(newAlfa:double);
   procedure use_breaks;
   function getCurrentNewAlfa():double;
   function getAngleToObject(x1,y1:double):double;

   procedure turnTo(other_tank:TTank);overload;

   destructor Destroy; override;
   procedure DoMove;

   //user routines:
   procedure fire;
   function getX:double;
   function getY:double;
   function getAlfa:double;
   function getDAlfa:double;

   function getHits:integer;
   function getFrags:integer;
   procedure incHits;
   procedure incFrags;

   procedure get_actions;virtual;
   function getTankName:string;virtual;
   function getTankColor:TColor;virtual;
  end;

  TTankList=class(TList)
   function at(i:integer):TTank;
  end;

  
implementation
uses
 globals;


{ TTank }

procedure TTank.apply_accelerate;
begin
 if acceleration>MAX_ACCELERATION then
   acceleration:=MAX_ACCELERATION;
 if acceleration<MIN_ACCELERATION then
   acceleration:=MIN_ACCELERATION;

 speed:=speed+acceleration;
 if speed>MAX_SPEED then speed:=MAX_SPEED;
 if speed<MIN_SPEED then speed:=MIN_SPEED;
end;

procedure TTank.apply_actions;
begin
 apply_accelerate;
 apply_move;
 apply_rotate;
 apply_fire;
end;

procedure TTank.apply_fire;
begin

end;

procedure TTank.apply_move;
var dr,xnew,ynew:double;
tank_collision:boolean;
world_collision:boolean;
i:integer;
tank:TTank;
dx,dy:extended;
begin
 dr:=speed/8;
 xnew:=x+dr*cos(alfa);
 ynew:=y+dr*sin(alfa);
 world_collision:=false;
 if (xnew<0)then
  begin xnew:=0; world_collision:=true; end;
 if (xnew>getWorld.width)then
  begin xnew:=getWorld.width; world_collision:=true; end;
 if (ynew<0)then
  begin ynew:=0; world_collision:=true; end;
 if (ynew>getWorld.height) then
  begin ynew:=getWorld.height; world_collision:=true; end;

 if world_collision then speed:=-speed;

 tank_collision:=false;
 for i:=0 to getWorld.tanks.count-1 do
  begin
   tank:=getWorld.tanks.at(i);
   dx:=(tank.getX-xnew);
   dy:=(tank.getY-ynew);
   if tank<>Self then
   if dx*dx+dy*dy<sqr(2*TANK_RADIUS) then
    begin
     tank_collision:=true;
     break
    end;
  end;
 if tank_collision then speed:=-speed
  else
  begin
   x:=xnew;
   y:=ynew;
  end;
end;

procedure TTank.apply_rotate;
var
 da:extended;
begin
 da:=normalize_angle_rot(new_alfa-alfa);
 alfa:=alfa+sign(da)*min(MAX_ROTATION_ANGLE,abs(da));
end;

constructor TTank.Create;
begin
 hits:=0;
 frags:=0;
 max_fire_delay:=MAX_FIRE_DELAY_DEFAULT;
 fire_delay:=0;
 tank_name:=name;
 hitpoints:=TANK_MAX_HP;
 acceleration:=0;
 speed:=0;
 x:=x0;
 y:=y0;
 alfa:=alfa0;
 new_alfa:=alfa;
 Init;
end;

procedure TTank.decHP(hit_hp: integer);
begin
 dec(hitpoints,hit_hp);
 if hitpoints<0 then hitpoints:=0;
end;

destructor TTank.Destroy;
begin

  inherited;
end;

procedure TTank.DoMove;
begin
 get_actions;
 apply_actions;
end;


procedure TTank.fire;
begin
 if fire_delay>0 then
  begin
   dec(fire_delay);
   exit;
  end;

 fire_delay:=max_fire_delay+Random(max_fire_delay);
 getWorld.addBullet(TBullet.Create(x,y,alfa,Self))
end;

function TTank.getAlfa: double;
begin
 Result:=alfa;
end;

function TTank.getHP: integer;
begin
 Result:=hitpoints;
end;

function TTank.getDAlfa: double;
begin
 Result:=normalize_angle_rot(new_alfa-alfa);
end;

function TTank.getTankColor: TColor;
begin
 Result:=clBlack;
end;

function TTank.getTankName: string;
begin
 Result:='no name';
end;


function TTank.getX: double;
begin
 Result:=x;
end;

function TTank.getY: double;
begin
 Result:=y;
end;

procedure TTank.get_actions;
begin
end;

procedure TTank.Init;
begin

end;

procedure TTank.rotate(newAlfa: double);
begin
 new_alfa:=normalize_angle(newAlfa);
end;

procedure TTank.setAcceleration(acc: double);
begin
 acceleration:=acc;
 if acceleration>0 then acceleration:=MAX_ACCELERATION;
 if acceleration<0 then acceleration:=MIN_ACCELERATION;
end;

function TTank.getName: String;
begin
 Result:=tank_name 
end;

function TTank.getAngleToObject(x1, y1: double): double;
var a,b:double;
begin
 a:=x1-getX;
 b:=y1-getY;
 Result:=0;
 if (a<>0) then
  begin
    Result:=ArcTan2(b,a)
  end
end;

procedure TTank.turnTo(other_tank: TTank);
begin
 rotate(getAngleToObject(other_tank.getX,
                         other_tank.getY))
end;

procedure TTank.use_breaks;
begin
 if speed>0 then acceleration:=MIN_ACCELERATION;
 if speed<0 then acceleration:=MAX_ACCELERATION;
 if abs(speed)<SPEED_EPSILON then
   begin
    speed:=0;
    acceleration:=0; 
   end;
end;

function TTank.getCurrentNewAlfa: double;
begin
  Result:=new_alfa;
end;

procedure TTank.setHP(hp: integer);
begin
  hitpoints:=hp
end;


procedure TTank.setMaxFireDelay(delay: integer);
begin
 max_fire_delay:=delay;
end;

procedure TTank.setAlfa(a: double);
begin
 alfa:=a;
end;

function TTank.getFrags: integer;
begin
 result:=frags;
end;

function TTank.getHits: integer;
begin
 result:=hits;
end;

procedure TTank.incHits;
begin
 inc(hits);
end;

procedure TTank.incFrags;
begin
 inc(frags)
end;

function TTank.distanceTo(other: TTank): double;
begin
 Result:=distance(getX,getY,other.getX,other.getY)
end;

function TTank.isAssigned: boolean;
begin
 Result:=Assigned(Self);
end;

{ TTankList }

function TTankList.at(i: integer): TTank;
begin
 Result:=TTank(items[i])
end;

end.

