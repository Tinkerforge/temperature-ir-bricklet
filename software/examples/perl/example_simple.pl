#!/usr/bin/perl  

use Tinkerforge::IPConnection;
use Tinkerforge::BrickletTemperatureIR;

use constant HOST => 'localhost';
use constant PORT => 4223;
use constant UID => 'jfp'; # Change to your UID

my $ipcon = Tinkerforge::IPConnection->new(); # Create IP connection
my $tir = Tinkerforge::BrickletTemperatureIR->new(&UID, $ipcon); # Create device object

$ipcon->connect(&HOST, &PORT); # Connect to brickd
# Don't use device before ipcon is connected

# Get current object and ambient temperatures (unit is °C/10)
my $obj = $tir->get_object_temperature()/10.0;
my $amb = $tir->get_ambient_temperature()/10.0;

print "Object Temperature: ".$obj." °C\n";
print "Ambient Temperature: ".$amb." °C\n";

print "Press any key to exit...\n";
<STDIN>;
$ipcon->disconnect();

