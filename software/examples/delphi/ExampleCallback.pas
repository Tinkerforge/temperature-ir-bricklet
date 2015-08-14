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
    procedure AmbientTemperatureCB(sender: TBrickletTemperatureIR; const ambientTemperature: smallint);
    procedure ObjectTemperatureCB(sender: TBrickletTemperatureIR; const objectTemperature: smallint);
    procedure Execute;
  end;

const
  HOST = 'localhost';
  PORT = 4223;
  UID = 'XYZ'; { Change to your UID }

var
  e: TExample;

{ Callback procedure for ambient temperature callback (parameter has unit °C/10) }
procedure TExample.AmbientTemperatureCB(sender: TBrickletTemperatureIR; const ambientTemperature: smallint);
begin
  WriteLn(Format('Ambient Temperature: %f °C', [ambientTemperature/10.0]));
end;

{ Callback procedure for object temperature callback (parameter has unit °C/10) }
procedure TExample.ObjectTemperatureCB(sender: TBrickletTemperatureIR; const objectTemperature: smallint);
begin
  WriteLn(Format('Object Temperature: %f °C', [objectTemperature/10.0]));
end;

procedure TExample.Execute;
begin
  { Create IP connection }
  ipcon := TIPConnection.Create;

  { Create device object }
  tir := TBrickletTemperatureIR.Create(UID, ipcon);

  { Connect to brickd }
  ipcon.Connect(HOST, PORT);
  { Don't use device before ipcon is connected }

  { Set period for ambient temperature callback to 1s (1000ms)
    Note: The ambient temperature callback is only called every second
          if the ambient temperature has changed since the last call! }
  tir.SetAmbientTemperatureCallbackPeriod(1000);

  { Register ambient temperature callback to procedure AmbientTemperatureCB }
  tir.OnAmbientTemperature := {$ifdef FPC}@{$endif}AmbientTemperatureCB;

  { Set period for object temperature callback to 1s (1000ms)
    Note: The object temperature callback is only called every second
          if the object temperature has changed since the last call! }
  tir.SetObjectTemperatureCallbackPeriod(1000);

  { Register object temperature callback to procedure ObjectTemperatureCB }
  tir.OnObjectTemperature := {$ifdef FPC}@{$endif}ObjectTemperatureCB;

  WriteLn('Press key to exit');
  ReadLn;
  ipcon.Destroy; { Calls ipcon.Disconnect internally }
end;

begin
  e := TExample.Create;
  e.Execute;
  e.Destroy;
end.
