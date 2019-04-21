#include <Servo.h>                // Incluye la libreria Servo
Servo servo1;                    // Crea el objeto servo1 con las caracteristicas de Servo

int der1=2;//El pin 2 a In1 del L298N
int der2=3;//El pin 3 a In2 del L298N
int izq1=4;//El pin 7 a In3 del L298N
int izq2=5;//El pin 4 a In4 del L298N
int derVel=6;  //El pin 5 a EnA del L298N
int izqVel=7;//El pin 6 aEnB del L298N

int velocidad=150;

int duracion, distancia;  // para Calcular distacia

void setup()  { 
  Serial.begin(9600);    // inicia el puerto serial para comunicacion con el Bluetooth
  pinMode(der1, OUTPUT); 
  pinMode(der2, OUTPUT);
  pinMode(izq1, OUTPUT); 
  pinMode(izq2, OUTPUT); 
  pinMode(derVel, OUTPUT);
  pinMode(izqVel, OUTPUT);
} 

void loop()  { 

  char estado;
  if(Serial.available()>0){        // lee el bluetooth y almacena en estado
    estado = Serial.read();
  }
  if(estado=='a'){           // Boton desplazar al Frente
    digitalWrite(der1,1);
    digitalWrite(der2,0);
    digitalWrite(izq1,1);
    digitalWrite(izq2,0);
  }
  if(estado=='b'){          // Boton IZQ 
    digitalWrite(der1,0);
    digitalWrite(der2,1);
    digitalWrite(izq1,1);
    digitalWrite(izq2,0); 
  }
  if(estado=='c'){         // Boton Parar
    digitalWrite(der1, 0);     
    digitalWrite(der2, 0); 
    digitalWrite(izq1, 0);    
    digitalWrite(izq2, 0); 
  }
  if(estado=='d'){          // Boton DER
    digitalWrite(der1,1);
    digitalWrite(der2,0);
    digitalWrite(izq1,0);
    digitalWrite(izq2,1); 
  }   

  if(estado=='e'){          // Boton Reversa
    digitalWrite(der1,0);
    digitalWrite(der2,1);
    digitalWrite(izq1,0);
    digitalWrite(izq2,1);    
  }
}
