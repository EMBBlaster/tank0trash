unit tanks_geom;

interface

uses tanks;

  function distance(t1,t2:TTank):double; overload;

implementation

uses geom;
  function distance(t1,t2:TTank):double; overload;
  begin
    Result:=distance(t1.getX,t1.getY,t2.getX,t2.getY)-2*TANK_RADIUS;
  end;
end.
 