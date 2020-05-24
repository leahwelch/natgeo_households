import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

Box2DProcessing box2d;

ArrayList<Box> boxes;
ArrayList<Boundary> boundaries;

void setup() {
  size(640,360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  boxes = new ArrayList<Box>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/4,height/2,width/2,10, -0.3));
  boundaries.add(new Boundary(3*width/4,height/3,width/2-50,10, 0.5));
}

void draw() {
  background(255);
  
  for (Boundary wall: boundaries) {
    wall.display();
  }
  
  box2d.step(); 
  
  if(random(1) < 0.2) {
    Box b = new Box(width/5, 10);
    boxes.add(b);
  }
  
  if(random(1) > 0.7) {
    Box b = new Box(width/2+100, 10);
    boxes.add(b);
  }
  
  
  for (Box b: boxes) {
    b.display(); 
  }
}
