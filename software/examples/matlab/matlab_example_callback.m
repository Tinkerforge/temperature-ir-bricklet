function matlab_example_callback
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kqw'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set Period for temperature callbacks to 1s (1000ms)
    % Note: The callbacks are only called every second if the 
    %       value has changed since the last call!
    tir.setObjectTemperatureCallbackPeriod(1000);
    tir.setAmbientTemperatureCallbackPeriod(1000);

    % Register object temperature callback to function cb_object
    set(tir, 'ObjectTemperatureCallback', @(h, e)cb_object(e.temperature));
    % Register ambient temperature callback to function cb_ambient
    set(tir, 'AmbientTemperatureCallback', @(h, e)cb_ambient(e.temperature));

    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback functions for object/ambient temperature callbacks 
% (parameters have unit °C/10)
function cb_object(temperature)
    fprintf('Object Temperature: %g°C\n', temperature/10);
end
function cb_ambient(temperature)
    fprintf('Ambient Temperature: %g°C\n', temperature/10);
end
