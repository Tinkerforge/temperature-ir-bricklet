#!/usr/bin/perl

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletTemperatureIR;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'XYZ'; # Change XYZ to the UID of your Temperature IR Bricklet

# Callback subroutine for object temperature reached callback (parameter has unit °C/10)
sub cb_object_temperature_reached
{
    my ($temperature) = @_;

    print "Object Temperature: " . $temperature/10.0 . " °C\n";
    print "The water is boiling!\n";
}

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $tir = Tinkerforge::BrickletTemperatureIR->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
$tir->set_emissivity(64224);

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$tir->set_debounce_period(10000);

# Register object temperature reached callback to subroutine cb_object_temperature_reached
$tir->register_callback($tir->CALLBACK_OBJECT_TEMPERATURE_REACHED,
                        'cb_object_temperature_reached');

# Configure threshold for object temperature "greater than 100 °C" (unit is °C/10)
$tir->set_object_temperature_callback_threshold('>', 100*10, 0);

print "Press key to exit\n";
<STDIN>;
$ipcon->disconnect();
