using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR temp = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current object and ambient temperatures (unit is °C/10)
		short obj = temp.GetObjectTemperature();
		short amb = temp.GetAmbientTemperature();

		System.Console.WriteLine("Object Temperature: " + obj/10.0 + " °C");
		System.Console.WriteLine("Ambient Temperature: " + amb/10.0 + " °C");

		System.Console.WriteLine("Press key to exit");
		System.Console.ReadKey();
	}
}
