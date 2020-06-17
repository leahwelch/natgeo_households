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
    
    //look at the path
    PVector a = p.start;
    PVector b = p.end;
    
    //get normal point to the path
    PVector normalPoint = getNormalPoint(predictLoc, a, b);
    
    //move along the path a little further
    PVector dir = PVector.sub(b,a);
    dir.normalize();
    dir.mult(10);
    PVector target = PVector.add(normalPoint, dir);
    
    //how far is the vehicle from the path?
    float distance = PVector.dist(predictLoc, normalPoint);
    if(distance > p.radius) {
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
    if (position.x > p.end.x + r) {
      position.x = p.start.x - r;
      position.y = p.start.y + (position.y-p.end.y);
    }
  }

}
