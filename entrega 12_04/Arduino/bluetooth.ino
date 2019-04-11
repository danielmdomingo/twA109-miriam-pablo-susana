#include <SoftwareSerial.h>
SoftwareSerial BT(6,7);    // Definimos los pines RX y TX del Arduino conectados al Bluetooth (RX,TX)
 
void setup()
{
  BT.begin(9600);       // Inicializamos el puerto serie BT que hemos creado
  Serial.begin(9600);   // Inicializamos  el puerto serie  
}
 
void loop()
{
  if(BT.available())    // Se activa si llega un caracter al bluetooth
  {
    Serial.write(BT.read());
  }
 
  /*if(Serial.available())  // Se activa si llega se manda un dato desde el PC
  {
     BT.write(Serial.read());
  }*/
}
