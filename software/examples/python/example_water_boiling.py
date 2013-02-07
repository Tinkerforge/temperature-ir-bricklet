#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abcde" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_temperature_ir import TemperatureIR

# Callback for object temperature greater than 100 °C
# (parameter has unit °C/10)
def cb_reached(temperature):
    print('The surface has a temperature of ' + str(temperature/10.0) + ' °C.')
    print('The water is boiling!')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    tir = TemperatureIR(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set emissivity to 0.98 (emissivity of water)
    tir.set_emissivity(int(0xFFFF*0.98))

    # Get threshold callbacks with a debounce time of 10 seconds (10000ms)
    tir.set_debounce_period(10000)

    # Register threshold reached callback to function cb_reached
    tir.register_callback(tir.CALLBACK_OBJECT_TEMPERATURE_REACHED, cb_reached)

    # Configure threshold for "greater than 100 °C" (unit is °C/10)
    tir.set_object_temperature_callback_threshold('>', 100*10, 0)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
