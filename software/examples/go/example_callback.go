package main

import (
	"fmt"
	"github.com/Tinkerforge/go-api-bindings/ipconnection"
	"github.com/Tinkerforge/go-api-bindings/temperature_ir_bricklet"
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

	tir.RegisterObjectTemperatureCallback(func(temperature int16) {
		fmt.Printf("Object Temperature: %f °C\n", float64(temperature)/10.0)
	})

	// Set period for object temperature receiver to 1s (1000ms).
	// Note: The object temperature callback is only called every second
	//       if the object temperature has changed since the last call!
	tir.SetObjectTemperatureCallbackPeriod(1000)

	fmt.Print("Press enter to exit.")
	fmt.Scanln()
}
