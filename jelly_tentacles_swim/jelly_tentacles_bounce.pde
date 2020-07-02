//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;
float tx, ty;
United b;
boolean locked;

float amplitude = 5;
float angle = 0.0;

PImage soft;
//Jelly jelly;
Path p1;
Path p2;
ArrayList<Vehicle> beads;
ArrayList<Vehicle> beads2;

void setup() {
  size(600,600, P2D);
  
  // Initialize the physics world
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  b = new United();
  
  //newJelly();
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
  
  // Update physics
  physics.update();
  b.update();
  b.checkEdges();
  //b.borders();
  b.display();
  
  //jelly.run();
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
  
  tx += 0.01;
  ty += 0.01;
}

void keyPressed() {
  beads.add(new Vehicle(new PVector(0, -135), 3, 0.05));
  beads2.add(new Vehicle(new PVector(0, -135), 3, 0.05));
}

/*void newJelly() { 
  jelly = new Jelly(80,120);
}*/
