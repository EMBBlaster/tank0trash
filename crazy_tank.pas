unit crazy_tank;

interface

uses
  Graphics,
  globals,
  strategy_utils,
  tanks,
  tanks_geom,
  world,
  bonus,
  geom,
  weapon,

   Math,
   SysUtils;

    const MAX_TIMER=44;
 type
  TCrazyTank=class(TTank)
    public
     procedure get_actions;override;
     procedure Init; override;
     function getTankColor:TColor;override;

   end;

implementation

{ TMyTank }


procedure TCrazyTank.Init;
begin

end;

procedure TCrazyTank.get_actions;
var enemy_tank:TTank;
begin
if getWorld.tanks.Count=1 then use_breaks;

enemy_tank:=findTank(Self,[NEAREST_TANK]);
 if Assigned(enemy_tank) then
  if enemy_tank<>Self then
    begin
     turnTo(enemy_tank);
     if distance(Self,enemy_tank)<3*tank_radius then
      begin
        if distance(Self,enemy_tank)<tank_radius then
       use_breaks
       else
      //    setAcceleration(MIN_ACCELERATION);
      end;    
     if distance(Self,enemy_tank)>2*tank_radius then setAcceleration(MAX_ACCELERATION);

     if abs(getDAlfa)<Pi/18 then fire;
    end;
end;



function TCrazyTank.getTankColor: TColor;
begin
 Result:=$abcd; //dark yellow
end;

end.


