

program Tank_trash;

uses
  user_tank in 'user_tank.pas',
  Forms,
  glavnoe_okno in 'glavnoe_okno.pas' {Form1},
  world in 'world.pas',
  tanks in 'tanks.pas',
  my_tank in 'my_tank.pas',
  bonus in 'bonus.pas',
  weapon in 'weapon.pas',
  globals in 'globals.pas',
  geom in 'geom.pas',
  bullets in 'bullets.pas',
  my_tank2 in 'my_tank2.pas',
  strategy_utils in 'strategy_utils.pas',
  my_tank3 in 'my_tank3.pas',
  tanks_geom in 'tanks_geom.pas';

{*.res}

begin
  Application.Initialize;
  Application.Title := 'Tanks trasher';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
