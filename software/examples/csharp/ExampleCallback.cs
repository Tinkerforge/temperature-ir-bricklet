using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback functions for object/ambient temperature callback 
	// (parameters have unit °C/10)
	static void ObjectCB(short temperature)
	{
		System.Console.WriteLine("Object Temperature: " + temperature/10.0 + " °C");
	}

	static void AmbientCB(short temperature)
	{
		System.Console.WriteLine("Ambient Temperature: " + temperature/10.0 + " °C");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletTemperatureIR temp = new BrickletTemperatureIR(UID); // Create device object
		ipcon.AddDevice(temp); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Set Period for temperature callbacks to 1s (1000ms)
		// Note: The callbacks are only called every second if the 
		//       value has changed since the last call!
		temp.SetObjectTemperatureCallbackPeriod(1000);
		temp.SetAmbientTemperatureCallbackPeriod(1000);

		// Register object temperature callback to function ObjectCB
		temp.RegisterCallback(new BrickletTemperatureIR.ObjectTemperature(ObjectCB));
		// Register ambient temperature callback to function AmbientCB
		temp.RegisterCallback(new BrickletTemperatureIR.AmbientTemperature(AmbientCB));

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
