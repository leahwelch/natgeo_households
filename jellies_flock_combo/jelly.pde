class Jelly {
  float x, y; //dimensional variables
  float cx, cy; //center position
  color col;
  PImage soft;
  
  ArrayList<Chain> springs;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  
  Jelly(float cx_, float cy_, float x_, float y_, color col_, PImage soft_) {
    x = x_;
    y = y_;
    cx = cx_;
    cy = cy_;
    
    col = col_;
    soft = soft_;
    tx = 0;
    ty = 1000;
    
    springs = new ArrayList<Chain>();
    for(int i = -10; i < 10; i+=4) {
      springs.add(new Chain(100, 20, 16, 0.2, i, 0, col)); 
    }
    
    //Movement stuff
    position = new PVector(cx,cy);
    velocity = new PVector(random(2,5),random(2,5));
    acceleration = new PVector(0,0);
    r = 30.0;
    maxspeed = 3;
    maxforce = 0.1;
    
  }
  
  void run(ArrayList<Jelly> jellies) {
    flock(jellies);
    update();
    borders();
    //breathe();
    display();
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);  
  }
  
  // We accumulate a new acceleration each time based on three rules
  void flock(ArrayList<Jelly> jellies) {
    PVector sep = separate(jellies);   // Separation
    PVector ali = align(jellies);      // Alignment
    PVector coh = cohesion(jellies);   // Cohesion
    // Arbitrarily weight these forces
    sep.mult(1.5);
    ali.mult(1.0);
    coh.mult(1.0);
    // Add the force vectors to acceleration
    applyForce(sep);
    applyForce(ali);
    applyForce(coh);
  }
    
  void update() {
    
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  PVector seek(PVector target) {
    PVector desired = PVector.sub(target,position);  // A vector pointing from the position to the target
    // Normalize desired and scale to maximum speed
    desired.normalize();
    desired.mult(maxspeed);
    // Steering = Desired minus Velocity
    PVector steer = PVector.sub(desired,velocity);
    steer.limit(maxforce);  // Limit to maximum steering force
    return steer;
  }
  
  void borders() {
    if (position.x < -r) position.x = width;
    if (position.y < -r) position.y = height;
    if (position.x > width) position.x = -r;
    if (position.y > height) position.y = -r;
  }
 
  void breathe() {
    x = map(noise(tx),0,1, 18, 22);
    y = map(noise(ty),0,1, 28, 32);
  }
  
  PVector separate (ArrayList<Jelly> jellies) {
    float desiredseparation = 35.0f;
    PVector steer = new PVector(0,0,0);
    int count = 0;
    // For every boid in the system, check if it's too close
    for (Jelly other : jellies) {
      float d = PVector.dist(position,other.position);
      // If the distance is greater than 0 and less than an arbitrary amount (0 when you are yourself)
      if ((d > 0) && (d < desiredseparation)) {
        // Calculate vector pointing away from neighbor
        PVector diff = PVector.sub(position,other.position);
        diff.normalize();
        diff.div(d);        // Weight by distance
        steer.add(diff);
        count++;            // Keep track of how many
      }
    }
    // Average -- divide by how many
    if (count > 0) {
      steer.div((float)count);
    }

    // As long as the vector is greater than 0
    if (steer.mag() > 0) {
      // Implement Reynolds: Steering = Desired - Velocity
      steer.normalize();
      steer.mult(maxspeed);
      steer.sub(velocity);
      steer.limit(maxforce);
    }
    return steer;
  }
  
  PVector align (ArrayList<Jelly> jellies) {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);
    int count = 0;
    for (Jelly other : jellies) {
      float d = PVector.dist(position,other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.velocity);
        count++;
      }
    }
    if (count > 0) {
      sum.div((float)count);
      sum.normalize();
      sum.mult(maxspeed);
      PVector steer = PVector.sub(sum,velocity);
      steer.limit(maxforce);
      return steer;
    } else {
      return new PVector(0,0);
    }
  }
  
   PVector cohesion (ArrayList<Jelly> jellies) {
    float neighbordist = 50;
    PVector sum = new PVector(0,0);   // Start with empty vector to accumulate all positions
    int count = 0;
    for (Jelly other : jellies) {
      float d = PVector.dist(position,other.position);
      if ((d > 0) && (d < neighbordist)) {
        sum.add(other.position); // Add position
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      return seek(sum);  // Steer towards the position
    } else {
      return new PVector(0,0);
    }
  }

  
  void display() {
    
    float theta = velocity.heading() + PI/2;
    push();
    translate(position.x,position.y);  
    rotate(theta);
    for (Chain c : springs) {
      c.display();
    }
    
    noFill();
    noStroke();
    
    beginShape();
    texture(soft);
    vertex(x,y/2,60,100);
    vertex(-x, y/2,20,100);
    vertex(-2*x, y-y, 0, 50);
    vertex(-x, -y-10, 20, 0);
    vertex(x, -y-10, 60, 0);
    vertex(2*x, y-y, 80, 50);
    endShape(CLOSE);
    
    stroke(col);
    strokeWeight(1);
  
    beginShape();
    curveVertex(4*x, y);
    curveVertex(-x, y/2);
    curveVertex(-2*x, 0);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, 0);
    curveVertex(x, y/2);
    curveVertex(-x, y/2);
    curveVertex(-2*y, y-y);
    endShape(CLOSE);
    
    pop();
    
  }
 
}
