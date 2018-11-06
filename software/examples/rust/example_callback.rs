use std::{error::Error, io, thread};
use tinkerforge::{ipconnection::IpConnection, temperature_ir_bricklet::*};

const HOST: &str = "127.0.0.1";
const PORT: u16 = 4223;
const UID: &str = "XYZ"; // Change XYZ to the UID of your Temperature IR Bricklet

fn main() -> Result<(), Box<dyn Error>> {
    let ipcon = IpConnection::new(); // Create IP connection
    let temperature_ir_bricklet = TemperatureIRBricklet::new(UID, &ipcon); // Create device object

    ipcon.connect(HOST, PORT).recv()??; // Connect to brickd
                                        // Don't use device before ipcon is connected

    //Create listener for object temperature events.
    let object_temperature_listener = temperature_ir_bricklet.get_object_temperature_receiver();
    // Spawn thread to handle received events. This thread ends when the temperature_ir_bricklet
    // is dropped, so there is no need for manual cleanup.
    thread::spawn(move || {
        for event in object_temperature_listener {
            println!("Object Temperature: {}{}", event as f32 / 10.0, " °C");
        }
    });

    // Set period for object temperature listener to 1s (1000ms)
    // Note: The object temperature callback is only called every second
    //       if the object temperature has changed since the last call!
    temperature_ir_bricklet.set_object_temperature_callback_period(1000);

    println!("Press enter to exit.");
    let mut _input = String::new();
    io::stdin().read_line(&mut _input)?;
    ipcon.disconnect();
    Ok(())
}
