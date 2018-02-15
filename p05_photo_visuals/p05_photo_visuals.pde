//This sketch generates some visuals
//Wait for it

static final float NUM_LINES = 0.5;

float t;
float speed = 0.2;
PImage photo;
float angle = 0;
float Strobo = 1;

void setup() {
  background(0);
  size(800, 800);
}

void draw() {
  stroke(255);
  strokeWeight(1);  
  translate(width/2, height/2);
  
  angle = angle + 2;
   
  if (angle > 20){
    for(int i = 0; i < NUM_LINES; i++){
    line(x1(t + i), y1(t + i), x2(t + i), y2(t + i));
    }
  }
  
  //lässst das Mandala anhalten (nach einer Umrundung = 127)
  if (t < 127) {
  t = t + speed;
  }
  else {
  speed = 0;  
  }
  
  //Weißer Kreise Effekt
  if (speed == 0) {
  fill(0);
  stroke(255);
  strokeWeight(2);
  ellipse(0,0,Strobo,Strobo);
  noFill();
  ellipse(0,0,Strobo - 50,Strobo - 50);
  strokeWeight(1.5);
  ellipse(0,0,Strobo - 100, Strobo - 100);
  strokeWeight(1);
  ellipse(0,0,Strobo - 150, Strobo - 150);
  
  }
  if (Strobo < 200) {
  Strobo = Strobo + 1;
  } 
  else {
  Strobo = Strobo - 200;  
  }  
  
  //Foto + Drehung
  rotate(angle);
  photo = loadImage("photo.png");
  image(photo, 0, 0);
  
  if (angle > 20){
   frameRate (30);
  }
  else {
    frameRate(4);
  }
  
  //Färbung des Fotos (Ellipse)
  noStroke();
  fill(0,0,0,100);
  ellipse(250,250,300,300);
}

  //sin(.. / ..) || (.. * ..) reguliert die Frequenz
  //* 100 reguliert die Amplitude (Schwingungsweite)

float x1(float t) {
  return sin(t / 50) + sin(t / 20) * 170;
}
float y1(float t) {
  return cos(t / 50) + cos(t / 20) * 170;
}
float x2(float t) {
  return sin(t) * 120 + sin(t / 20);
}
float y2(float t) {
  return cos(t) * 120 + cos(t / 20);
}

//Screenshot
void keyPressed(){
  saveFrame("result.png");
}