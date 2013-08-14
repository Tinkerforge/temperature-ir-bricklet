#!/bin/sh
# connects to localhost:4223 by default, use --host and --port to change it

# change to your UID
uid=XYZ

# Set emissivity to 0.98 (emissivity of water): 65535 * 0.98 ~= 64224
tinkerforge call temperature-ir-bricklet $uid set-emissivity 64224

# get threshold callbacks with a debounce time of 10 seconds (10000ms)
tinkerforge call temperature-ir-bricklet $uid set-debounce-period 10000

# configure threshold for "greater than 100 °C" (unit is °C/10)
tinkerforge call temperature-ir-bricklet $uid set-object-temperature-callback-threshold greater 1000 0

# handle incoming object-temperature-reached callbacks (unit is °C/10)
tinkerforge dispatch temperature-ir-bricklet $uid object-temperature-reached\
 --execute "echo The surface has a temperature of {temperature} C/10. The water is boiling!"
