import com.tinkerforge.BrickletTemperatureIR;
import com.tinkerforge.IPConnection;

public class ExampleSimple {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "ABC"; // Change to your UID
	
	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Get current object and ambient temperature (unit is °C/10)
		short obj = tir.getObjectTemperature(); // Can throw com.tinkerforge.TimeoutException
		short amb = tir.getAmbientTemperature(); // Can throw com.tinkerforge.TimeoutException

		System.out.println("Object Temperature: " + obj/10.0 + " °C");
		System.out.println("Ambient Temperature: " + amb/10.0 + " °C");

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
