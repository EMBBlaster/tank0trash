unit globals;

interface

 uses
  mem_utils,
  world;

 procedure initWorld(width,height:integer);
 function getWorld:TWorld;
 procedure freeWorld;

implementation

var
  wrld:TWorld;

function getWorld:TWorld;
begin
 Result:=wrld;
end;

procedure initWorld(width,height:integer);
begin
 wrld:=TWorld.Create(width,height);
end;

procedure freeWorld;
begin
 freeObj(wrld);
end;

end.
 