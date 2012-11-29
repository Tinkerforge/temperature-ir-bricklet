#!/usr/bin/env ruby
# -*- ruby encoding: utf-8 -*-

require 'tinkerforge/ip_connection'
require 'tinkerforge/bricklet_temperature_ir'

include Tinkerforge

HOST = 'localhost'
PORT = 4223
UID = '8Xb' # Change to your UID

ipcon = IPConnection.new # Create IP connection
tir = BrickletTemperatureIR.new UID, ipcon # Create device object

ipcon.connect HOST, PORT # Connect to brickd
# Don't use device before ipcon is connected

# Get current object and ambient temperatures (unit is °C/10)
obj = tir.get_object_temperature / 10.0
amb = tir.get_ambient_temperature / 10.0

puts "Object Temperature: #{obj} °C"
puts "Ambient Temperature: #{amb} °C"

puts 'Press key to exit'
$stdin.gets
