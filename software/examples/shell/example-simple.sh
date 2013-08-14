#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# get current ambient and object temperatures (unit is °C/10)
tinkerforge call temperature-ir-bricklet $uid get-object-temperature
tinkerforge call temperature-ir-bricklet $uid get-ambient-temperature
