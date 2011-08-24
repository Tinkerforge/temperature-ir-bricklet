/*************************************************************
 * This file was automatically generated on 23.08.2011.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

#ifndef BRICKLET_TEMPERATURE_IR_H
#define BRICKLET_TEMPERATURE_IR_H

#include "ip_connection.h"

typedef Device TemperatureIR;

#define TEMPERATURE_IR_CALLBACK_AMBIENT_TEMPERATURE 15
#define TEMPERATURE_IR_CALLBACK_OBJECT_TEMPERATURE 16
#define TEMPERATURE_IR_CALLBACK_AMBIENT_TEMPERATURE_REACHED 17
#define TEMPERATURE_IR_CALLBACK_OBJECT_TEMPERATURE_REACHED 18

void temperature_ir_create(TemperatureIR *temperature_ir, const char *uid);

int temperature_ir_get_ambient_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature);
int temperature_ir_get_object_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature);
int temperature_ir_set_emissivity(TemperatureIR *temperature_ir, uint16_t emissivity);
int temperature_ir_get_emissivity(TemperatureIR *temperature_ir, uint16_t *ret_emissivity);
int temperature_ir_set_ambient_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t period);
int temperature_ir_get_ambient_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t *ret_period);
int temperature_ir_set_object_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t period);
int temperature_ir_get_object_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t *ret_period);
int temperature_ir_set_ambient_temperature_callback_threshold(TemperatureIR *temperature_ir, char option, int16_t min, int16_t max);
int temperature_ir_get_ambient_temperature_callback_threshold(TemperatureIR *temperature_ir, char *ret_option, int16_t *ret_min, int16_t *ret_max);
int temperature_ir_set_object_temperature_callback_threshold(TemperatureIR *temperature_ir, char option, int16_t min, int16_t max);
int temperature_ir_get_object_temperature_callback_threshold(TemperatureIR *temperature_ir, char *ret_option, int16_t *ret_min, int16_t *ret_max);
int temperature_ir_set_debounce_period(TemperatureIR *temperature_ir, uint32_t debounce);
int temperature_ir_get_debounce_period(TemperatureIR *temperature_ir, uint32_t *ret_debounce);
int temperature_ir_ambient_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature);
int temperature_ir_object_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature);
int temperature_ir_ambient_temperature_reached(TemperatureIR *temperature_ir, int16_t *ret_temperature);
int temperature_ir_object_temperature_reached(TemperatureIR *temperature_ir, int16_t *ret_temperature);

void temperature_ir_register_callback(TemperatureIR *temperature_ir, uint8_t cb, void *func);

#endif