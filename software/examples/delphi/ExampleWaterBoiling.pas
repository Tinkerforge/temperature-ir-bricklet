program ExampleWaterBoiling;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  Math, SysUtils, IPConnection, BrickletTemperatureIR;

type
  TExample = class
  private
    ipcon: TIPConnection;
    tir: TBrickletTemperatureIR;
  public
    procedure ReachedCB(sender: TObject; const temperature: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '365'; { Change to your UID }

var
  e: TExample;

{ Callback for object temperature greater than 100 °C
  (parameter has unit °C/10) }
procedure TExample.ReachedCB(sender: TObject; const temperature: smallint);
begin
  WriteLn(Format('The surface has a temperature of %f °C', [temperature/10.0]));
  WriteLn('The water is boiling!');
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create();

  { Create device object }
  tir := TBrickletTemperatureIR.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set emissivity to 0.98 (emissivity of water) }
  tir.SetEmissivity(Floor($FFFF*0.98));

  { Get threshold callbacks with a debounce time of 10 seconds (10000ms) }
  tir.SetDebouncePeriod(10000);

  { Register threshold reached callback to procedure ReachedCB }
  tir.OnObjectTemperatureReached := {$ifdef FPC}@{$endif}ReachedCB;

  { Configure threshold for "greater than 100 °C" (unit is °C/10) }
  tir.SetObjectTemperatureCallbackThreshold('>', 100*10, 0);

  WriteLn('Press key to exit');
  ReadLn;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
