
#include <stdio.h>

#include "ip_connection.h"
#include "bricklet_temperature_ir.h"

#define HOST "localhost"
#define PORT 4223
#define UID "abcde" // Change to your UID

int main() {
	// Create IP connection to brickd
	IPConnection ipcon;
	if(ipcon_create(&ipcon, HOST, PORT) < 0) {
		fprintf(stderr, "Could not create connection\n");
		exit(1);
	}

	// Create device object
	TemperatureIR tir;
	temperature_ir_create(&tir, UID); 

	// Add device to IP connection
	if(ipcon_add_device(&ipcon, &tir) < 0) {
		fprintf(stderr, "Could not connect to Brick\n");
		exit(1);
	}
	// Don't use device before it is added to a connection

	// Get current ambient and object temperatures (unit is °C/10)
	uint16_t obj;
	uint16_t amb;
	temperature_ir_get_object_temperature(&tir, &obj);
	temperature_ir_get_ambient_temperature(&tir, &amb);

	printf("Object Temperature: %f °C\n", obj/10.0);
	printf("Ambient Temperature: %f °C\n", amb/10.0);

	printf("Press ctrl+c to close\n");
	ipcon_join_thread(&ipcon); // Join mainloop of IP connection
}
