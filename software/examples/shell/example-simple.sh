#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Get current ambient temperature (unit is °C/10)
tinkerforge call temperature-ir-bricklet $uid get-ambient-temperature

# Get current object temperature (unit is °C/10)
tinkerforge call temperature-ir-bricklet $uid get-object-temperature
