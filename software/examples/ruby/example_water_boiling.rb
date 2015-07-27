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

# Set emissivity to 0.98 (emissivity of water)
tir.set_emissivity((0xFFFF * 0.98).to_i)

# Get threshold callbacks with a debounce time of 10 seconds (10000ms)
tir.set_debounce_period 10000

# Register Callback for object temperature greater than 100 °C (parameter has unit °C/10)
tir.register_callback(BrickletTemperatureIR::CALLBACK_OBJECT_TEMPERATURE_REACHED) do |temperature|
  puts "The surface has a temperature of #{temperature/10.0} °C."
  puts "The water is boiling!"
end

# Configure threshold for "greater than 100 °C" (unit is °C/10)
tir.set_object_temperature_callback_threshold '>', 100*10, 0

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
