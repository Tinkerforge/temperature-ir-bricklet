<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

$ipcon = new IPConnection($host, $port); // Create IP connection to brickd
$tir = new BrickletTemperatureIR($uid); // Create device object

$ipcon->addDevice($tir); // Add device to IP connection
// Don't use device before it is added to a connection

// Get current object and ambient temperatures (unit is °C/10)
$obj = $tir->getObjectTemperature() / 10.0;
$amb = $tir->getAmbientTemperature() / 10.0;

echo "Object Temperature: $obj °C\n";
echo "Ambient Temperature: $amb °C\n";

echo "Press key to exit\n";
fgetc(fopen('php://stdin', 'r'));
$ipcon->destroy();

?>
