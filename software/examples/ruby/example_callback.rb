#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_temperature_ir'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change to your UID

ipcon = IPConnection.new # Create IP connection
tir = BrickletTemperatureIR.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Set period for ambient temperature callback to 1s (1000ms)
# Note: The ambient temperature callback is only called every second
#       if the ambient temperature has changed since the last call!
tir.set_ambient_temperature_callback_period 1000

# Register ambient temperature callback (parameter has unit °C/10)
tir.register_callback(BrickletTemperatureIR::CALLBACK_AMBIENT_TEMPERATURE) do |ambient_temperature|
  puts "Ambient Temperature: #{ambient_temperature/10.0} °C"
end

# Set period for object temperature callback to 1s (1000ms)
# Note: The object temperature callback is only called every second
#       if the object temperature has changed since the last call!
tir.set_object_temperature_callback_period 1000

# Register object temperature callback (parameter has unit °C/10)
tir.register_callback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE) do |object_temperature|
  puts "Object Temperature: #{object_temperature/10.0} °C"
end

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
