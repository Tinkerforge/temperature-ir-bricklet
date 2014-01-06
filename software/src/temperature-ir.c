/* temperature-ir-bricklet
 * Copyright (C) 2010-2012 Olaf Lüke <olaf@tinkerforge.com>
 *
 * temperature-ir.c: Implementation of Temperature-IR Bricklet messages
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the
 * Free Software Foundation, Inc., 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

#include "temperature-ir.h"

#include "brickletlib/bricklet_entry.h"
#include "brickletlib/bricklet_simple.h"
#include "bricklib/bricklet/bricklet_communication.h"
#include "bricklib/utility/init.h"
#include "config.h"

#define SIMPLE_UNIT_AMBIENT_TEMPERATURE 0
#define SIMPLE_UNIT_OBJECT_TEMPERATURE 1

const SimpleMessageProperty smp[] = {
	{SIMPLE_UNIT_AMBIENT_TEMPERATURE, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_AMBIENT_TEMPERATURE
	{SIMPLE_UNIT_OBJECT_TEMPERATURE, SIMPLE_TRANSFER_VALUE, SIMPLE_DIRECTION_GET}, // TYPE_GET_OBJECT_TEMPERATURE
	{0, 0, 0}, // TYPE_SET_EMISSIVITY
	{0, 0, 0}, // TYPE_GET_EMISSIVITY
	{SIMPLE_UNIT_AMBIENT_TEMPERATURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_AMBIENT_TEMPERATURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_OBJECT_TEMPERATURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_SET}, // TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_OBJECT_TEMPERATURE, SIMPLE_TRANSFER_PERIOD, SIMPLE_DIRECTION_GET}, // TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD
	{SIMPLE_UNIT_AMBIENT_TEMPERATURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_AMBIENT_TEMPERATURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_OBJECT_TEMPERATURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_SET}, // TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD
	{SIMPLE_UNIT_OBJECT_TEMPERATURE, SIMPLE_TRANSFER_THRESHOLD, SIMPLE_DIRECTION_GET}, // TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_SET}, // TYPE_SET_DEBOUNCE_PERIOD
	{0, SIMPLE_TRANSFER_DEBOUNCE, SIMPLE_DIRECTION_GET}, // TYPE_GET_DEBOUNCE_PERIOD
};

const SimpleUnitProperty sup[] = {
	{0, SIMPLE_SIGNEDNESS_INT, FID_AMBIENT_TEMPERATURE, FID_AMBIENT_TEMPERATURE_REACHED, SIMPLE_UNIT_AMBIENT_TEMPERATURE}, // ambient temperature
	{0, SIMPLE_SIGNEDNESS_INT, FID_OBJECT_TEMPERATURE, FID_OBJECT_TEMPERATURE_REACHED, SIMPLE_UNIT_OBJECT_TEMPERATURE} // object temperature
};

const uint8_t smp_length = sizeof(smp);

void invocation(const ComType com, const uint8_t *data) {
	switch(((MessageHeader*)data)->fid) {
		case FID_SET_EMISSIVITY:
			set_emissivity(com, (SetEmissivity*)data);
			return;
		case FID_GET_EMISSIVITY:
			get_emissivity(com, (GetEmissivity*)data);
			return;
	}

	simple_invocation(com, data);

	if(((MessageHeader*)data)->fid > FID_LAST) {
		BA->com_return_error(data, sizeof(MessageHeader), MESSAGE_ERROR_CODE_NOT_SUPPORTED, com);
	}
}

void constructor(void) {
	_Static_assert(sizeof(BrickContext) <= BRICKLET_CONTEXT_MAX_SIZE, "BrickContext too big");

	BC->value_tick = 0;
	BC->emissivity_counter = 0;
	BC->startup_counter = 255; // MLX90614 needs 20ms for startup
	BC->next_address = I2C_INTERNAL_ADDRESS_TA;

	PIN_SCL.type = PIO_INPUT;
	PIN_SCL.attribute = PIO_DEFAULT;
    BA->PIO_Configure(&PIN_SCL, 1);

	PIN_SDA_PWM.type = PIO_INPUT;
	PIN_SCL.attribute = PIO_DEFAULT;
    BA->PIO_Configure(&PIN_SDA_PWM, 1);

	simple_constructor();
}

void destructor(void) {
	PIN_SCL.type = PIO_INPUT;
	PIN_SCL.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_SCL, 1);

	PIN_SDA_PWM.type = PIO_INPUT;
	PIN_SCL.attribute = PIO_PULLUP;
    BA->PIO_Configure(&PIN_SDA_PWM, 1);

	simple_destructor();
}

void tick(const uint8_t tick_type) {
	if(tick_type & TICK_TASK_TYPE_CALCULATION) {
		// Wait 20 ms for MLX90614 to start up
		if(BC->startup_counter > 0) {
			BC->startup_counter--;
			if(BC->startup_counter == 0) {
				// Get start emissivity
				ir_temp_get_emissivity_correction();
			}

			return;
		}
		if(BC->emissivity_counter > 0) {
			BC->emissivity_counter--;
			if(BC->emissivity_counter == 0) {
				if(BC->emissivity_state == IR_TEMP_SET_EMISSIVITY_START) {
					ir_temp_set_emissivity_correction(BC->emissivity.data,
													  IR_TEMP_SET_EMISSIVITY_END);
				}
			}

			return;
		}

		// Updating the temperatures consecutively every 125ms is often enough
		BC->value_tick++;
		if((BC->value_tick % 125) == 0) {
			if(!ir_temp_next_value()) {
				BC->value_tick--;
			}
		}
	}

    simple_tick(tick_type);
}

void set_emissivity(const ComType com, const SetEmissivity *data) {
	ir_temp_set_emissivity_correction(data->emissivity,
	                                  IR_TEMP_SET_EMISSIVITY_START);

	BA->com_return_setter(com, data);
}

void get_emissivity(const ComType com, const GetEmissivity *data) {
	GetEmissivityReturn ger;

	ger.header        = data->header;
	ger.header.length = sizeof(GetEmissivityReturn);
	ger.emissivity    = BC->emissivity.data;

	BA->send_blocking_with_timeout(&ger,
	                               sizeof(GetEmissivityReturn),
	                               com);
}

void ir_temp_callback_value(void) {
	// Switch back to 400khz, turn off MPX90614 i2c and give back mutex
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (76 << 8) | 76;

	PIN_I2C_SWITCH.type = PIO_OUTPUT_0;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	int32_t higher_prio_task_woken = 0;
	BA->mutex_give_isr(*BA->mutex_twi_bricklet, &higher_prio_task_woken);

	if(BC->next_address == I2C_INTERNAL_ADDRESS_TA) {
		BC->value[0] = ir_temp_to_celsius(BC->temperature.data);
		BC->next_address = I2C_INTERNAL_ADDRESS_TOBJ1;
	} else {
		BC->value[1] = ir_temp_to_celsius(BC->temperature.data);
		BC->next_address = I2C_INTERNAL_ADDRESS_TA;
	}

	BA->yield_from_isr(higher_prio_task_woken);
}

void ir_temp_callback_set_emissivity(void) {
	// Switch back to 400khz, turn off MPX90614 i2c and give back mutex
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (76 << 8) | 76;

	PIN_I2C_SWITCH.type = PIO_OUTPUT_0;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	BA->mutex_give(*BA->mutex_twi_bricklet);
	if(BC->emissivity_state == IR_TEMP_SET_EMISSIVITY_START) {
		BC->emissivity_counter = 255;
	} else if(BC->emissivity_state == IR_TEMP_SET_EMISSIVITY_END) {
		BC->emissivity_counter = 255;
		BC->emissivity_state = IR_TEMP_SET_EMISSIVITY_NONE;
	}
}

void ir_temp_callback_get_emissivity(void) {
	// Switch back to 400khz, turn off MPX90614 i2c and give back mutex
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (76 << 8) | 76;

	PIN_I2C_SWITCH.type = PIO_OUTPUT_0;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	BA->mutex_give(*BA->mutex_twi_bricklet);
}

void ir_temp_set_emissivity_correction(const uint16_t value, const uint8_t part) {
	uint16_t write_value = value;
	// Check minimum value
	if(write_value < 0xFFFF/10) {
		write_value = 0xFFFF/10;
	}

	// Mutex is given in callback
	BA->mutex_take(*BA->mutex_twi_bricklet, MUTEX_BLOCKING);

	// Switch to 100khz
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (1 << 16) | (158<< 8) | 158;

	BC->async.callback = ir_temp_callback_set_emissivity;
	if(part == IR_TEMP_SET_EMISSIVITY_START) {
		BC->data[0] = I2C_ADDRESS << 1;
		BC->data[1] = I2C_INTERNAL_ADDRESS_EMISSIVITY;
		BC->data[2] = 0;
		BC->data[3] = 0;
		BC->data[4] = ir_temp_calculate_pec(BC->data, 4);
		BC->emissivity.data = write_value;
		BC->emissivity_state = IR_TEMP_SET_EMISSIVITY_START;
	} else if(part == IR_TEMP_SET_EMISSIVITY_END) {
		BC->data[0] = I2C_ADDRESS << 1;
		BC->data[1] = I2C_INTERNAL_ADDRESS_EMISSIVITY;
		*((uint16_t*)(&BC->data[2])) = write_value;
		BC->data[4] = ir_temp_calculate_pec(BC->data, 4);
		BC->emissivity_state = IR_TEMP_SET_EMISSIVITY_END;
	}

	// Turn on switch to allow i2c (turned off again in callback)
	PIN_I2C_SWITCH.type = PIO_OUTPUT_1;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	BA->TWID_Write(BA->twid,
				   I2C_ADDRESS,
				   I2C_INTERNAL_ADDRESS_EMISSIVITY,
				   I2C_INTERNAL_ADDRESS_BYTES,
				   &BC->data[2],
				   I2C_DATA_LENGTH,
				   &BC->async);
}

void ir_temp_get_emissivity_correction(void) {
	// Mutex is given in callback
	if(!BA->mutex_take(*BA->mutex_twi_bricklet, 0)) {
		return;
	}

	// Switch to 100khz
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (1 << 16) | (158<< 8) | 158;

	// Turn on switch to allow i2c (turned off again in callback)
	PIN_I2C_SWITCH.type = PIO_OUTPUT_1;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	BC->async.callback = ir_temp_callback_get_emissivity;
    BA->TWID_Read(BA->twid,
                  I2C_ADDRESS,
                  I2C_INTERNAL_ADDRESS_EMISSIVITY,
                  I2C_INTERNAL_ADDRESS_BYTES,
                  (uint8_t *)&BC->emissivity,
                  I2C_DATA_LENGTH,
                  &BC->async);
}

uint8_t ir_temp_calculate_pec(const uint8_t *data, const uint8_t length) {
	uint16_t crc = 0;
	for(uint8_t i = 0; i < length; i++) {
		crc = ((crc >> 8) ^ data[i]) << 8;
		for(uint8_t j = 0; j < 8; j++) {
			if((crc & 0x8000) != 0) {
				crc = crc ^ IR_TEMP_CRC_POLYNOM;
			}
			crc = crc << 1;
		}
	}

	return crc >> 8;
}

bool ir_temp_next_value(void) {
	// Mutex is given in callback
	if(!BA->mutex_take(*BA->mutex_twi_bricklet, 0)) {
		return false;
	}

	// Switch to 100khz
	BA->twid->pTwi->TWI_CWGR = 0;
	BA->twid->pTwi->TWI_CWGR = (1 << 16) | (158<< 8) | 158;

	// Turn on switch to allow i2c (turned off again in callback)
	PIN_I2C_SWITCH.type = PIO_OUTPUT_1;
	BA->PIO_Configure(&PIN_I2C_SWITCH, 1);

	BC->async.callback = ir_temp_callback_value;
    BA->TWID_Read(BA->twid,
                  I2C_ADDRESS,
                  BC->next_address,
                  I2C_INTERNAL_ADDRESS_BYTES,
                  (uint8_t *)&BC->temperature,
                  I2C_DATA_LENGTH,
                  &BC->async);

    return true;
}

// Calculate 10th degree celsius
int16_t ir_temp_to_celsius(const int16_t temp) {
	return temp/5 - 2731;
}
