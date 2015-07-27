import com.tinkerforge.IPConnection;
import com.tinkerforge.BrickletTemperatureIR;

public class ExampleCallback {
	private static final String HOST = "localhost";
	private static final int PORT = 4223;
	private static final String UID = "XYZ"; // Change to your UID

	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the documentation
	public static void main(String args[]) throws Exception {
		IPConnection ipcon = new IPConnection(); // Create IP connection
		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID, ipcon); // Create device object

		ipcon.connect(HOST, PORT); // Connect to brickd
		// Don't use device before ipcon is connected

		// Set period for ambient temperature callback to 1s (1000ms)
		// Note: The ambient temperature callback is only called every second
		//       if the ambient temperature has changed since the last call!
		tir.setAmbientTemperatureCallbackPeriod(1000);

		// Add ambient temperature listener (parameter has unit °C/10)
		tir.addAmbientTemperatureListener(new BrickletTemperatureIR.AmbientTemperatureListener() {
			public void ambientTemperature(short ambientTemperature) {
				System.out.println("Ambient Temperature: " + ambientTemperature/10.0 + " °C");
			}
		});

		// Set period for object temperature callback to 1s (1000ms)
		// Note: The object temperature callback is only called every second
		//       if the object temperature has changed since the last call!
		tir.setObjectTemperatureCallbackPeriod(1000);

		// Add object temperature listener (parameter has unit °C/10)
		tir.addObjectTemperatureListener(new BrickletTemperatureIR.ObjectTemperatureListener() {
			public void objectTemperature(short objectTemperature) {
				System.out.println("Object Temperature: " + objectTemperature/10.0 + " °C");
			}
		});

		System.out.println("Press key to exit"); System.in.read();
		ipcon.disconnect();
	}
}
