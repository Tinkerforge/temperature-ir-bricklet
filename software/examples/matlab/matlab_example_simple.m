function matlab_example_simple
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kqw'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Get current object and ambient temperatures (unit is °C/10)
    obj = tir.getObjectTemperature();
    amb = tir.getAmbientTemperature();
    print('Object Temperature: %g°C\n', obj/10.0);
    print('Ambient Temperature: %g°C\n', amb/10.0);

    input('Press any key to exit...\n', 's');
    ipcon.disconnect();
end
