Jelly jelly;
boolean debug = false;

float amplitude = 5;
float angle = 0.0;

void setup() {
  size(600,600);
  jelly = new Jelly(20,30);
}

void draw() {
  background(2,1,32);
  smooth();
  jelly.display();
  jelly.update();
  jelly.checkEdges();
 
}

void keyPressed() {
  debug = !debug;
}
