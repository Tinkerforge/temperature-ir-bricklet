#!/bin/sh
# Connects to localhost:4223 by default, use --host and --port to change this

uid=XYZ # Change to your UID

# Handle incoming object temperature callbacks (parameter has unit °C/10)
tinkerforge dispatch temperature-ir-bricklet $uid object-temperature &

# Set period for object temperature callback to 1s (1000ms)
# Note: The object temperature callback is only called every second
#       if the object temperature has changed since the last call!
tinkerforge call temperature-ir-bricklet $uid set-object-temperature-callback-period 1000

echo "Press key to exit"; read dummy

kill -- -$$ # Stop callback dispatch in background
