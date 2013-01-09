using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	// Callback for object temperature greater than 100 °C (parameter has unit °C/10)
	static void ReachedCB(BrickletTemperatureIR sender, short temperature)
	{
		System.Console.WriteLine("The surface has a temperature of " + 
		                         temperature/10.0 + 
		                         " °C");
		System.Console.WriteLine("The water is boiling!");
	}

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR temp = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set emissivity to 0.98 (emissivity of water)
		temp.SetEmissivity((ushort)(0xFFFF*0.98));

		// Get threshold callbacks with a debounce time of 1 seconds (1000ms)
		temp.SetDebouncePeriod(1000);

		// Register threshold reached callback to function ReachedCB
		temp.ObjectTemperatureReached += ReachedCB;

		// Configure threshold for "greater than 100 °C" (unit is °C/10)
		temp.SetObjectTemperatureCallbackThreshold('>', 100*10, 0);

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
	}
}
