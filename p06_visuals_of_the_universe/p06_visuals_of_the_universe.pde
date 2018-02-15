//This sketch creates visuals according to the amplitude
//Silence is the key

int a;
int z;
float t;
float Farbe1 = random(0,255);
float Farbe2 = random(0,255);
float Farbe3 = random(0,255);
float speed = random(0.6-0.9);
float amplitude;

import processing.sound.*;
Amplitude amp;
AudioIn in;
SoundFile file;

static final int NUM_LINES = 100;

void setup(){
    //file = new SoundFile(this, "sound/music.mp3");
    //file.play();
    //file.amp(1);
    amp = new Amplitude(this);
    in = new AudioIn(this, 0);
    in.start();
    amp.input(in);

  fullScreen(P3D);
  background(0);
}

void draw(){
  //background(0);
  amplitude = amp.analyze();
  println(amplitude*2000);
  frameRate(200);
  strokeWeight(3);
  translate(width / 2, height / 2);
  
  //noStroke();
  //fill(0);
  //for (int c = 200; c > 190; c--) {
  //ellipse(0,0,1200,1200);
  
  //rotateX(radians(t));
  //rotateY(radians(t));

  for(int i = 0; i < NUM_LINES; i++){
      stroke(255,amplitude * 10000, random(0,100));
    strokeWeight(1);
    point(x1(t + i), x2(t + i),(x1(t + i)));
      rotate(8);
      stroke(amplitude * 10000, random(0,255), 255);
      strokeWeight(1);
     //0.5 wie schwarz das bild wird
      if (amplitude*2000 > 0.5) {
        point(y1(t + i), y2(t + i),(y1(t + i)));
        rotate(2);
        stroke(0);
        strokeWeight(amplitude * 2000);
        point(x3(t + i), x4(t + i), (x3(t + i)));
    //rechte Version schwarz 
    } else {
          stroke(0);
          strokeWeight(amplitude + 5 * 4000);
          rotate(z);
          line(x3(t + i), x4(t + i), (x3(t + i)),0);
      }  
}
  t = t + speed;
  a = a + 1;
  z = z + 1;
}


float y1(float t) {
  return sin(t / 10) * 250 + sin(t / 2) * 250;
}
float y2(float t) {
  return sin(t / 200) * 200 + sin(t / 50) * 100;
}
float x1(float t) {
  return sin(t / 100) * 200 + sin(t / 100) * 250;
}
float x2(float t) {
  return sin(t / 200) * 200 + sin(t / 50) * 50;
}
float x3(float t) {
  return sin(t / 1) * 5 + sin(t / 2) * 200;
}
float x4(float t) {
  return sin(t / 100) * 300 + sin(t / 2) * 200;
}

//Screenshot
void keyPressed(){
  saveFrame("result.png");
}