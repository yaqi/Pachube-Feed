import processing.serial.*;
import cc.arduino.*;

import eeml.*;

Arduino arduino;
float myValue;
float lastUpdate;

DataOut dOut;

void setup()
{
println(Arduino.list());
arduino = new Arduino(this, Arduino.list()[2], 9600);

dOut = new DataOut(this, "http://www.pachube.com/api/35440.xml", "MY APIKEY"); 

dOut.addData(0,"LED sensor");

}

void draw()
{
  myValue = arduino.analogRead(0);

      //println(myValue);
    if ((millis() - lastUpdate) > 12000){
        println(myValue);
        println("ready to PUT: ");
        dOut.update(0, myValue);
        int response = dOut.updatePachube();
        println(response);
        lastUpdate = millis();
    }   
}


