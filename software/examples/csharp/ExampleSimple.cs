using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "ABC"; // Change to your UID

	static void Main() 
	{
		IPConnection ipcon = new IPConnection(HOST, PORT); // Create connection to brickd
		BrickletTemperatureIR temp = new BrickletTemperatureIR(UID); // Create device object
		ipcon.AddDevice(temp); // Add device to IP connection
		// Don't use device before it is added to a connection

		// Get current object and ambient temperatures (unit is °C/10)
		short obj = temp.GetObjectTemperature();
		short amb = temp.GetAmbientTemperature();

		System.Console.WriteLine("Object Temperature: " + obj/10.0 + " °C");
		System.Console.WriteLine("Ambient Temperature: " + amb/10.0 + " °C");

		System.Console.WriteLine("Press ctrl+c to exit");
		ipcon.JoinThread();
	}
}
