function matlab_example_callback()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Register object temperature callback to function cb_object_temperature
    set(tir, 'ObjectTemperatureCallback', @(h, e) cb_object_temperature(e));

    % Set period for object temperature callback to 1s (1000ms)
    % Note: The object temperature callback is only called every second
    %       if the object temperature has changed since the last call!
    tir.setObjectTemperatureCallbackPeriod(1000);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for object temperature callback (parameter has unit °C/10)
function cb_object_temperature(e)
    fprintf('Object Temperature: %g °C\n', e.temperature/10.0);
end
