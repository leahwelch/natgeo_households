boolean debug = false;

PImage soft;
Jelly jelly;
Path p1;
Path p2;
ArrayList<Vehicle> beads;
ArrayList<Vehicle> beads2;

void setup() {
  size(600,600, P2D);
  newJelly();
  p1 = new Path(80,120);
  p2 = new Path(-80,120);
  translate(width/2, height/2);
  beads = new ArrayList();
  beads2 = new ArrayList();
  
  soft = loadImage("soft.png");
  
}

void draw() {
  background(2,1,32);
  smooth();
  jelly.breathe();
  jelly.display();
  p1.display();
  p2.display();
  
  for(Vehicle b : beads2) {
    b.follow(p2);
    b.run();
    b.borders(p2);
  }
   for(Vehicle b : beads) {
    b.follow(p1);
    b.run();
    b.borders(p1);
  }
}

void mousePressed() {
  beads.add(new Vehicle(new PVector(0, -135), 3, 0.05));
  beads2.add(new Vehicle(new PVector(0, -135), 3, 0.05));
}

void keyPressed() {
  debug = !debug;
}

void newJelly() { 
  jelly = new Jelly(80,120);
}
