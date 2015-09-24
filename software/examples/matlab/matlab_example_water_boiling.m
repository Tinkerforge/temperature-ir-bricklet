function matlab_example_water_boiling()
    import com.tinkerforge.IPConnection;
    import com.tinkerforge.BrickletTemperatureIR;

    HOST = 'localhost';
    PORT = 4223;
    UID = 'XYZ'; % Change to your UID

    ipcon = IPConnection(); % Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon); % Create device object

    ipcon.connect(HOST, PORT); % Connect to brickd
    % Don't use device before ipcon is connected

    % Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
    tir.setEmissivity(64224);

    % Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    tir.setDebouncePeriod(10000);

    % Register object temperature reached callback to function cb_object_temperature_reached
    set(tir, 'ObjectTemperatureReachedCallback', @(h, e) cb_object_temperature_reached(e));

    % Configure threshold for object temperature "greater than 100 °C" (unit is °C/10)
    tir.setObjectTemperatureCallbackThreshold('>', 100*10, 0);

    input('Press key to exit\n', 's');
    ipcon.disconnect();
end

% Callback function for object temperature reached callback (parameter has unit °C/10)
function cb_object_temperature_reached(e)
    fprintf('Object Temperature: %g °C\n', e.temperature/10.0);
    fprintf('The water is boiling!\n');
end
