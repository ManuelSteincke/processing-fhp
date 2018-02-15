//This sktech shows a menger sponge fractal 
//Press any key to create a new generation
//Use PeasyCam to navigate

//jeweils 27 boxes
import peasy.*;
PeasyCam cam;

float a = 0;

ArrayList<Box> sponge;

void setup() {
  fullScreen(P3D);
  //(400, 400, P3D);
  cam = new PeasyCam(this, 0, 0, 0, 500);
  sponge = new ArrayList<Box>();
  Box b = new Box(0,0,0,200);
  sponge.add(b);
}
void keyPressed() {
  saveFrame("result.png");
  //für eine neue Generation wird eine leere Arraylist erzeugt, 
  //für jede Box die sich gerade in sponge befindet wird durch 27 geteilt
  //diese werden dann ins nächste eingefügt
  ArrayList<Box> next = new ArrayList<Box>();
  for (Box b : sponge) {
    ArrayList<Box> newBoxes = b.generate();
    //addAll - fügt eine ganze Arraylist hinzu
    next.addAll(newBoxes);
  }
  sponge = next;
}

void draw() {
  background(0);
  stroke(255);
  noFill();
  lights();
  
  translate(width/2, height/2);
  rotateX(a);
  rotateY(a*0.4);
  rotateZ(a*0.1);
  for (Box b : sponge) {
    b.show();  
  }
  a += 0.01;
}