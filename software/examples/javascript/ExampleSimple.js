var Tinkerforge = require('tinkerforge');

var HOST = 'localhost';
var PORT = 4223;
var UID = 'kqJ';// Change to your UID

var ipcon = new Tinkerforge.IPConnection();// Create IP connection
var tir = new Tinkerforge.BrickletTemperatureIR(UID, ipcon);// Create device object

ipcon.connect(HOST, PORT,
    function(error) {
        console.log('Error: '+error);        
    }
);// Connect to brickd

// Don't use device before ipcon is connected
ipcon.on(Tinkerforge.IPConnection.CALLBACK_CONNECTED,
    function(connectReason) {
        //Get current object and ambient temperatures (unit is °C/10)
        tir.getObjectTemperature(
            function(obj) {
                console.log('Object Temperature: '+obj/10+' °C');
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
        tir.getAmbientTemperature(
            function(amb) {
                console.log('Ambient Temperature: '+amb/10+' °C');
            },
            function(error) {
                console.log('Error: '+error);
            }
        );
    }
);

console.log("Press any key to exit ...");
process.stdin.on('data',
    function(data) {
        ipcon.disconnect();
        process.exit(0);
    }
);

