#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# set period for object-temperature callback to 1s (1000ms)
# note: the object-temperature callback is only called every second if the
#       object-temperature has changed since the last call!
tinkerforge call temperature-ir-bricklet $uid set-object-temperature-callback-period 1000

# handle incoming object-temperature callbacks (unit is °C/10)
tinkerforge dispatch temperature-ir-bricklet $uid object-temperature
