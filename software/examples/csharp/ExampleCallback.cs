using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for object temperature callback (parameter has unit °C/10)
	static void ObjectTemperatureCB(BrickletTemperatureIR sender, short temperature)
	{
		Console.WriteLine("Object Temperature: " + temperature/10.0 + " °C");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Register object temperature callback to function ObjectTemperatureCB
		tir.ObjectTemperature += ObjectTemperatureCB;

		// Set period for object temperature callback to 1s (1000ms)
		// Note: The object temperature callback is only called every second
		//       if the object temperature has changed since the last call!
		tir.SetObjectTemperatureCallbackPeriod(1000);

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
