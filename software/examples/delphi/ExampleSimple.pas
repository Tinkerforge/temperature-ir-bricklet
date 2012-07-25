program ExampleSimple;

{$ifdef MSWINDOWS}{$apptype CONSOLE}{$endif}
{$ifdef FPC}{$mode OBJFPC}{$H+}{$endif}

uses
  SysUtils, IPConnection, BrickletTemperatureIR;

type
  TExample = class
  private
    ipcon: TIPConnection;
    tir: TBrickletTemperatureIR;
  public
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '365';

var
  e: TExample;

procedure TExample.Execute;
var obj, amb: smallint;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  tir := TBrickletTemperatureIR.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(tir);
  { Don't use device before it is added to a connection }

  { Get current ambient and object temperatures (unit is °C/10) }
  obj := tir.GetObjectTemperature;
  amb := tir.GetAmbientTemperature;

  WriteLn(Format('Object Temperature: %f °C', [obj/10.0]));
  WriteLn(Format('Ambient Temperature: %f °C', [amb/10.0]));

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.