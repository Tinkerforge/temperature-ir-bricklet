#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletTemperatureIR;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'jfp'; # Change to your UID

# Callback functions for object/ambient temperature callbacks 
# (parameters have unit °C/10)
sub cb_object
{
    my ($temperature) = @_;
    print "\nObject Temperature: ".$temperature/10.0." °C\n";
}
sub cb_ambient
{
    my ($temperature) = @_;
    print "\nAmbient Temperature: ".$temperature/10.0." °C\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $tir = Tinkerforge::BrickletTemperatureIR->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set Period for temperature callbacks to 1s (1000ms)
# Note: The callbacks are only called every second if the 
#       value has changed since the last call!
$tir->set_object_temperature_callback_period(1000);
$tir->set_ambient_temperature_callback_period(1000);

# Register object temperature callback to function cb_object
$tir->register_callback($tir->CALLBACK_OBJECT_TEMPERATURE, 'cb_object');
# Register ambient temperature callback to function cb_ambient
$tir->register_callback($tir->CALLBACK_AMBIENT_TEMPERATURE, 'cb_ambient');

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

