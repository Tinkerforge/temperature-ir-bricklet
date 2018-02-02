var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'XYZ'; // Change XYZ to the UID of your Temperature IR Bricklet

var ipcon = new Tinkerforge.IPConnection(); // Create IP connection
var tir = new Tinkerforge.BrickletTemperatureIR(UID, ipcon); // Create device object

ipcon.connect(HOST, PORT,
    function (error) {
        console.log('Error: ' + error);
    }
); // Connect to brickd
// Don't use device before ipcon is connected

ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function (connectReason) {
        // Set period for object temperature callback to 1s (1000ms)
        // Note: The object temperature callback is only called every second
        //       if the object temperature has changed since the last call!
        tir.setObjectTemperatureCallbackPeriod(1000);
    }
);

// Register object temperature callback
tir.on(Tinkerforge.BrickletTemperatureIR.CALLBACK_OBJECT_TEMPERATURE,
    // Callback function for object temperature callback
    function (temperature) {
        console.log('Object Temperature: ' + temperature/10.0 + ' °C');
    }
);

console.log('Press key to exit');
process.stdin.on('data',
    function (data) {
        ipcon.disconnect();
        process.exit(0);
    }
);
