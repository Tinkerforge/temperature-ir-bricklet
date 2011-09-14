import com.tinkerforge.BrickletTemperatureIR;
import com.tinkerforge.IPConnection;

public class ExampleCallback {
	private static final String host = new String("localhost");
	private static final int port = 4223;
	private static final String UID = new String("ABC"); // Change to your UID
	
	// Note: To make the example code cleaner we do not handle exceptions. Exceptions you
	//       might normally want to catch are described in the commnents below
	public static void main(String args[]) throws Exception {
		// Create connection to brickd
		IPConnection ipcon = new IPConnection(host, port); // Can throw IOException

		BrickletTemperatureIR tir = new BrickletTemperatureIR(UID); // Create device object

		// Add device to ip connection
		ipcon.addDevice(tir); // Can throw IPConnection.TimeoutException
		// Don't use device before it is added to a connection
		

		// Set Period for temperature callbacks to 1s (1000ms)
		// Note: The temperature callbacks are only called every second if the 
		//       temperature has changed since the last call!
		tir.setObjectTemperatureCallbackPeriod(1000);
		tir.setAmbientTemperatureCallbackPeriod(1000);

		// Add and implement object/ambient temperature listener 
		// (called if temperature changes)
		tir.addListener(new BrickletTemperatureIR.ObjectTemperatureListener() {
			public void objectTemperature(short temperature) {
				System.out.println("Object Temperature: " + temperature/10.0 + " °C");
			}
		});
		tir.addListener(new BrickletTemperatureIR.AmbientTemperatureListener() {
			public void ambientTemperature(short temperature) {
				System.out.println("Ambient Temperature: " + temperature/10.0 + " °C");
			}
		});
		
		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}
