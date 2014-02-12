var IPConnection = require('Tinkerforge/IPConnection');
var BrickletTemperatureIR = require('Tinkerforge/BrickletTemperatureIR');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'kqJ';// Change to your UID

var ipcon = new IPConnection();// Create IP connection
var tir = new BrickletTemperatureIR(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        // Set emissivity to 0.98 (emissivity of water)
        tir.setEmissivity(parseInt(0xFFFF*0.98));
        // Get threshold callbacks with a debounce time of 10 seconds (10000ms)
        tir.setDebouncePeriod(10000);
        // Configure threshold for "greater than 100 °C" (unit is °C/10)
        tir.setObjectTemperatureCallbackThreshold('>', 100*10, 0);    
    }
);

//Register threshold reached callback
tir.on(BrickletTemperatureIR.CALLBACK_OBJECT_TEMPERATURE_REACHED,
    //Callback for object temperature greater than 100 °C
    //(parameter has unit °C/10)
    function(temp) {
        console.log('The surface has a temperature of ' + temp/10.0 + ' °C.');
        console.log('The water is boiling!');
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

