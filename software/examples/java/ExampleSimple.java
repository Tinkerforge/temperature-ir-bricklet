import com.tinkerforge.BrickletTemperatureIR;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
	private static final String host = "localhost";
	private static final int port = 4223;
	private static final String UID = "ABC"; // Change to your UID
	
	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the commnents below
	public static void main(String args[]) throws Exception {
		// Create connection to brickd
		IPConnection ipcon = new IPConnection(host, port); // Can throw IOException
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID); // Create device object

		// Add device to IP connection
		ipcon.addDevice(tir); // Can throw IPConnection.TimeoutException
		// Don't use device before it is added to a connection

		// Get current object and ambient temperature (unit is °C/10)
		short obj = tir.getObjectTemperature(); // Can throw IPConnection.TimeoutException
		short amb = tir.getAmbientTemperature(); // Can throw IPConnection.TimeoutException

		System.out.println("Object Temperature: " + obj/10.0 + " °C");
		System.out.println("Ambient Temperature: " + amb/10.0 + " °C");

		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}
