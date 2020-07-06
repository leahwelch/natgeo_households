//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;

Attractor a;

float tx, ty;

//oscillation & Perlin noise
float t;
float t1;

PImage soft;
Jelly jelly;

void setup() {
  size(800,600, P2D); 
  
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  
  jelly = new Jelly();
  soft = loadImage("soft2.png");
  
  a = new Attractor();

}

void draw() {
  background(2,1,32);
  smooth();
  
  // Update physics
  physics.update();
  
  jelly.display();
  PVector force = a.attract(jelly);
  jelly.applyForce(force);
  jelly.update();
  
  t += 0.05;
  t1 += 0.01;
  tx += 0.01;
  ty += 0.01;
}

float r(float theta, float a, float b, float m1, float m2, float n1, float n2, float n3) {
   return pow(pow(abs(cos(m1 * theta/4.0)/a),n2) + 
     pow(abs(sin(m2 * theta/4.0)/b),n3), -1.0/n1);
}
