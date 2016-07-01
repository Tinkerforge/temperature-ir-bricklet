#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_temperature_ir'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = 'XYZ' # Change XYZ to the UID of your Temperature IR Bricklet

ipcon = IPConnection.new # Create IP connection
tir = BrickletTemperatureIR.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current ambient temperature (unit is °C/10)
ambient_temperature = tir.get_ambient_temperature
puts "Ambient Temperature: #{ambient_temperature/10.0} °C"

# Get current object temperature (unit is °C/10)
object_temperature = tir.get_object_temperature
puts "Object Temperature: #{object_temperature/10.0} °C"

puts 'Press key to exit'
$stdin.gets
ipcon.disconnect
