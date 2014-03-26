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
    obj = tir.getObjectTemperature()/10;
    amb = tir.getAmbientTemperature()/10;

    print('Object Temperature: %g°C\n', obj);
    print('Ambient Temperature: %g°C\n', amb);

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end
