#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_temperature_ir'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '8Xb' # Change to your UID

ipcon = IPConnection.new HOST, PORT # Create IP connection to brickd
tir = BrickletTemperatureIR.new UID # Create device object
ipcon.add_device tir # Add device to IP connection
# Don't use device before it is added to a connection

# Set Period for temperature callbacks to 1s (1000ms)
# Note: The callbacks are only called every second if the 
#       value has changed since the last call!
tir.set_object_temperature_callback_period 1000
tir.set_ambient_temperature_callback_period 1000

# Register callback function for object temperature callback (parameters have unit °C/10)
tir.register_callback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE) do |temperature|
  puts "Object Temperature: #{temperature/10.0} °C"
end

# Register callback function for ambient temperature callback (parameters have unit °C/10)
tir.register_callback(BrickletTemperatureIR::CALLBACK_AMBIENT_TEMPERATURE) do |temperature|
  puts "Ambient Temperature: #{temperature/10.0} °C"
end

puts 'Press key to exit'
$stdin.gets
ipcon.destroy
