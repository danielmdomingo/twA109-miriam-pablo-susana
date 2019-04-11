const int EchoPin = 3;
const int TriggerPin = 9;
const int LedPin = 13;

void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
  pinMode(TriggerPin, OUTPUT);
  pinMode(EchoPin, INPUT);

}

void loop() {
  // put your main code here, to run repeatedly:

  
    int cm = ping(TriggerPin, EchoPin);
  Serial.print("distancia: ");
  Serial.println(cm);
  delay(200);
}

int ping(int TriggerPin, int EchoPin){
  long duration, distanceCm;

  digitalWrite(TriggerPin, LOW);
  delayMicroseconds(4);
  digitalWrite(TriggerPin, HIGH);
  delayMicroseconds(10);
  digitalWrite(TriggerPin,LOW);

  duration = pulseIn(EchoPin, HIGH);

  distanceCm = duration * 10/292/2;
  if (distanceCm<5 || distanceCm>150) 
    return 0;
  else
    return distanceCm;
}
