/*************************************************************
 * This file was automatically generated on 2011-08-23.      *
 *                                                           *
 * If you have a bugfix for this file and want to commit it, *
 * please fix the bug in the generator. You can find a link  *
 * to the generator git on tinkerforge.com                   *
 *************************************************************/

#include "bricklet_temperature_ir.h"

#include <string.h>

#define TYPE_GET_AMBIENT_TEMPERATURE 1
#define TYPE_GET_OBJECT_TEMPERATURE 2
#define TYPE_SET_EMISSIVITY 3
#define TYPE_GET_EMISSIVITY 4
#define TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD 5
#define TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD 6
#define TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD 7
#define TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD 8
#define TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD 9
#define TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD 10
#define TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD 11
#define TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD 12
#define TYPE_SET_DEBOUNCE_PERIOD 13
#define TYPE_GET_DEBOUNCE_PERIOD 14
#define TYPE_AMBIENT_TEMPERATURE 15
#define TYPE_OBJECT_TEMPERATURE 16
#define TYPE_AMBIENT_TEMPERATURE_REACHED 17
#define TYPE_OBJECT_TEMPERATURE_REACHED 18

typedef void (*ambient_temperature_func_t)(int16_t);
typedef void (*object_temperature_func_t)(int16_t);
typedef void (*ambient_temperature_reached_func_t)(int16_t);
typedef void (*object_temperature_reached_func_t)(int16_t);

#ifdef _MSC_VER
	#pragma pack(push)
	#pragma pack(1)

	#define PACKED
#else
	#define PACKED __attribute__((packed))
#endif

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAmbientTemperature;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED GetAmbientTemperatureReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetObjectTemperature;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED GetObjectTemperatureReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t emissivity;
} PACKED SetEmissivity;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetEmissivity;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint16_t emissivity;
} PACKED GetEmissivityReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED SetAmbientTemperatureCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAmbientTemperatureCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED GetAmbientTemperatureCallbackPeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED SetObjectTemperatureCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetObjectTemperatureCallbackPeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t period;
} PACKED GetObjectTemperatureCallbackPeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED SetAmbientTemperatureCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetAmbientTemperatureCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED GetAmbientTemperatureCallbackThresholdReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED SetObjectTemperatureCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetObjectTemperatureCallbackThreshold;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	char option;
	int16_t min;
	int16_t max;
} PACKED GetObjectTemperatureCallbackThresholdReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t debounce;
} PACKED SetDebouncePeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
} PACKED GetDebouncePeriod;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	uint32_t debounce;
} PACKED GetDebouncePeriodReturn;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED AmbientTemperatureCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED ObjectTemperatureCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED AmbientTemperatureReachedCallback;

typedef struct {
	uint8_t stack_id;
	uint8_t type;
	uint16_t length;
	int16_t temperature;
} PACKED ObjectTemperatureReachedCallback;

#ifdef _MSC_VER
	#pragma pack(pop)
#endif

int temperature_ir_get_ambient_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_AMBIENT_TEMPERATURE;
	temperature_ir->answer.length = sizeof(GetAmbientTemperatureReturn);
	GetAmbientTemperature gat;
	gat.stack_id = temperature_ir->stack_id;
	gat.type = TYPE_GET_AMBIENT_TEMPERATURE;
	gat.length = sizeof(GetAmbientTemperature);

	ipcon_device_write(temperature_ir, (char *)&gat, sizeof(GetAmbientTemperature));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetAmbientTemperatureReturn *gatr = (GetAmbientTemperatureReturn *)temperature_ir->answer.buffer;
	*ret_temperature = gatr->temperature;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_object_temperature(TemperatureIR *temperature_ir, int16_t *ret_temperature) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_OBJECT_TEMPERATURE;
	temperature_ir->answer.length = sizeof(GetObjectTemperatureReturn);
	GetObjectTemperature got;
	got.stack_id = temperature_ir->stack_id;
	got.type = TYPE_GET_OBJECT_TEMPERATURE;
	got.length = sizeof(GetObjectTemperature);

	ipcon_device_write(temperature_ir, (char *)&got, sizeof(GetObjectTemperature));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetObjectTemperatureReturn *gotr = (GetObjectTemperatureReturn *)temperature_ir->answer.buffer;
	*ret_temperature = gotr->temperature;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_emissivity(TemperatureIR *temperature_ir, uint16_t emissivity) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetEmissivity se;
	se.stack_id = temperature_ir->stack_id;
	se.type = TYPE_SET_EMISSIVITY;
	se.length = sizeof(SetEmissivity);
	se.emissivity = emissivity;

	ipcon_device_write(temperature_ir, (char *)&se, sizeof(SetEmissivity));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_emissivity(TemperatureIR *temperature_ir, uint16_t *ret_emissivity) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_EMISSIVITY;
	temperature_ir->answer.length = sizeof(GetEmissivityReturn);
	GetEmissivity ge;
	ge.stack_id = temperature_ir->stack_id;
	ge.type = TYPE_GET_EMISSIVITY;
	ge.length = sizeof(GetEmissivity);

	ipcon_device_write(temperature_ir, (char *)&ge, sizeof(GetEmissivity));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetEmissivityReturn *ger = (GetEmissivityReturn *)temperature_ir->answer.buffer;
	*ret_emissivity = ger->emissivity;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_ambient_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t period) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetAmbientTemperatureCallbackPeriod satcp;
	satcp.stack_id = temperature_ir->stack_id;
	satcp.type = TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD;
	satcp.length = sizeof(SetAmbientTemperatureCallbackPeriod);
	satcp.period = period;

	ipcon_device_write(temperature_ir, (char *)&satcp, sizeof(SetAmbientTemperatureCallbackPeriod));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_ambient_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t *ret_period) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD;
	temperature_ir->answer.length = sizeof(GetAmbientTemperatureCallbackPeriodReturn);
	GetAmbientTemperatureCallbackPeriod gatcp;
	gatcp.stack_id = temperature_ir->stack_id;
	gatcp.type = TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_PERIOD;
	gatcp.length = sizeof(GetAmbientTemperatureCallbackPeriod);

	ipcon_device_write(temperature_ir, (char *)&gatcp, sizeof(GetAmbientTemperatureCallbackPeriod));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetAmbientTemperatureCallbackPeriodReturn *gatcpr = (GetAmbientTemperatureCallbackPeriodReturn *)temperature_ir->answer.buffer;
	*ret_period = gatcpr->period;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_object_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t period) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetObjectTemperatureCallbackPeriod sotcp;
	sotcp.stack_id = temperature_ir->stack_id;
	sotcp.type = TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_PERIOD;
	sotcp.length = sizeof(SetObjectTemperatureCallbackPeriod);
	sotcp.period = period;

	ipcon_device_write(temperature_ir, (char *)&sotcp, sizeof(SetObjectTemperatureCallbackPeriod));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_object_temperature_callback_period(TemperatureIR *temperature_ir, uint32_t *ret_period) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD;
	temperature_ir->answer.length = sizeof(GetObjectTemperatureCallbackPeriodReturn);
	GetObjectTemperatureCallbackPeriod gotcp;
	gotcp.stack_id = temperature_ir->stack_id;
	gotcp.type = TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_PERIOD;
	gotcp.length = sizeof(GetObjectTemperatureCallbackPeriod);

	ipcon_device_write(temperature_ir, (char *)&gotcp, sizeof(GetObjectTemperatureCallbackPeriod));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetObjectTemperatureCallbackPeriodReturn *gotcpr = (GetObjectTemperatureCallbackPeriodReturn *)temperature_ir->answer.buffer;
	*ret_period = gotcpr->period;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_ambient_temperature_callback_threshold(TemperatureIR *temperature_ir, char option, int16_t min, int16_t max) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetAmbientTemperatureCallbackThreshold satct;
	satct.stack_id = temperature_ir->stack_id;
	satct.type = TYPE_SET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD;
	satct.length = sizeof(SetAmbientTemperatureCallbackThreshold);
	satct.option = option;
	satct.min = min;
	satct.max = max;

	ipcon_device_write(temperature_ir, (char *)&satct, sizeof(SetAmbientTemperatureCallbackThreshold));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_ambient_temperature_callback_threshold(TemperatureIR *temperature_ir, char *ret_option, int16_t *ret_min, int16_t *ret_max) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD;
	temperature_ir->answer.length = sizeof(GetAmbientTemperatureCallbackThresholdReturn);
	GetAmbientTemperatureCallbackThreshold gatct;
	gatct.stack_id = temperature_ir->stack_id;
	gatct.type = TYPE_GET_AMBIENT_TEMPERATURE_CALLBACK_THRESHOLD;
	gatct.length = sizeof(GetAmbientTemperatureCallbackThreshold);

	ipcon_device_write(temperature_ir, (char *)&gatct, sizeof(GetAmbientTemperatureCallbackThreshold));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetAmbientTemperatureCallbackThresholdReturn *gatctr = (GetAmbientTemperatureCallbackThresholdReturn *)temperature_ir->answer.buffer;
	*ret_option = gatctr->option;
	*ret_min = gatctr->min;
	*ret_max = gatctr->max;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_object_temperature_callback_threshold(TemperatureIR *temperature_ir, char option, int16_t min, int16_t max) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetObjectTemperatureCallbackThreshold sotct;
	sotct.stack_id = temperature_ir->stack_id;
	sotct.type = TYPE_SET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD;
	sotct.length = sizeof(SetObjectTemperatureCallbackThreshold);
	sotct.option = option;
	sotct.min = min;
	sotct.max = max;

	ipcon_device_write(temperature_ir, (char *)&sotct, sizeof(SetObjectTemperatureCallbackThreshold));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_object_temperature_callback_threshold(TemperatureIR *temperature_ir, char *ret_option, int16_t *ret_min, int16_t *ret_max) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD;
	temperature_ir->answer.length = sizeof(GetObjectTemperatureCallbackThresholdReturn);
	GetObjectTemperatureCallbackThreshold gotct;
	gotct.stack_id = temperature_ir->stack_id;
	gotct.type = TYPE_GET_OBJECT_TEMPERATURE_CALLBACK_THRESHOLD;
	gotct.length = sizeof(GetObjectTemperatureCallbackThreshold);

	ipcon_device_write(temperature_ir, (char *)&gotct, sizeof(GetObjectTemperatureCallbackThreshold));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetObjectTemperatureCallbackThresholdReturn *gotctr = (GetObjectTemperatureCallbackThresholdReturn *)temperature_ir->answer.buffer;
	*ret_option = gotctr->option;
	*ret_min = gotctr->min;
	*ret_max = gotctr->max;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_set_debounce_period(TemperatureIR *temperature_ir, uint32_t debounce) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	SetDebouncePeriod sdp;
	sdp.stack_id = temperature_ir->stack_id;
	sdp.type = TYPE_SET_DEBOUNCE_PERIOD;
	sdp.length = sizeof(SetDebouncePeriod);
	sdp.debounce = debounce;

	ipcon_device_write(temperature_ir, (char *)&sdp, sizeof(SetDebouncePeriod));

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_get_debounce_period(TemperatureIR *temperature_ir, uint32_t *ret_debounce) {
	if(temperature_ir->ipcon == NULL) {
		return E_NOT_ADDED;
	}

	ipcon_sem_wait_write(temperature_ir);

	temperature_ir->answer.type = TYPE_GET_DEBOUNCE_PERIOD;
	temperature_ir->answer.length = sizeof(GetDebouncePeriodReturn);
	GetDebouncePeriod gdp;
	gdp.stack_id = temperature_ir->stack_id;
	gdp.type = TYPE_GET_DEBOUNCE_PERIOD;
	gdp.length = sizeof(GetDebouncePeriod);

	ipcon_device_write(temperature_ir, (char *)&gdp, sizeof(GetDebouncePeriod));

	if(ipcon_answer_sem_wait_timeout(temperature_ir) != 0) {
		ipcon_sem_post_write(temperature_ir);
		return E_TIMEOUT;
	}

	GetDebouncePeriodReturn *gdpr = (GetDebouncePeriodReturn *)temperature_ir->answer.buffer;
	*ret_debounce = gdpr->debounce;

	ipcon_sem_post_write(temperature_ir);

	return E_OK;
}

int temperature_ir_callback_ambient_temperature(TemperatureIR *temperature_ir, const unsigned char *buffer) {
	AmbientTemperatureCallback *atc = (AmbientTemperatureCallback *)buffer;
	((ambient_temperature_func_t)temperature_ir->callbacks[atc->type])(atc->temperature);
	return sizeof(AmbientTemperatureCallback);
}

int temperature_ir_callback_object_temperature(TemperatureIR *temperature_ir, const unsigned char *buffer) {
	ObjectTemperatureCallback *otc = (ObjectTemperatureCallback *)buffer;
	((object_temperature_func_t)temperature_ir->callbacks[otc->type])(otc->temperature);
	return sizeof(ObjectTemperatureCallback);
}

int temperature_ir_callback_ambient_temperature_reached(TemperatureIR *temperature_ir, const unsigned char *buffer) {
	AmbientTemperatureReachedCallback *atrc = (AmbientTemperatureReachedCallback *)buffer;
	((ambient_temperature_reached_func_t)temperature_ir->callbacks[atrc->type])(atrc->temperature);
	return sizeof(AmbientTemperatureReachedCallback);
}

int temperature_ir_callback_object_temperature_reached(TemperatureIR *temperature_ir, const unsigned char *buffer) {
	ObjectTemperatureReachedCallback *otrc = (ObjectTemperatureReachedCallback *)buffer;
	((object_temperature_reached_func_t)temperature_ir->callbacks[otrc->type])(otrc->temperature);
	return sizeof(ObjectTemperatureReachedCallback);
}

void temperature_ir_register_callback(TemperatureIR *temperature_ir, uint8_t cb, void *func) {
    temperature_ir->callbacks[cb] = func;
}

void temperature_ir_create(TemperatureIR *temperature_ir, const char *uid) {
	ipcon_device_create(temperature_ir, uid);

	temperature_ir->device_callbacks[TYPE_AMBIENT_TEMPERATURE] = temperature_ir_callback_ambient_temperature;
	temperature_ir->device_callbacks[TYPE_OBJECT_TEMPERATURE] = temperature_ir_callback_object_temperature;
	temperature_ir->device_callbacks[TYPE_AMBIENT_TEMPERATURE_REACHED] = temperature_ir_callback_ambient_temperature_reached;
	temperature_ir->device_callbacks[TYPE_OBJECT_TEMPERATURE_REACHED] = temperature_ir_callback_object_temperature_reached;
}
