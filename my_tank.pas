unit my_tank;

interface

uses
     tanks,
     world,
     bonus,
     weapon,

     Math,
     SysUtils;

    const MAX_TIMER=44;
 type
  TMyTank=class(TTank)
    public
     timer:integer;
     procedure get_actions;override;
     procedure Init; override;
   end;

implementation

{ TMyTank }


procedure TMyTank.Init;
begin
 timer:=0;
end;

procedure TMyTank.get_actions;
begin
  fire;
  inc(timer);
  if timer>MAX_TIMER then
   begin
     rotate(getAlfa() +2*pi*(random(132)/132));
     timer:=0;
   end;
end;

end.

