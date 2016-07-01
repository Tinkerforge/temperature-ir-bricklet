function octave_example_callback()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Temperature IR Bricklet

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    tir = java_new("com.tinkerforge.BrickletTemperatureIR", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register object temperature callback to function cb_object_temperature
    tir.addObjectTemperatureCallback(@cb_object_temperature);

    % Set period for object temperature callback to 1s (1000ms)
    % Note: The object temperature callback is only called every second
    %       if the object temperature has changed since the last call!
    tir.setObjectTemperatureCallbackPeriod(1000);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

% Callback function for object temperature callback (parameter has unit °C/10)
function cb_object_temperature(e)
    fprintf("Object Temperature: %g °C\n", java2int(e.temperature)/10.0);
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
