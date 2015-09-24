function matlab_example_simple()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current ambient temperature (unit is °C/10)
    ambientTemperature = tir.getAmbientTemperature();
    fprintf('Ambient Temperature: %g °C\n', ambientTemperature/10.0);

    % Get current object temperature (unit is °C/10)
    objectTemperature = tir.getObjectTemperature();
    fprintf('Object Temperature: %g °C\n', objectTemperature/10.0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end
