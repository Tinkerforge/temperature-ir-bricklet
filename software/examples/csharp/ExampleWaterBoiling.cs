using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Temperature IR Bricklet

	// Callback function for object temperature reached callback (parameter has unit °C/10)
	static void ObjectTemperatureReachedCB(BrickletTemperatureIR sender,
	                                       short temperature)
	{
		Console.WriteLine("Object Temperature: " + temperature/10.0 + " °C");
		Console.WriteLine("The water is boiling!");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
		tir.SetEmissivity(64224);

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		tir.SetDebouncePeriod(10000);

		// Register object temperature reached callback to function
		// ObjectTemperatureReachedCB
		tir.ObjectTemperatureReachedCallback += ObjectTemperatureReachedCB;

		// Configure threshold for object temperature "greater than 100 °C" (unit is °C/10)
		tir.SetObjectTemperatureCallbackThreshold('>', 100*10, 0);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
