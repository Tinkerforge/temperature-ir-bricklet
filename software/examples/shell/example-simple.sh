#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change XYZ to the UID of your Temperature IR Bricklet

# Get current ambient temperature
tinkerforge call temperature-ir-bricklet $uid get-ambient-temperature

# Get current object temperature
tinkerforge call temperature-ir-bricklet $uid get-object-temperature
