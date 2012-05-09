<?php

require_once('Tinkerforge/IPConnection.php');
require_once('Tinkerforge/BrickletTemperatureIR.php');

use Tinkerforge\IPConnection;
use Tinkerforge\BrickletTemperatureIR;

$host = 'localhost';
$port = 4223;
$uid = 'XYZ'; // Change to your UID

# Callback for object temperature greater than 100 °C
# (parameter has unit °C/10)
function cb_reached($temperature)
{
    echo "The surface has a temperature of " . $temperature / 10.0 . " °C.\n";
    echo "The water is boiling!\n";
}

$ipcon = new IPConnection($host, $port); // Create IP connection to brickd
$tir = new BrickletTemperatureIR($uid); // Create device object

$ipcon->addDevice($tir); // Add device to IP connection
// Don't use device before it is added to a connection

// Set emissivity to 0.98 (emissivity of water)
$tir->setEmissivity((int)(0xFFFF*0.98));

// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
$tir->setDebouncePeriod(10000);

// Register threshold reached callback to function cb_reached
$tir->registerCallback(tir.CALLBACK_OBJECT_TEMPERATURE_REACHED, 'cb_reached');

// Configure threshold for "greater than 100 °C" (unit is °C/10)
$tir->setObjectTemperatureCallbackThreshold('>', 100*10, 0);

echo "Press ctrl+c to exit\n";
$ipcon->dispatchCallbacks(-1); // Dispatch callbacks forever

?>
