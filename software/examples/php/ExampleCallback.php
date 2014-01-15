<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback functions for object/ambient temperature callbacks 
// (parameters have unit °C/10)
function cb_object($temperature)
{
    echo "Object Temperature: " . $temperature / 10.0 . " °C\n";
}

function cb_ambient($temperature)
{
    echo "Ambient Temperature: " . $temperature / 10.0 . " °C\n";
}

$ipcon = new IPConnection(); // Create IP connection
$tir = new BrickletTemperatureIR(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set Period for temperature callbacks to 1s (1000ms)
// Note: The callbacks are only called every second if the 
//       value has changed since the last call!
$tir->setObjectTemperatureCallbackPeriod(1000);
$tir->setAmbientTemperatureCallbackPeriod(1000);

// Register object temperature callback to function cb_object
$tir->registerCallback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE, 'cb_object');
// Register ambient temperature callback to function cb_ambient
$tir->registerCallback(BrickletTemperatureIR::CALLBACK_AMBIENT_TEMPERATURE, 'cb_ambient');

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
