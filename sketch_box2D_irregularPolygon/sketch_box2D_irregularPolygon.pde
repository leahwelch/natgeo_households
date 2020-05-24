import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

ArrayList<Trapezoid> trapezoids;
//ArrayList<Boundary> boundaries;

Surface surface;

void setup() {
  size(640,360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-5);
  
  trapezoids = new ArrayList<Trapezoid>();
  surface = new Surface();
}

void draw() {
  background(255);
  
  box2d.step(); 
  
  if(random(1) < 0.2) {
    Trapezoid t = new Trapezoid(width/2, 10);
    trapezoids.add(t);
  }
  
  surface.display();
  
  for (Trapezoid t: trapezoids) {
    t.display(); 
  }
}
