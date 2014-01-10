#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletTemperatureIR;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'jfp'; # Change to your UID

# Callback for object temperature greater than 100 °C
# (parameter has unit °C/10)
sub cb_reached
{
    my ($temperature) = @_;
    print "\nThe surface has a temperature of ".$temperature/10.0." °C.";
    print "\nThe water is boiling!\n";
}

my $ipcon = IPConnection->new(); # Create IP connection
my $tir = BrickletTemperatureIR->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Set emissivity to 0.98 (emissivity of water)
$tir->set_emissivity(0xFFFF*0.98);

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$tir->set_debounce_period(10000);

# Register threshold reached callback to function cb_reached
$tir->register_callback($tir->CALLBACK_OBJECT_TEMPERATURE_REACHED, 'cb_reached');

# Configure threshold for "greater than 100 °C" (unit is °C/10)
$tir->set_object_temperature_callback_threshold('>', 100*10, 0);

print "\nPress any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

