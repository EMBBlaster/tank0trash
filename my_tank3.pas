unit my_tank3;

interface

uses
  Graphics,
  globals,
  strategy_utils,
     tanks,
     world,
     bonus,
     weapon,

     Math,
     SysUtils;

    const MAX_TIMER=44;
 type
  TGeniusTank=class(TTank)
    public
     procedure get_actions;override;
     procedure Init; override;
     function getTankColor:TColor;override;

   end;

implementation

{ TMyTank }


procedure TGeniusTank.Init;
begin

end;

procedure TGeniusTank.get_actions;
var enemy_tank:TTank;
begin
if getWorld.tanks.Count=1 then use_breaks;

enemy_tank:=findTank(Self,[NEAREST_TANK]);
 if Assigned(enemy_tank) then
  if enemy_tank<>Self then
    begin
     turnTo(enemy_tank);
     if abs(getDAlfa)<Pi/18 then fire;
    end;
end;



function TGeniusTank.getTankColor: TColor;
begin
 Result:=clRed
end;

end.


