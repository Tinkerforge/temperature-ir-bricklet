program ExampleCallback;

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
    procedure ObjectTemperatureCB(const temperature: smallint);
    procedure AmbientTemperatureCB(const temperature: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = '365'; { Change to your UID }

var
  e: TExample;

{ Callback functions for object/ambient temperature callbacks
  (parameters have unit °C/10) }
procedure TExample.ObjectTemperatureCB(const temperature: smallint);
begin
  WriteLn(Format('Object Temperature: %f °C', [temperature/10.0]));
end;

procedure TExample.AmbientTemperatureCB(const temperature: smallint);
begin
  WriteLn(Format('Ambient Temperature: %f °C', [temperature/10.0]));
end;

procedure TExample.Execute;
begin
  { Create IP connection to brickd }
  ipcon := TIPConnection.Create(HOST, PORT);

  { Create device object }
  tir := TBrickletTemperatureIR.Create(UID);

  { Add device to IP connection }
  ipcon.AddDevice(tir);
  { Don't use device before it is added to a connection }

  { Set Period for temperature callbacks to 1s (1000ms)
    Note: The callbacks are only called every second if the 
          value has changed since the last call! }
  tir.SetObjectTemperatureCallbackPeriod(1000);
  tir.SetAmbientTemperatureCallbackPeriod(1000);

  { Register object temperature callback to procedure ObjectTemperatureCB }
  tir.OnObjectTemperature := {$ifdef FPC}@{$endif}ObjectTemperatureCB;
  
  { Register ambient temperature callback to procedure AmbientTemperatureCB }
  tir.OnAmbientTemperature := {$ifdef FPC}@{$endif}AmbientTemperatureCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy;
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
