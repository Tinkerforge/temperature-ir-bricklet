package main

import (
	"fmt"
	"tinkerforge/ipconnection"
	"tinkerforge/temperature_ir_bricklet"
)

const ADDR string = "localhost:4223"
const UID string = "XYZ" // Change XYZ to the UID of your Temperature IR Bricklet.

func main() {
	ipcon := ipconnection.New()
	defer ipcon.Close()
	tir, _ := temperature_ir_bricklet.New(UID, &ipcon) // Create device object.

	ipcon.Connect(ADDR) // Connect to brickd.
	defer ipcon.Disconnect()
	// Don't use device before ipcon is connected.

	// Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
	tir.SetEmissivity(64224)

	// Get threshold receivers with a debounce time of 10 seconds (10000ms).
	tir.SetDebouncePeriod(10000)

	tir.RegisterObjectTemperatureReachedCallback(func(temperature int16) {
		fmt.Printf("Object Temperature: %f °C\n", float64(temperature)/10.0)
		fmt.Println("The water is boiling!")
	})

	// Configure threshold for object temperature "greater than 100 °C".
	tir.SetObjectTemperatureCallbackThreshold('>', 100*10, 0)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()

}
