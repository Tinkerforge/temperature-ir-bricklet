function matlab_example_water_boiling
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'kqw'; % Change to your UID
    
    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set emissivity to 0.98 (emissivity of water)
    tir.setEmissivity(hex2num('FFFF')*0.98);

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    tir.setDebouncePeriod(10000)

    % Register threshold reached callback to function cb_reached
    set(tir, 'ObjectTemperatureReachedCallback', @(h, e)cb_reached(e.temperature));

    % Configure threshold for "greater than 100 °C" (unit is °C/10)
    tir.setObjectTemperatureCallbackThreshold('>', 100*10, 0);
    
    input('\nPress any key to exit...\n', 's');
    ipcon.disconnect();
end

% Callback for object temperature greater than 100 °C
% (parameter has unit °C/10)
function cb_reached(temperature)
    fprintf('The surface has a temperature of %g°C.\n', temperature/10);
    fprintf('The water is boiling!\n');
end
