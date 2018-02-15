//This sketch shows two morphing three dimensional supershapes
//Use PeasyCam to navigate

//https://www.youtube.com/watch?v=akM4wMZIBWg
//3D supershape basiert auf zwei 2D supershapes (horizontal u vertikal)
//diese basieren auf latitude und longitude

import peasy.*;

PeasyCam cam;

//callculate all points in an 2D-array
PVector[][] globe;
//detail
int total = 100;

float Farbaenderung = 0;
//wenn m = 0 ist, entsteht eine Kugel/Sphere
float m = 0;
float m2 = 0;
float n1 = 0;
float n2 = 0;
float n3 = 0;
float n4 = 0;
float n5 = 0;
float n6 = 0;
float change = 0;

//longitude = Längengrad -> -160Grad bis 180Grad um eine Kugel..
//latitude = Breitengrad | -90 bis 90Grad um eine Kugel zu erzeugen

void setup() {
  fullScreen(P3D);
  //this = this sketch
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  
  globe = new PVector[total+1][total+1];
}

//a+b beeinflussen die quality der shape(?)
float a = 1;
float b = 1;

float supershape(float theta, float m, float n1, float n2, float n3) {
  //abs = absolute value
  float t1 = abs((1/a)*cos(m * theta / 4)); 
  t1 = pow(t1,n2);
  float t2 = abs((1/b)*sin(m * theta/4)); 
  t2 = pow(t2, n3);
  float t3 = t1 + t2;
  float r = pow(t3, -1 / n1);
  return r;
}

void draw() {
  //morphen der zwei Supershapes
  m = map(sin(change), -1, 1, 8, 7);
  m2 = map(sin(change), -1, 1, 2, 7);
  n1 = map(sin(change), -1, 1, 60, 0.2);
  n2 = map(sin(change), -1, 1, 100, 1.7);
  n3 = map(sin(change), -1, 1, 30, 1.7);
  n4 = map(sin(change), -1, 1, 10, 0.2);
  n5 = map(sin(change), -1, 1, 10, 1.7);
  n6 = map(sin(change), -1, 1, 10, 1.7);
  //morph Geschwindigkeit
  change += 0.01;
  
  background(0);
  //lights();
  //translate brauchen wir nicht mehr, da PeasyCam es automatisch macht
  //translate(width/2, height/2);
  //sphere(200);
  
  //vorherige Übung (Superellipse+2DSupershapes) 
  //-> (r,theta(theta ist derWinkel)) -> (x,y)
  //nun brauchen wir aber:
  //(r,lat,lon) -> (x,y,z)
  
  
 //alles wird hier kalkuliert, dann kommt es ins 2D-Array..
 //r = Radius
  float r = 200;
  for (int i = 0; i < total+1; i++) {
    float lat = map(i, 0, total, -HALF_PI, HALF_PI);
    //Werte von http://paulbourke.net/geometry/supershape/
    //nachgucken um andere Shapes zu erzeugen
    //float r2 = supershape(lat, 5, 15.4425, -0.453763, 87.07); (3)
    //float r2 = supershape(lat, 2, 10, 10, 10); (2)
    float r2 = supershape(lat, m2, n4, n5, n6); //(1)
    for (int j = 0; j < total+1; j++) {
      float lon = map(j, 0, total, -PI, PI);
      //hier auch 
      //float r1 = supershape(lon, 0, 0.479398, 30.2539, 0.3563); (3)
      //float r1 = supershape(lon, 8, 60, 100, 30); (2)
      float r1 = supershape(lon, m, n1, n2, n3); //(1)
      //Formel eingefügt
      float x = r * r1 * cos(lon) * r2 * cos(lat);
      float y = r * r1 * sin(lon) * r2 * cos(lat); 
      float z = r * r2 * sin(lat);
      //PVector kann x,y,z zusammen storen
      globe[i][j] = new PVector(x,y,z);
      //perlin noise einfügen!
      //flattern:
      //PVector v = PVector.random3D();
      //Stärke 
      //v.mult(5);
      //globe[i][j].add(v);
    }
  }
    //Geschwindigtkeit der Farbveränderung
    Farbaenderung += 1;
    //noStroke();
    stroke(0);
    //noFill();
    //..und wird hier dann dargestellt
    //i++ wenn die Shape geschlossen sein soll
    for (int i = 0; i < total; i = i + 2) {
        float hu = map(i, 0, total, 0, 255);
        fill((hu + Farbaenderung) % 255, 255, 255);
      
      //modulo erzeugt streifenbildung
      //if (i % 2 == 0){
        //fill(0);
      //}  else {
        //fill(255);
      //}
      
      beginShape(TRIANGLE_STRIP);
      for (int j = 0; j < total+1; j++) {
        //float hu2 = map(j, 0, total, 0, 255*6);
        //fill(hu2 % 255, 255, 255);
        PVector v1 = globe[i][j];
        //noStroke();
       // stroke(255);
        //strokeWeight(2);
        vertex(v1.x, v1.y, v1.z);
        //um das Triangle erzeugen zu können, muss i verschoben werden
        PVector v2 = globe[i+1][j];
        vertex(v2.x,v2.y,v2.z);
        //modulo könnte auch hier eingefügt werden (horizontale Streifen)
        //if (j % 2 == 0){
        //fill(0);
     // }  else {
       // fill(255);
      //}
    }
    endShape();  
  }
}

//Screenshot
void keyPressed(){
  saveFrame("result.png");
}