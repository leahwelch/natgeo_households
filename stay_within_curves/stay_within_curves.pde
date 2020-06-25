PImage blues;
ArrayList<Vehicle> boids;

Jelly jelly;
float bx = 70;
float by = 123;

PVector circleposition;
float circleRadius;


void setup() {
  size(600,600, P2D);
  jelly = new Jelly();
  blues = loadImage("blues50.png");
  boids = new ArrayList();
  
  circleposition = new PVector(bx/4-25,by/4-25);
  circleRadius = 170;
  //v = new Vehicle(0,0);
}

void draw() {
  background(2,1,32);
  smooth();
  jelly.vibrate();
  jelly.display();
  
  noStroke();
  noFill();
  
  //translate(width/2,height/2);

  beginShape();
  texture(blues);
  vertex(bx, by,60,100);
  vertex(-bx, by,20,100);
  vertex(-2*bx, by-by, 0, 50);
  vertex(-bx, -by, 20, 0);
  vertex(bx, -by, 60, 0);
  vertex(2*bx, by-by, 80, 50);
  endShape(CLOSE);
  
  //bx += random(-2,2);
  //by += random(-2,2);
  by = constrain((by + random(-1,1)), 130, 150);
  bx = constrain((bx + random(-1,1)), 70, 90);
  
  for(Vehicle v : boids) {
    v.applyBehaviors(boids);
    v.boundaries();
    v.run();
  }

}

void mousePressed() {
  boids.add(new Vehicle(0,0));  
}
