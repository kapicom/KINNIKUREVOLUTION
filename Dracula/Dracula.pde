import processing.serial.*;
import processing.video.*;

Serial myPort;
Movie myMovie,myEffects,clearMovie,endMovie;
PImage startimg,clearimg;
int in0=200;
int in1=200;

int tm0=0;
int tm;
int count;

boolean play=false;
boolean play2=false;
boolean play3=false;

void setup(){
  size(960,960);
  String portName=Serial.list()[2];
  myPort=new Serial(this,portName,9600);
  myMovie = new Movie(this, "start.mp4");
  myEffects = new Movie(this, "dame.mp4");
  endMovie = new Movie(this, "clear.mp4");
  clearMovie = new Movie(this, "end.mp4");
  startimg= loadImage("home.png");
}

void draw(){
  image(startimg,0,0,width,height);
  //background(128);
  textSize(50);
  //text(in0,10,35);
  //text(in1,20,50);
  if(in0<210){
    if(!play){
      tm0=millis();
    }
    play=true;
  }
  if(play&&in1<190){
    play2=true;
  }
  if(play&&!play2){
   image(myMovie,0,0,width,height);
    myMovie.loop();
    tm=millis()-tm0;
  }else if(play&&play2){
    image(myEffects,0,0,width,height);
    myEffects.loop();
    play2=false;
  }
   if(tm>60*1000){
    image(endMovie,0,0,width,height);
    endMovie.play();
  } 
    
  if(in1<190&&!play3){
    play3=true;
    count++;
  }
  if(in1>=220){
    play3=false;
  }
  
  if(count>10){
    image(clearMovie,0,0,width,height);
    clearMovie.play();
  }  
  textSize(100);
  text(count,10,200);
  textSize(50);
  text(in1,20,50);
}

void serialEvent(Serial p){
  //serial data get
  if(myPort.available()>1){
    in0=myPort.read();
    in1=myPort.read();
    myPort.write(255);
  }
}

void movieEvent(Movie m) {
      m.read();
}

void mousePressed(){
  myPort.clear();
  myPort.write(255);
}
