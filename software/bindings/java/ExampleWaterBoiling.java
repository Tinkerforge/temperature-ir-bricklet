import com.tinkerforge.BrickletTemperatureIR;
import com.tinkerforge.IPConnection;

public class ExampleWaterBoiling {
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
		

		// Set emissivity to 0.98 (emissivity of water)
		tir.setEmissivity((int)(0xFFFF*0.98));

		// Get threshold callbacks with a debounce time of 10 seconds (10000ms)
		tir.setDebouncePeriod(10000);

		// Configure threshold for "object temperature greater than 100 °C" (unit is °C/10)
		tir.setObjectTemperatureCallbackThreshold('>', (short)(100*10), (short)0);

		// Add and implement temperature reached listener 
		// (called if object temperature is greater than 100 °C)
		tir.addListener(new BrickletTemperatureIR.ObjectTemperatureReachedListener() {
			public void objectTemperatureReached(short temperature) {
				System.out.println("The surface has a temperature of " + 
				                   temperature/10.0 + " °C.");
				System.out.println("The water is boiling!");
			}
		});
		
		System.out.println("Press ctrl+c to exit");
		ipcon.joinThread();
	}
}
