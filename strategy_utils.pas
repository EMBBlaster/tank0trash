unit strategy_utils;

interface
 uses
  bullets,
  geom,
  bonus,
  tanks,world,globals;

 type
  TTankSearchCriteria=(WEAKEST_TANK,NEAREST_TANK,POWERFUL_TANK);
  TTankSearchCriterias=set of TTankSearchCriteria;
  
 function findTank(except_tank:TTank;
           SearchCriteria:TTankSearchCriterias):TTank;

implementation

 function findTank(except_tank:TTank;
           SearchCriteria:TTankSearchCriterias):TTank;
 var minHP:integer;
     i:integer;
     tank:TTank;
     minDist:double;
     dist:double;
 begin
  Result:=nil;
  minHP:=TANK_MAX_HP+1;
  minDist:=distance(0,0,getWorld.width,getWorld.height);
  for i:=0 to getworld.tanks.Count-1 do
   begin
    tank:=getworld.tanks.at(i);

    if tank<>except_tank then
     begin
       if WEAKEST_TANK in SearchCriteria then
        if tank.getHP<minHP then
          begin
           minHP:=tank.getHP;
           Result:=tank;
          end;

    if NEAREST_TANK in SearchCriteria then
     begin
       dist:=distance(tank.getX,tank.getY,
        except_tank.getX,
        except_tank.getY);
      if dist<minDist then
      begin minDist:=dist; Result:=tank end;
     end;
    end;
  end;
 end;


end.
