class Vehicle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
    
  Vehicle( PVector l, float ms, float mf) {
    position = l.copy();
    r = 4.0;
    maxspeed = ms;
    maxforce = mf;
    acceleration = new PVector(0, 0);
    velocity = new PVector(maxspeed, 0);
  }
  
  void run() {
    update();
    display();
  }
    
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
    
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);  
  }
    
  void follow(Path p) {
    
    //find vehicle's future location
    PVector predict = velocity.get();
    predict.setMag(50);
    PVector predictLoc = PVector.add(position, predict);
    
    PVector normal = null;
    PVector target = null;
    float worldRecord = 100000;
    
    for(int i = 0; i < p.points.size()-1; i++) {
      
      PVector a = p.points.get(i);
      PVector b = p.points.get(i+1);
      
      //get normal point to the path
      PVector normalPoint = getNormalPoint(predictLoc, a, b);
    
      if(normalPoint.x < a.x || normalPoint.x > b.x) {
        normalPoint = b.get();  
      }
      
      //how far is the vehicle from the path?
      float distance = PVector.dist(predictLoc, normalPoint);
      if(distance < worldRecord) {
        worldRecord = distance;
        normal = normalPoint;
        
        //move along the path a little further
        PVector dir = PVector.sub(b,a);
        dir.normalize();
        dir.mult(10);
        target = PVector.add(normalPoint, dir);
       }
      }
      if(worldRecord > p.radius) {
        seek(target); 
      }
    }
    
  // A function to get the normal point from a point (p) to a line segment (a-b)
  PVector getNormalPoint(PVector p, PVector a, PVector b) {
    // Vector from a to p
    PVector ap = PVector.sub(p, a);
    // Vector from a to b
    PVector ab = PVector.sub(b, a);
    ab.normalize(); // Normalize the line
    // Project vector "diff" onto line by using the dot product
    ab.mult(ap.dot(ab));
    PVector normalPoint = PVector.add(a, ab);
    return normalPoint;
  }
    
 void seek(PVector target) {
    PVector desired = PVector.sub(target,position);
    float d = desired.mag();
    
    if (d == 0) {
      return;
    }
    
    desired.normalize();
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);
    applyForce(steer);
  }
    
  void display() {
    float theta = velocity.heading2D() + PI/2;
    fill(127);
    stroke(0);
    strokeWeight(1);
    push();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape(CLOSE);
    pop();
  }
  
  void borders(Path p) {
    if (position.x > p.getEnd().x + r) {
      position.x = p.getStart().x - r;
      position.y = p.getStart().y + (position.y-p.getEnd().y);
    }
  }

}
