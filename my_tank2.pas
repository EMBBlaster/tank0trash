unit my_tank2;

interface

uses
  Graphics,
  strategy_utils,
     tanks,
     world,
     globals,
     bonus,
     weapon,

     Math,
     SysUtils;

    const MAX_TIMER=44;
 type
  TBorisCleverTank=class(TTank)
    public
     timer:integer;
     procedure get_actions;override;
     procedure Init; override;
     function getTankColor:TColor;override;

   end;

implementation

{ TMyTank }


procedure TBorisCleverTank.Init;
begin
 timer:=0;
end;

procedure TBorisCleverTank.get_actions;
var enemy_tank:TTank;
begin
if getWorld.tanks.Count=1 then use_breaks;

enemy_tank:=findTank(Self,[WEAKEST_TANK]);
 if Assigned(enemy_tank) then
  if enemy_tank<>Self then
    begin
     turnTo(enemy_tank);
     if abs(getDAlfa)<Pi/18 then fire;
    end;
{  inc(timer);
  if timer>MAX_TIMER then
   begin
     rotate(getAlfa() +2*pi*(random(132)/132));
     timer:=0;
   end;}
end;



function TBorisCleverTank.getTankColor: TColor;
begin
 Result:=clGreen
end;

end.


