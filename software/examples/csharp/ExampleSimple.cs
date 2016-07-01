using System;
using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change XYZ to the UID of your Temperature IR Bricklet

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current ambient temperature (unit is °C/10)
		short ambientTemperature = tir.GetAmbientTemperature();
		Console.WriteLine("Ambient Temperature: " + ambientTemperature/10.0 + " °C");

		// Get current object temperature (unit is °C/10)
		short objectTemperature = tir.GetObjectTemperature();
		Console.WriteLine("Object Temperature: " + objectTemperature/10.0 + " °C");

		Console.WriteLine("Press enter to exit");
		Console.ReadLine();
		ipcon.Disconnect();
	}
}
