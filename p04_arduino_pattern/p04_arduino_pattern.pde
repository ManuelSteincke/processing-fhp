//This sketch creates different patterns 
//It's controlled by an Arduino
//You will find building instructions in the file folder

//AllInputsFirmata
//unter Werkzeuge/Tools Arduino auswählen
 
 import processing.serial.*;
 import cc.arduino.*;
 Arduino meinArduino;
 
 import peasy.*;
 PeasyCam cam;

 int potPin = 0;
 int potPin2 = 1;
 int value;
 int value2;

void setup() {
  fullScreen(P3D);
  cam = new PeasyCam(this, 3000);
  meinArduino = new Arduino(this, Arduino.list()[3], 57600);
}

void draw() {

 //translate(width/2, height/2);

   value = meinArduino.analogRead(potPin);
   value2=meinArduino.analogRead(potPin2);

  println(value);

  float d = dist(width/2, height/2, value, value2);
  float maxDist = dist(0, 0, width/2, height/2);
  float Farbe = map(d, 0, maxDist, 0, 255);
  float Farbe2 = map(d, 0, maxDist, 255, 0);

  background(0);
  
  float RotierenX = map(value, 0, width, 0, 0.01);
  float RotierenY = map(value2, 0, height, 0, 0.01);

  for (int x = 0; x <= width; x = x + 19) {
    for (int y = 0; y <= height; y = y + 19) {

      if ((y + x) % 2 == 0) {
        stroke(Farbe);
      } else {
        stroke(Farbe2);
      }
   
   rotateX(RotierenX);
   rotateY(RotierenY);
      
   if (keyPressed) {
      if (key == '1') {
        //Linien von oben links nach unten rechts
        line(x+15, y, x+15, y);
        line(x, y+15, x, y+15);
        line(x, y+9, x+6, y+15);
        line(x, y+3, x+12, y+15);
        line(x+3, y, x+15, y+12);
        line(x+9, y, x+15, y+6);
      } else if (key == '2') {
          //Vertikale Linien
          line(x, y, x, y+15);
          line(x+3, y, x+3, y+15);
          line(x+6, y, x+6, y+15);
          line(x+9, y, x+9, y+15);
          line(x+12, y, x+12, y+15);
          line(x+15, y, x+15, y+15);
      } else if (key == '3') {
          //Horizontale Linien
          line(x, y, x+15, y);
          line(x, y+3, x+15, y+3);
          line(x, y+6, x+15, y+6);
          line(x, y+9, x+15, y+9);
          line(x, y+12, x+15, y+12);
          line(x, y+15, x+15, y+15);
      } else if (key == '4') {
          //Linien von oben rechts nach unten links
          line(x, y, x, y);
          line(x+15, y+15, x+15, y+15);
          line(x+6, y, x, y+6);
          line(x+12, y, x, y+12);
          line(x+15, y+3, x+3, y+15);
          line(x+15, y+9, x+9, y+15);
        }
      }
    }
  }
}