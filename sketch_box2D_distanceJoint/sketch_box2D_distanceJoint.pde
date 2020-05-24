import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;

Box2DProcessing box2d;

ArrayList<Pair> pairs;
ArrayList<Boundary> boundaries;

void setup() {
  size(640,360);
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  
  pairs = new ArrayList<Pair>();
  boundaries = new ArrayList<Boundary>();
  
  boundaries.add(new Boundary(width/4,height/2+100,width/2,10));
  boundaries.add(new Boundary(3*width/4,height/3+100,width/2-50,10));
}

void draw() {
  background(242,219,222);
  
  for (Boundary wall: boundaries) {
    wall.display();
  }
  
  box2d.step(); 
  
  
  for (Pair p: pairs) {
    p.display(); 
  }
}

  void mousePressed() {
    Pair p = new Pair(mouseX,mouseY);
    pairs.add(p);
  }
