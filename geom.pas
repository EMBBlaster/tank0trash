unit geom;

interface


function distance(x,y,x1,y1:double):double; overload;

function sign(a:double):integer;

function normalize_angle(angle:double):double;

function normalize_angle_rot(angle:double):double;

implementation


function distance(x,y,x1,y1:double):double;
var dx,dy:double;
begin
 dx:=x1-x;
 dy:=y1-y;
 Result:=sqrt(dx*dx+dy*dy);
end;

function sign(a:double):integer;
begin
 if a>0 then result:=1 else
  if a<0 then result:=-1
   else result:=0
end;

function normalize_angle(angle:double):double;
begin
 while angle>2*Pi do angle:=angle-2*Pi;
 while angle<0 do angle:=angle+2*Pi;
 Result:=angle;
end;

function normalize_angle_rot(angle:double):double;
begin
 angle:=normalize_angle(angle);
 if angle>Pi then angle:=Pi-angle;
 Result:=angle;
end;


end.
