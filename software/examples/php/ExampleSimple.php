<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

$ipcon = new IPConnection(); // Create IP connection
$tir = new BrickletTemperatureIR($uid, $ipcon); // Create device object

$ipcon->connect($host, $port); // Connect to brickd
// Don't use device before ipcon is connected

// Get current object and ambient temperatures (unit is °C/10)
$obj = $tir->getObjectTemperature() / 10.0;
$amb = $tir->getAmbientTemperature() / 10.0;

echo "Object Temperature: $obj °C\n";
echo "Ambient Temperature: $amb °C\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->disconnect();

?>
