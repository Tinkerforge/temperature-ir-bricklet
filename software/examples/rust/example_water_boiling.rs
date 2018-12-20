use std::{error::Error, io, thread};
use tinkerforge::{ip_connection::IpConnection, temperature_ir_bricklet::*};

const HOST: &str = "localhost";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Temperature IR Bricklet.

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection.
    let tir = TemperatureIrBricklet::new(UID, &ipcon); // Create device object.

    ipcon.connect((HOST, PORT)).recv()??; // Connect to brickd.
                                          // Don't use device before ipcon is connected.

    // Set emissivity to 0.98 (emissivity of water, 65535 * 0.98 = 64224.299)
    tir.set_emissivity(64224);

    // Get threshold receivers with a debounce time of 10 seconds (10000ms).
    tir.set_debounce_period(10000);

    let object_temperature_reached_receiver = tir.get_object_temperature_reached_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `tir` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for object_temperature_reached in object_temperature_reached_receiver {
            println!("Object Temperature: {} °C", object_temperature_reached as f32 / 10.0);
            println!("The water is boiling!");
        }
    });

    // Configure threshold for object temperature "greater than 100 °C".
    tir.set_object_temperature_callback_threshold('>', 100 * 10, 0);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
