using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback for object temperature greater than 100 °C (parameter has unit °C/10)
	static void ReachedCB(short temperature)
	{
		System.Console.WriteLine("The surface has a temperature of " + 
		                         temperature/10.0 + 
		                         " °C");
		System.Console.WriteLine("The water is boiling!");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletTemperatureIR temp = new BrickletTemperatureIR(UID); // Create device object
		ipcon.AddDevice(temp); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Set emissivity to 0.98 (emissivity of water)
		temp.SetEmissivity((ushort)(0xFFFF*0.98));

		// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
		temp.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReachedCB
		temp.RegisterCallback(new BrickletTemperatureIR.ObjectTemperatureReached(ReachedCB));

		// Configure threshold for "greater than 100 °C" (unit is °C/10)
		temp.SetObjectTemperatureCallbackThreshold('>', 100*10, 0);

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
