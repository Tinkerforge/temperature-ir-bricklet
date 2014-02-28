var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'kqJ'; // Change to your UID

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var tir = new Tinkerforge.BrickletTemperatureIR(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set Period for temperature callbacks to 1s (1000ms)
        // Note: The callbacks are only called every second if the
        // value has changed since the last call!
        tir.setObjectTemperatureCallbackPeriod(1000);
        tir.setAmbientTemperatureCallbackPeriod(1000);
    }
);

// Register object temperature callback
tir.on(Tinkerforge.BrickletTemperatureIR.CALLBACK_OBJECT_TEMPERATURE,
    // Callback functions for object/ambient temperature callbacks
    // (parameters have unit °C/10)
    function(temp) {
        console.log('Object Temperature: '+temp/10+' °C');
        console.log();
    }
);
// Register ambient temperature callback
tir.on(Tinkerforge.BrickletTemperatureIR.CALLBACK_AMBIENT_TEMPERATURE,
    // Callback functions for object/ambient temperature callbacks
    // (parameters have unit °C/10)
    function(temp) {
        console.log('Ambient Temperature: '+temp/10+' °C');
        console.log();
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
