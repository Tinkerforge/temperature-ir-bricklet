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

    let object_temperature_receiver = tir.get_object_temperature_callback_receiver();

    // Spawn thread to handle received callback messages.
    // This thread ends when the `tir` object
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for object_temperature in object_temperature_receiver {
            println!("Object Temperature: {} °C", object_temperature as f32 / 10.0);
        }
    });

    // Set period for object temperature receiver to 1s (1000ms).
    // Note: The object temperature callback is only called every second
    //       if the object temperature has changed since the last call!
    tir.set_object_temperature_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
