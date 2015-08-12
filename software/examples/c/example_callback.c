#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_temperature_ir.h"

#define HOST "localhost"
#define PORT 4223
#define UID "XYZ" // Change to your UID

// Callback function for ambient temperature callback (parameter has unit °C/10)
void cb_ambient_temperature(int16_t ambient_temperature, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Ambient Temperature: %f °C\n", ambient_temperature/10.0);
}

// Callback function for object temperature callback (parameter has unit °C/10)
void cb_object_temperature(int16_t object_temperature, void *user_data) {
	(void)user_data; // avoid unused parameter warning

	printf("Object Temperature: %f °C\n", object_temperature/10.0);
}

int main(void) {
	// Create IP connection
	IPConnection ipcon;
	ipcon_create(&ipcon);

	// Create device object
	TemperatureIR tir;
	temperature_ir_create(&tir, UID, &ipcon);

	// Connect to brickd
	if(ipcon_connect(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not connect\n");
		return 1;
	}
	// Don't use device before ipcon is connected

	// Set period for ambient temperature callback to 1s (1000ms)
	// Note: The ambient temperature callback is only called every second
	//       if the ambient temperature has changed since the last call!
	temperature_ir_set_ambient_temperature_callback_period(&tir, 1000);

	// Register ambient temperature callback to function cb_ambient_temperature
	temperature_ir_register_callback(&tir,
	                                 TEMPERATURE_IR_CALLBACK_AMBIENT_TEMPERATURE,
	                                 (void *)cb_ambient_temperature,
	                                 NULL);

	// Set period for object temperature callback to 1s (1000ms)
	// Note: The object temperature callback is only called every second
	//       if the object temperature has changed since the last call!
	temperature_ir_set_object_temperature_callback_period(&tir, 1000);

	// Register object temperature callback to function cb_object_temperature
	temperature_ir_register_callback(&tir,
	                                 TEMPERATURE_IR_CALLBACK_OBJECT_TEMPERATURE,
	                                 (void *)cb_object_temperature,
	                                 NULL);

	printf("Press key to exit\n");
	getchar();
	ipcon_destroy(&ipcon); // Calls ipcon_disconnect internally
	return 0;
}
