function octave_example_water_boiling()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "kqw"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    tir = java_new("com.tinkerforge.BrickletTemperatureIR", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set emissivity to 0.98 (emissivity of water)
    tir.setEmissivity(hex2num("FFFF")*0.98);

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    tir.setDebouncePeriod(10000)

    % Register threshold reached callback to function cb_reached
    tir.addObjectTemperatureReachedCallback(@cb_reached);

    % Configure threshold for "greater than 100 °C" (unit is °C/10)
    tir.setObjectTemperatureCallbackThreshold(">", 100*10, 0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

% Callback for object temperature greater than 100 °C (parameter has unit °C/10)
function cb_reached(e)
    fprintf("The surface has a temperature of %g°C.\n", short2int(e.temperature)/10.0);
    fprintf("The water is boiling!\n");
end

function int = short2int(short)
    if compare_versions(version(), "3.8", "<=")
        int = short.intValue();
    else
        int = short;
    end
end
