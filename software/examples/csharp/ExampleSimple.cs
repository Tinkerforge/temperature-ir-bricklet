using Tinkerforge;

class Example
{
	private static string HOST = "localhost";
	private static int PORT = 4223;
	private static string UID = "XYZ"; // Change to your UID

	static void Main()
	{
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.Connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current ambient temperature (unit is °C/10)
		short ambientTemperature = tir.GetAmbientTemperature();
		System.Console.WriteLine("Ambient Temperature: " + ambientTemperature/10.0 + " °C");

		// Get current object temperature (unit is °C/10)
		short objectTemperature = tir.GetObjectTemperature();
		System.Console.WriteLine("Object Temperature: " + objectTemperature/10.0 + " °C");

		System.Console.WriteLine("Press enter to exit");
		System.Console.ReadLine();
		ipcon.Disconnect();
	}
}
