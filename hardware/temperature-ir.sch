EESchema Schematic File Version 2  date Do 25 Aug 2011 13:41:15 CEST
LIBS:power
LIBS:device
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:special
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
LIBS:tinkerforge
EELAYER 25  0
EELAYER END
$Descr A4 11700 8267
encoding utf-8
Sheet 1 1
Title "Temperature IR Bricklet"
Date "25 aug 2011"
Rev "1.0"
Comp "Tinkerforge GmbH"
Comment1 "Licensed under CERN OHL v.1.1"
Comment2 "Copyright (©) 2011, B.Nordmeyer <bastian@tinkerforge.com>"
Comment3 ""
Comment4 ""
$EndDescr
Text Notes 550  7200 0    40   ~ 0
Copyright Tinkerforge GmbH 2011.\nThis documentation describes Open Hardware and is licensed under the\nCERN OHL v. 1.1.\nYou may redistribute and modify this documentation under the terms of the\nCERN OHL v.1.1. (http://ohwr.org/cernohl). This documentation is distributed\nWITHOUT ANY EXPRESS OR IMPLIED WARRANTY, INCLUDING OF\nMERCHANTABILITY, SATISFACTORY QUALITY AND FITNESS FOR A\nPARTICULAR PURPOSE. Please see the CERN OHL v.1.1 for applicable\nconditions\n
NoConn ~ 3500 3000
Wire Wire Line
	3750 3250 3750 3100
Wire Wire Line
	3750 3100 3500 3100
Wire Wire Line
	3500 3600 5450 3600
Wire Wire Line
	5450 3600 5450 2700
Wire Wire Line
	5450 2700 5300 2700
Wire Wire Line
	5300 2900 5550 2900
Wire Wire Line
	5550 2900 5550 3400
Wire Wire Line
	5550 3400 3500 3400
Connection ~ 4500 3600
Wire Wire Line
	4600 2800 4500 2800
Wire Wire Line
	4500 2800 4500 3600
Wire Wire Line
	4600 2600 4300 2600
Wire Wire Line
	4400 2700 4400 3300
Wire Wire Line
	4350 3700 3500 3700
Wire Wire Line
	3650 5100 3650 3500
Wire Wire Line
	6050 3400 5650 3400
Connection ~ 4100 3400
Wire Wire Line
	4100 3400 4100 3150
Connection ~ 4100 3600
Wire Wire Line
	5300 2600 5300 2500
Wire Wire Line
	7500 3000 7500 2800
Wire Wire Line
	4700 4800 4650 4800
Connection ~ 3650 4500
Wire Wire Line
	3650 4500 3450 4500
Wire Wire Line
	3450 4500 3450 4600
Connection ~ 6950 3400
Wire Wire Line
	6950 3200 6950 3500
Connection ~ 7500 3900
Wire Wire Line
	6950 3900 7500 3900
Wire Wire Line
	8100 3400 7900 3400
Wire Wire Line
	4650 5200 5100 5200
Connection ~ 3750 5000
Wire Wire Line
	3850 4900 3750 4900
Wire Wire Line
	3750 4900 3750 5300
Wire Wire Line
	3850 5200 3750 5200
Wire Wire Line
	3050 4150 3050 4050
Wire Wire Line
	3650 5100 3850 5100
Wire Wire Line
	3750 5000 3850 5000
Connection ~ 3750 5200
Wire Wire Line
	4650 5100 5100 5100
Wire Wire Line
	7500 4000 7500 3800
Wire Wire Line
	6950 3400 7100 3400
Wire Wire Line
	3450 5300 3450 5100
Wire Wire Line
	4650 4800 4650 4900
Wire Wire Line
	5100 4900 5100 4800
Connection ~ 4650 4800
Wire Wire Line
	3500 3300 4300 3300
Wire Wire Line
	3650 3500 3500 3500
Wire Wire Line
	4100 4600 4100 4550
Wire Wire Line
	4000 3300 4000 3150
Connection ~ 4000 3300
Wire Wire Line
	4100 4050 4100 3600
Wire Wire Line
	3500 3800 4350 3800
Wire Wire Line
	4300 3300 4300 2600
Wire Wire Line
	4600 3200 4600 2900
Wire Wire Line
	4400 2700 4600 2700
Wire Wire Line
	4400 3300 6050 3300
Wire Wire Line
	5300 2800 5650 2800
Wire Wire Line
	5650 2800 5650 3400
Wire Wire Line
	3500 3200 3550 3200
Wire Wire Line
	3550 3200 3550 2900
$Comp
L ANALOG_SWITCH U2
U 1 1 4DBAA5CA
P 4950 2750
F 0 "U2" H 4800 3000 60  0000 C CNN
F 1 "NC7WB66K8X" H 4950 2500 60  0000 C CNN
F 2 "VSSOP8" H 4950 2750 60  0001 C CNN
	1    4950 2750
	1    0    0    -1  
$EndComp
Text GLabel 4350 3800 2    60   Output ~ 0
SDA2
Text GLabel 4350 3700 2    60   Output ~ 0
SCL2
Text GLabel 4100 3150 1    60   Output ~ 0
SDA
Text GLabel 4000 3150 1    60   Output ~ 0
SCL
$Comp
L GND #PWR6
U 1 1 4D302F1F
P 4100 4600
F 0 "#PWR6" H 4100 4600 30  0001 C CNN
F 1 "GND" H 4100 4530 30  0001 C CNN
	1    4100 4600
	1    0    0    -1  
$EndComp
$Comp
L R R2
U 1 1 4D302F1D
P 4100 4300
F 0 "R2" V 4180 4300 50  0000 C CNN
F 1 "10k" V 4100 4300 50  0000 C CNN
F 2 "0603" H 4100 4300 60  0001 C CNN
	1    4100 4300
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR10
U 1 1 4CF78252
P 5300 2500
F 0 "#PWR10" H 5300 2600 30  0001 C CNN
F 1 "VCC" H 5300 2600 30  0000 C CNN
	1    5300 2500
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR7
U 1 1 4CF7824B
P 4600 3200
F 0 "#PWR7" H 4600 3200 30  0001 C CNN
F 1 "GND" H 4600 3130 30  0001 C CNN
	1    4600 3200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR9
U 1 1 4CF77E0E
P 5100 4900
F 0 "#PWR9" H 5100 4900 30  0001 C CNN
F 1 "GND" H 5100 4830 30  0001 C CNN
	1    5100 4900
	1    0    0    -1  
$EndComp
$Comp
L C C1
U 1 1 4CF77E04
P 4900 4800
F 0 "C1" V 4750 4800 50  0000 L CNN
F 1 "100nF" V 5050 4800 50  0000 L CNN
F 2 "0603" H 4900 4800 60  0001 C CNN
	1    4900 4800
	0    1    1    0   
$EndComp
$Comp
L GND #PWR2
U 1 1 4CF77DE9
P 3450 5300
F 0 "#PWR2" H 3450 5300 30  0001 C CNN
F 1 "GND" H 3450 5230 30  0001 C CNN
	1    3450 5300
	1    0    0    -1  
$EndComp
$Comp
L R R1
U 1 1 4CF77DE6
P 3450 4850
F 0 "R1" V 3530 4850 50  0000 C CNN
F 1 "DNP" V 3450 4850 50  0000 C CNN
F 2 "0603" H 3450 4850 60  0001 C CNN
	1    3450 4850
	1    0    0    -1  
$EndComp
$Comp
L DRILL U5
U 1 1 4C654438
P 10700 6700
F 0 "U5" H 10750 6750 60  0001 C CNN
F 1 "DRILL" H 10700 6700 60  0000 C CNN
F 2 "Drill" H 10700 6700 60  0001 C CNN
	1    10700 6700
	1    0    0    -1  
$EndComp
$Comp
L DRILL U4
U 1 1 4C654436
P 10700 6500
F 0 "U4" H 10750 6550 60  0001 C CNN
F 1 "DRILL" H 10700 6500 60  0000 C CNN
F 2 "Drill" H 10700 6500 60  0001 C CNN
	1    10700 6500
	1    0    0    -1  
$EndComp
$Comp
L DRILL U7
U 1 1 4C654434
P 11000 6700
F 0 "U7" H 11050 6750 60  0001 C CNN
F 1 "DRILL" H 11000 6700 60  0000 C CNN
F 2 "Drill" H 11000 6700 60  0001 C CNN
	1    11000 6700
	1    0    0    -1  
$EndComp
$Comp
L DRILL U6
U 1 1 4C65442E
P 11000 6500
F 0 "U6" H 11050 6550 60  0001 C CNN
F 1 "DRILL" H 11000 6500 60  0000 C CNN
F 2 "Drill" H 11000 6500 60  0001 C CNN
	1    11000 6500
	1    0    0    -1  
$EndComp
NoConn ~ 3500 3900
$Comp
L VCC #PWR11
U 1 1 4C6540C6
P 6950 3200
F 0 "#PWR11" H 6950 3300 30  0001 C CNN
F 1 "VCC" H 6950 3300 30  0000 C CNN
	1    6950 3200
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR12
U 1 1 4C6540BA
P 7500 4000
F 0 "#PWR12" H 7500 4000 30  0001 C CNN
F 1 "GND" H 7500 3930 30  0001 C CNN
	1    7500 4000
	1    0    0    -1  
$EndComp
Text GLabel 7500 2800 1    60   Input ~ 0
SDA2
Text GLabel 8100 3400 2    60   Input ~ 0
SCL2
$Comp
L C C2
U 1 1 4C653F82
P 6950 3700
F 0 "C2" H 7000 3800 50  0000 L CNN
F 1 "100nF" H 7000 3600 50  0000 L CNN
F 2 "0603" H 6950 3700 60  0001 C CNN
	1    6950 3700
	1    0    0    -1  
$EndComp
$Comp
L MLX90614 U3
U 1 1 4C653F6C
P 7500 3400
F 0 "U3" H 7300 3650 60  0000 C CNN
F 1 "MLX90614" H 7800 3100 60  0000 C CNN
F 2 "TO-39" H 7500 3400 60  0001 C CNN
	1    7500 3400
	1    0    0    -1  
$EndComp
Text GLabel 5100 5200 2    60   Input ~ 0
SDA
Text GLabel 5100 5100 2    60   Input ~ 0
SCL
Text GLabel 6050 3400 2    60   Output ~ 0
SDA2
Text GLabel 6050 3300 2    60   Output ~ 0
SCL2
$Comp
L VCC #PWR8
U 1 1 4C5FD35E
P 4650 4800
F 0 "#PWR8" H 4650 4900 30  0001 C CNN
F 1 "VCC" H 4650 4900 30  0000 C CNN
	1    4650 4800
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR5
U 1 1 4C5FD34E
P 3750 5300
F 0 "#PWR5" H 3750 5300 30  0001 C CNN
F 1 "GND" H 3750 5230 30  0001 C CNN
	1    3750 5300
	1    0    0    -1  
$EndComp
$Comp
L CAT24C U1
U 1 1 4C5FD337
P 4250 5300
F 0 "U1" H 4100 5800 60  0000 C CNN
F 1 "M24C64" H 4250 5300 60  0000 C CNN
F 2 "TSSOP8" H 4250 5300 60  0001 C CNN
	1    4250 5300
	1    0    0    -1  
$EndComp
$Comp
L VCC #PWR3
U 1 1 4C5FCFB4
P 3550 2900
F 0 "#PWR3" H 3550 3000 30  0001 C CNN
F 1 "VCC" H 3550 3000 30  0000 C CNN
	1    3550 2900
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR4
U 1 1 4C5FCF5E
P 3750 3250
F 0 "#PWR4" H 3750 3250 30  0001 C CNN
F 1 "GND" H 3750 3180 30  0001 C CNN
	1    3750 3250
	1    0    0    -1  
$EndComp
$Comp
L GND #PWR1
U 1 1 4C5FCF4F
P 3050 4150
F 0 "#PWR1" H 3050 4150 30  0001 C CNN
F 1 "GND" H 3050 4080 30  0001 C CNN
	1    3050 4150
	1    0    0    -1  
$EndComp
$Comp
L CON-SENSOR P1
U 1 1 4C5FCF27
P 3050 3450
F 0 "P1" H 2800 4000 60  0000 C CNN
F 1 "CON-SENSOR" V 3200 3450 60  0000 C CNN
F 2 "CON-SENSOR" H 3050 3450 60  0001 C CNN
	1    3050 3450
	-1   0    0    -1  
$EndComp
$EndSCHEMATC
