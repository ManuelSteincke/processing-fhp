//This sketch creates a glitch of a photo or sorts it by brightness
//The programm needs a few minutes to complete its work
//Scroll down to change 

//https://www.youtube.com/watch?v=JUDYkxU6J0o

PImage img;
PImage sorted;

void setup() {
  //size(1000,500);
  size(500,500);
  img = loadImage("example.png");
  sorted = createImage(img.width, img.height, RGB);
  sorted.loadPixels();
  img.loadPixels();
  for (int i = 0; i < sorted.pixels.length; i++) {
    sorted.pixels[i] = img.pixels[i];
  }
  sorted.updatePixels();


  //Selection sort
  for (int i = 0; i < sorted.pixels.length; i++) {
    float record = -1;
    int selectedPixel = i;
    for (int j = i; j < sorted.pixels.length; j++) {
      color pix = sorted.pixels[j];
      float b = brightness(pix);
      //float b = hue(pix);
      if (b > record) {
        selectedPixel = j;
        record = b;
      }
  //} wenn die Klammer hier gesetzt ist, wird das komplette Bild gesorted
    
    //Swap selectedPixel with i
    color temp = sorted.pixels[i];
    sorted.pixels[i] = sorted.pixels[selectedPixel];
    sorted.pixels[selectedPixel] = temp;
    } //siehe darüber
  }
}  

void draw(){
  background(0);
  //image(img, 0, 0);
  //image(sorted, 500, 0);
  image(sorted, 0, 0);
}

void keyPressed(){
  saveFrame("example_result.png");
}