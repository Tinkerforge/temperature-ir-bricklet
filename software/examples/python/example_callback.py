#!/usr/bin/env python
# -*- coding: utf-8 -*-

HOST = "localhost"
PORT = 4223
UID = "XYZ" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_temperature_ir import BrickletTemperatureIR

# Callback function for ambient temperature callback (parameter has unit °C/10)
def cb_ambient_temperature(ambient_temperature):
    print('Ambient Temperature: ' + str(ambient_temperature/10.0) + ' °C')

# Callback function for object temperature callback (parameter has unit °C/10)
def cb_object_temperature(object_temperature):
    print('Object Temperature: ' + str(object_temperature/10.0) + ' °C')

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    tir = BrickletTemperatureIR(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Set period for ambient temperature callback to 1s (1000ms)
    # Note: The ambient temperature callback is only called every second
    #       if the ambient temperature has changed since the last call!
    tir.set_ambient_temperature_callback_period(1000)

    # Register ambient temperature callback to function cb_ambient_temperature
    tir.register_callback(tir.CALLBACK_AMBIENT_TEMPERATURE, cb_ambient_temperature)

    # Set period for object temperature callback to 1s (1000ms)
    # Note: The object temperature callback is only called every second
    #       if the object temperature has changed since the last call!
    tir.set_object_temperature_callback_period(1000)

    # Register object temperature callback to function cb_object_temperature
    tir.register_callback(tir.CALLBACK_OBJECT_TEMPERATURE, cb_object_temperature)

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
