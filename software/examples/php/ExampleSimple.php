<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$tir = new BrickletTemperatureIR(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Get current ambient temperature (unit is °C/10)
$ambient_temperature = $tir->getAmbientTemperature();
echo "Ambient Temperature: " . $ambient_temperature/10.0 . " °C\n";

// Get current object temperature (unit is °C/10)
$object_temperature = $tir->getObjectTemperature();
echo "Object Temperature: " . $object_temperature/10.0 . " °C\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
