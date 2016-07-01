import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletTemperatureIR;

public class ExampleCallback {
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

		// Add object temperature listener (parameter has unit °C/10)
		tir.addObjectTemperatureListener(new BrickletTemperatureIR.ObjectTemperatureListener() {
			public void objectTemperature(short temperature) {
				System.out.println("Object Temperature: " + temperature/10.0 + " °C");
			}
		});

		// Set period for object temperature callback to 1s (1000ms)
		// Note: The object temperature callback is only called every second
		//       if the object temperature has changed since the last call!
		tir.setObjectTemperatureCallbackPeriod(1000);

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
