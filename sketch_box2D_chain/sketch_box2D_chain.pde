import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

ArrayList<Box> boxes;
//ArrayList<Boundary> boundaries;

Surface surface;

void setup() {
  size(640,360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.setGravity(0,-5);
  
  boxes = new ArrayList<Box>();
  surface = new Surface();
}

void draw() {
  background(255);
  
  box2d.step(); 
  
  if(random(1) < 0.2) {
    Box b = new Box(width/2, 10);
    boxes.add(b);
  }
  
  surface.display();
  
  for (Box b: boxes) {
    b.display(); 
  }
}
