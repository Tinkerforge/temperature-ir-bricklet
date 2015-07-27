using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	// Callback function for ambient temperature callback (parameter has unit °C/10)
	static void AmbientTemperatureCB(BrickletTemperatureIR sender, short ambientTemperature)
	{
		System.Console.WriteLine("Ambient Temperature: " + ambientTemperature/10.0 + " °C");
	}

	// Callback function for object temperature callback (parameter has unit °C/10)
	static void ObjectTemperatureCB(BrickletTemperatureIR sender, short objectTemperature)
	{
		System.Console.WriteLine("Object Temperature: " + objectTemperature/10.0 + " °C");
	}

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for ambient temperature callback to 1s (1000ms)
		// Note: The ambient temperature callback is only called every second
		//       if the ambient temperature has changed since the last call!
		tir.SetAmbientTemperatureCallbackPeriod(1000);

		// Register ambient temperature callback to function AmbientTemperatureCB
		tir.AmbientTemperature += AmbientTemperatureCB;

		// Set period for object temperature callback to 1s (1000ms)
		// Note: The object temperature callback is only called every second
		//       if the object temperature has changed since the last call!
		tir.SetObjectTemperatureCallbackPeriod(1000);

		// Register object temperature callback to function ObjectTemperatureCB
		tir.ObjectTemperature += ObjectTemperatureCB;

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
