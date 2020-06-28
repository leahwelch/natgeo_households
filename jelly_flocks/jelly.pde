class Jelly {

  color col;
  PImage soft;
  float tx, ty;
  
  PVector position;
  float x, y;
  float cx, cy;
  PVector velocity;
  PVector acceleration;
  float r;
  float maxforce;    // Maximum steering force
  float maxspeed;    // Maximum speed
  
  //oscillation stuff
  PVector a,b;
  float amplitude = 3;
  float angle = 0.0;

  Jelly(float cx_, float cy_, float x_, float y_, color col_, PImage soft_) {
    col = col_;
    soft = soft_;
    
    cx = cx_;
    cy = cy_;
    acceleration = new PVector(0,0);
    velocity = new PVector(random(2,5),random(2,5));
    position = new PVector(cx,cy);
    r = 30.0;
    maxspeed = 3;
    maxforce = 0.1;
    x = x_;
    y = y_;
    
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
  }

  void run(ArrayList<Jelly> jellies) {
    flock(jellies);
    update();
    borders();
    render();
  }

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
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

  // Method to update position
  void update() {
    // Update velocity
    velocity.add(acceleration);
    // Limit speed
    velocity.limit(maxspeed);
    position.add(velocity);
    // Reset accelertion to 0 each cycle
    acceleration.mult(0);
    
    angle += velocity.mag()/10;
  }

  // A method that calculates and applies a steering force towards a target
  // STEER = DESIRED MINUS VELOCITY
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
  
  void render() {
    // Draw a triangle rotated in the direction of velocity
    a.x = map(sin(angle),-1,1,a.x,-amplitude);
    a.y = amplitude * sin(angle)+10;
    
    b.x = map(sin(angle),-1,1,b.x,3*amplitude/2);
    b.y = amplitude * sin(angle)+10;
    
    float theta = velocity.heading() + radians(90);
    noFill();
    
    noStroke();
    push();
    translate(position.x,position.y);  
    rotate(theta);
    beginShape();
    texture(soft);
    vertex(x, y/2,60,100);
    vertex(-x, y/2,20,100);
    vertex(-2*x, y-y, 0, 50);
    vertex(-x, -y-10, 20, 0);
    vertex(x, -y-10, 60, 0);
    vertex(2*x, y-y, 80, 50);
    endShape(CLOSE);
    
    stroke(col);
    beginShape();
    curveVertex(4*x, y);
    curveVertex(a.x, a.y);
    curveVertex(-2*x, 0);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, 0);
    curveVertex(b.x, b.y);
    curveVertex(x/8,y);
    curveVertex(a.x, a.y);
    
    curveVertex(-2*y, y-y);
    endShape(CLOSE);
    pop();
    
    angle += 0.05;
  }
  
  /*void breathe() {
    x = map(noise(tx),0,1, 8, 12);
    y = map(noise(ty),0,1, 12, 18);
    
    tx += 0.05;
    ty += 0.05;
    
    //if (debug) drawVertices(); 
  }*/

  // Wraparound
  void borders() {
    if (position.x < -r) position.x = width+r;
    if (position.y < -r) position.y = height+r;
    if (position.x > width+r) position.x = -r;
    if (position.y > height+r) position.y = -r;
  }

  // Separation
  // Method checks for nearby boids and steers away
  PVector separate (ArrayList<Jelly> jellies) {
    float desiredseparation = 25.0f;
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

  // Alignment
  // For every nearby boid in the system, calculate the average velocity
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

  // Cohesion
  // For the average position (i.e. center) of all nearby boids, calculate steering vector towards that position
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
}
