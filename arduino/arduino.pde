#define LED_N_SIDE 7
#define LED_P_SIDE 2
#define LED_ANALOG_0 0
#include <Firmata.h>
int sensorValue;

void setup()
{
    Firmata.setFirmwareVersion(0, 1);
    Firmata.begin(9600);
  
  pinMode(LED_ANALOG_0,INPUT);
  Serial.begin(9600);
}

void loop()
{
	unsigned int j;
	
	// Apply reverse voltage, charge up the pin and led capacitance
	pinMode(LED_N_SIDE,OUTPUT);
	pinMode(LED_P_SIDE,OUTPUT);
	digitalWrite(LED_N_SIDE,HIGH);
	digitalWrite(LED_P_SIDE,LOW);
	
	// Isolate the pin 2 end of the diode
	pinMode(LED_N_SIDE,INPUT);
	digitalWrite(LED_N_SIDE,LOW);  // turn off internal pull-up resistor
	
	// Count how long it takes the diode to bleed back down to a logic zero
	for ( j = 0; j < 30000; j++) {
                sensorValue = analogRead(0);//read the sensor value
                
                  Firmata.sendAnalog(0, sensorValue); 
                
		Serial.println(sensorValue);//print the sensor value
                if ( sensorValue == 0) break;
                 
	}

	digitalWrite(LED_P_SIDE,HIGH);
	digitalWrite(LED_N_SIDE,LOW);
	pinMode(LED_P_SIDE,OUTPUT);
	pinMode(LED_N_SIDE,OUTPUT);
	delayMicroseconds(1000);
	// we could turn it off, but we know that is about to happen at the loop() start
}
