import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletTemperatureIR;

public class ExampleWaterBoiling {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;

	// Change XYZ to the UID of your Temperature IR Bricklet
	private static final String UID = "XYZ";

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions
	//       you might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
		tir.setEmissivity(64224);

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		tir.setDebouncePeriod(10000);

		// Add object temperature reached listener (parameter has unit °C/10)
		tir.addObjectTemperatureReachedListener(new BrickletTemperatureIR.ObjectTemperatureReachedListener() {
			public void objectTemperatureReached(short temperature) {
				System.out.println("Object Temperature: " + temperature/10.0 + " °C");
				System.out.println("The water is boiling!");
			}
		});

		// Configure threshold for object temperature "greater than 100 °C" (unit is °C/10)
		tir.setObjectTemperatureCallbackThreshold('>', (short)(100*10), (short)0);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
