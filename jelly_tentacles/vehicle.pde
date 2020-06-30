class Vehicle {
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;
  float maxspeed;
  float a;
    
  Vehicle( PVector l, float ms, float mf) {
    position = l.copy();
    r = random(2.0,10.0);
    a = random(50.0,200.0);
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
    
    for(int i = 0; i < (p.points.length)-1; i++) {
      
      PVector a = p.points[i];
      PVector b = p.points[i+1];
      
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
    fill(255,a);
    noStroke();
    push();
    translate(position.x, position.y);
    rotate(theta);
    beginShape();
    ellipse(0,0,r,r);
    pop();
  }
  
  void borders(Path p) {
    PVector desired = null;
    
    if (position.x > p.getEnd().x) {
      desired = new PVector(-maxspeed, velocity.y);
      //position.x = p.getStart().x - r;
      //position.y = p.getStart().y + (position.y-p.getEnd().y);
    } else if (position.y < p.getEnd().y) {
      desired = new PVector(velocity.x, -maxspeed);
    }
    
    if (position.x < p.getEnd().x-25) {
      desired = new PVector(maxspeed, velocity.x);
    } 
    else if (position.x > p.getStart().x) {
      desired = new PVector(-maxspeed, velocity.x);
    } 

    if (position.y < p.getStart().y) {
      desired = new PVector(velocity.y, maxspeed);
    } 
    else if (position.y > p.getEnd().y) {
      desired = new PVector(velocity.y, -maxspeed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }

}
