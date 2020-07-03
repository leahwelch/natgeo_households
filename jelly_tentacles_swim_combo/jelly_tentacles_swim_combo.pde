//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;
float tx, ty;
Jelly jelly;

float amplitude = 5;
float angle = 0.0;

PImage soft;


void setup() {
  size(600,600, P2D);
  
  // Initialize the physics world
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  jelly = new Jelly(40,60);
  
  //translate(width/2, height/2);
  
  soft = loadImage("soft.png");
  
}

void draw() {
  background(2,1,32);
  smooth();
  
  // Update physics
  physics.update();
  jelly.update();
  jelly.checkEdges();
  //b.borders();
  jelly.run();
  
  tx += 0.01;
  ty += 0.01;
}
