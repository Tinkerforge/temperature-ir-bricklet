function octave_example_simple()
    more off;

    HOST = "localhost";
    PORT = 4223;
    UID = "kqw"; % Change to your UID

    ipcon = java_new("com.tinkerforge.IPConnection"); % Create IP connection
    tir = java_new("com.tinkerforge.BrickletTemperatureIR", UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current object and ambient temperatures (unit is °C/10)
    obj = tir.getObjectTemperature();
    amb = tir.getAmbientTemperature();
    fprintf("Object Temperature: %g°C\n", short2int(obj)/10.0);
    fprintf("Ambient Temperature: %g°C\n", short2int(amb)/10.0);

    input("Press any key to exit...\n", "s");
    ipcon.disconnect();
end

function int = short2int(short)
    if compare_versions(version(), "3.8", "<=")
        int = short.intValue();
    else
        int = short;
    end
end
