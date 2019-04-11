#include <Servo.h>

Servo servo1;
int pos = 0;
int i;
int min = 10;
int max = 170;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  servo1.attach(3);
}

void loop() {
  // put your main code here, to run repeatedly:
  if(pos<=min) i=1;
  if(pos>=max) i=-1;
  pos=pos+i;
  Serial.println(pos);
  delay(0);
  servo1.write(pos);
}
  
