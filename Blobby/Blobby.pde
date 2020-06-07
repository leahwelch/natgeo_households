// Modification of the Blob simulation created by Daniel Shiffman for NOC
//Using box2D physics engine

import shiffman.box2d.*;

import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.joints.*;

// A reference to our box2d world
Box2DProcessing box2d;

// A list we'll use to track fixed objects
ArrayList<Boundary> boundaries;
ArrayList<Blob> blobs;

// Our "blob" object
//Blob blob;

 void setup() {
  size(800,600);
  smooth();

  // Initialize box2d physics and create the world
  box2d = new Box2DProcessing(this);
  box2d.createWorld();

  // Add some boundaries
  boundaries = new ArrayList<Boundary>();
  boundaries.add(new Boundary(width/2,height-5,width,10));
  boundaries.add(new Boundary(width/2,5,width,10));
  boundaries.add(new Boundary(width-5,height/2,10,height));
  boundaries.add(new Boundary(5,height/2,10,height));
  
  blobs = new ArrayList();

  // Make a new blob
  //blob = new Blob();
}

 void draw() {
  background(255);

  // We must always step through time!
  box2d.step();

  // Show the blob!
  //blob.display();

  // Show the boundaries!
  for (Boundary wall: boundaries) {
    wall.display();
  }

  for (Blob b: blobs) {
      b.display();
    }

}

void mousePressed() {
  Blob b = new Blob(mouseX, mouseY);
  blobs.add(b);
}
