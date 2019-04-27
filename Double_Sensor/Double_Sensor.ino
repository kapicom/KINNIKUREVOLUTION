int in0;
int in1;
void setup() {
  // put your setup code here, to run once:
  Serial.begin(9600);
}

void loop() {
  // put your main code here, to run repeatedly:
   in0=analogRead(0);
   in1=analogRead(1);
 int  out0=map(in0,0,1023,0,255);
 int  out1=map(in1,0,1023,0,255);

   if(Serial.available()>0){
      Serial.write(out0);
      Serial.write(out1);
      delay(100);
      Serial.read();
    }
}
