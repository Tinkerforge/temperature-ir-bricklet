#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletTemperatureIR;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $tir = Tinkerforge::BrickletTemperatureIR->new(&UID, $ipcon); # Create device object

# Callback subroutine for ambient temperature callback (parameter has unit °C/10)
sub cb_ambient_temperature
{
    my ($ambient_temperature) = @_;

    print "Ambient Temperature: " . $ambient_temperature/10.0 . " °C\n";
}

# Callback subroutine for object temperature callback (parameter has unit °C/10)
sub cb_object_temperature
{
    my ($object_temperature) = @_;

    print "Object Temperature: " . $object_temperature/10.0 . " °C\n";
}

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set period for ambient temperature callback to 1s (1000ms)
# Note: The ambient temperature callback is only called every second
#       if the ambient temperature has changed since the last call!
$tir->set_ambient_temperature_callback_period(1000);

# Register ambient temperature callback to subroutine cb_ambient_temperature
$tir->register_callback($tir->CALLBACK_AMBIENT_TEMPERATURE, 'cb_ambient_temperature');

# Set period for object temperature callback to 1s (1000ms)
# Note: The object temperature callback is only called every second
#       if the object temperature has changed since the last call!
$tir->set_object_temperature_callback_period(1000);

# Register object temperature callback to subroutine cb_object_temperature
$tir->register_callback($tir->CALLBACK_OBJECT_TEMPERATURE, 'cb_object_temperature');

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();
