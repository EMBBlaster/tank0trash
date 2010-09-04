// Developed by Boris Kruglov,2007
unit mem_utils;

interface


uses SysUtils;

 procedure FreeObj(p:TObject);

implementation

procedure FreeObj(p:TObject);
begin
  if Assigned(p) then FreeAndNil(p)
end;

end.


