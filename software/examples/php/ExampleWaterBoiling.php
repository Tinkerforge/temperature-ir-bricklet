<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

const HOST = 'localhost';
const PORT = 4223;
const UID = 'XYZ'; // Change to your UID

// Callback function for object temperature reached callback (parameter has unit °C/10)
function cb_objectTemperatureReached($temperature)
{
    echo "Object Temperature: " . $temperature/10.0 . " °C\n";
    echo "The water is boiling!\n";
}

$ipcon = new IPConnection(); // Create IP connection
$tir = new BrickletTemperatureIR(UID, $ipcon); // Create device object

$ipcon->connect(HOST, PORT); // Connect to brickd
// Don't use device before ipcon is connected

// Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
$tir->setEmissivity(64224);

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$tir->setDebouncePeriod(10000);

// Register object temperature reached callback to function cb_objectTemperatureReached
$tir->registerCallback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE_REACHED,
                       'cb_objectTemperatureReached');

// Configure threshold for object temperature "greater than 100 °C" (unit is °C/10)
$tir->setObjectTemperatureCallbackThreshold('>', 100*10, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
