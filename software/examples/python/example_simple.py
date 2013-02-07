#!/usr/bin/env python
# -*- coding: utf-8 -*-  

HOST = "localhost"
PORT = 4223
UID = "abcde" # Change to your UID

from tinkerforge.ip_connection import IPConnection
from tinkerforge.bricklet_temperature_ir import TemperatureIR

if __name__ == "__main__":
    ipcon = IPConnection() # Create IP connection
    tir = TemperatureIR(UID, ipcon) # Create device object

    ipcon.connect(HOST, PORT) # Connect to brickd
    # Don't use device before ipcon is connected

    # Get current object and ambient temperatures (unit is °C/10)
    obj = tir.get_object_temperature()/10.0
    amb = tir.get_ambient_temperature()/10.0

    print('Object Temperature: ' + str(obj) + ' °C')
    print('Ambient Temperature: ' + str(amb) + ' °C')

    raw_input('Press key to exit\n') # Use input() in Python 3
    ipcon.disconnect()
