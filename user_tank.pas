unit user_tank;

interface

uses
  Graphics,
  strategy_utils,
     tanks,
     world,
     globals,
     bonus,
     weapon,
     geom,
     Math,
     SysUtils;

    const MAX_TIMER=44;

 type TMovingDir=(None, Fwd, Back);
 type
  TUserTank=class(TTank)
    public
     target:TTank;
     movingToPoint:boolean;
     timer:integer;
     user_alfa:double;
     firing:boolean;
     moving:TMovingDir;
     procedure get_actions;override;
     procedure Init; override;
     function getTankColor:TColor;override;
     procedure setDirection(x:double; y:double);
   end;

implementation

uses Classes;

{ TMyTank }


procedure TUserTank.Init;
begin
 target:=nil;
 moving:=None;
 firing:=false;
 movingToPoint:=false;
 user_alfa:=getCurrentNewAlfa;
 setMaxFireDelay(MAX_FIRE_DELAY_CHEAT);
 setHP(100);

 timer:=0;
end;

procedure TUserTank.get_actions;
var
 a:double;
begin
if assigned(target) then
 if movingToPoint then
  begin
  if distanceTo(target)<3 then movingToPoint:=false;
  moving:=None;
  user_alfa:=getAlfa;
  end;

if movingToPoint then
  begin
   turnTo(target);
   a:=getAngleToObject(target.getX,target.getY)-getAlfa;
   if (abs(normalize_angle_rot(a))<Pi/4) then
      moving:=Fwd
      else
       moving:=None;
  end;

  if moving=None then use_breaks;
  if moving=Fwd then
    setAcceleration(MAX_ACCELERATION);
  if moving=Back then
    setAcceleration(MIN_ACCELERATION);

if not movingToPoint then
  begin
  rotate(user_alfa);
  end;

  if firing then
   begin
    fire;
    firing:=false;
   end;
end;


function TUserTank.getTankColor: TColor;
begin
 Result:=$10fe22
end;

procedure TUserTank.setDirection(x, y: double);
begin
 movingToPoint:=true;
 if Assigned(target) then target.Free;
 target:=Ttank.Create(X,Y,3,'Stupid 4');
end;


end.


