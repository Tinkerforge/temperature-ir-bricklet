<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change XYZ to the UID of your Temperature IR Bricklet

// Callback function for object temperature callback (parameter has unit °C/10)
function cb_objectTemperature($temperature)
{
    echo "Object Temperature: " . $temperature/10.0 . " °C\n";
}

$ipcon = new IPConnection(); // Create IP connection
$tir = new BrickletTemperatureIR(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Register object temperature callback to function cb_objectTemperature
$tir->registerCallback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE,
                       'cb_objectTemperature');

// Set period for object temperature callback to 1s (1000ms)
// Note: The object temperature callback is only called every second
//       if the object temperature has changed since the last call!
$tir->setObjectTemperatureCallbackPeriod(1000);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
