//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;
float tx, ty;

Flock[] flocks = new Flock[4];
Jelly[] jellies = new Jelly[4];
color[] cols = new color[4];  
PImage[] softs = new PImage[4];


void setup() {
  size(600,600, P2D);
  
  // Initialize the physics world
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  
  cols[0] = color(255);
  cols[1] = color(249,247,192);
  cols[2] = color(249,199,222);
  cols[3] = color(204, 252, 200);
  
  for (int i = 0; i < softs.length; i ++ ) {
    softs[i] = loadImage( "soft_" + (i+1) + ".png" );
  }
  for(int i = 0; i<flocks.length; i++) {
    flocks[i] = new Flock();
    for (int j = 0; j < 10; j++) {
      flocks[i].addJelly(new Jelly(width/2,height/2, 20, 30, cols[i], softs[i]));
    }
  }
  
}

void draw() {
  background(2,1,32);
  smooth();
  
  // Update physics
  physics.update();
  
  for(int i = 0; i<flocks.length; i++) {
    flocks[i].run();  
  }
  
  tx += 0.01;
  ty += 0.01;
}
