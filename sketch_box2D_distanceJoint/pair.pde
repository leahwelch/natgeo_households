class Pair {

  Particle p1;
  Particle p2;
  
  float len;
  
  Pair(float x, float y) {
    
    len = 32;
    
    p1 = new Particle(x,y);
    p2 = new Particle(x + random(-1,1), y + random(-1,1));
    
    //STARTING THE JOINT
    
    //Create the Joint
    DistanceJointDef djd = new DistanceJointDef();
    djd.bodyA = p1.body;
    djd.bodyB = p2.body;
     
    djd.length = box2d.scalarPixelsToWorld(len);
    
    //Configure the properties
    djd.frequencyHz = 1; //Between 0 and 5, 0 is totally rigid
    djd.dampingRatio = 0.1; //Between 0 and 1, 1 is totally rigid
    
    //Actually create the joint
    DistanceJoint dj = (DistanceJoint) box2d.world.createJoint(djd);
    
  }
  
  void display() {
    Vec2 pos1 = box2d.getBodyPixelCoord(p1.body);
    Vec2 pos2 = box2d.getBodyPixelCoord(p2.body);
    
    stroke(47,9,9);
    strokeWeight(2);
    line(pos1.x, pos1.y, pos2.x, pos2.y);
    
    p1.display();
    p2.display();
  }
  
  
}
