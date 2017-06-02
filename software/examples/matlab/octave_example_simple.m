function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "XYZ"; % Change XYZ to the UID of your Temperature IR Bricklet

    ipcon = javaObject("com.tinkerforge.IPConnection"); % Create IP connection
    tir = javaObject("com.tinkerforge.BrickletTemperatureIR", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current ambient temperature (unit is °C/10)
    ambientTemperature = tir.getAmbientTemperature();
    fprintf("Ambient Temperature: %g °C\n", java2int(ambientTemperature)/10.0);

    % Get current object temperature (unit is °C/10)
    objectTemperature = tir.getObjectTemperature();
    fprintf("Object Temperature: %g °C\n", java2int(objectTemperature)/10.0);

    input("Press key to exit\n", "s");
    ipcon.disconnect();
end

function int = java2int(value)
    if compare_versions(version(), "3.8", "<=")
        int = value.intValue();
    else
        int = value;
    end
end
