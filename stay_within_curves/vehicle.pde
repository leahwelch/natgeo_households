class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;
  float sep;

  float maxspeed;
  float maxforce;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(0,3),random(0,2));
    velocity.mult(5);
    position = new PVector(x, y);
    r = random(10,20);
    sep = 25;
    maxspeed = 5;
    maxforce = 0.15;
  }

  void run() {
    update();
    display();
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
  }
  
  void applyBehaviors(ArrayList<Vehicle> vehicles) {
    PVector separateForce = separate(vehicles);
    //PVector boundaryForce = boundaries();
    //weighting the forces
    //can this be done dynamically to be based in the data??
    //boundaryForce.mult(1);
    separateForce.mult(2);
    applyForce(separateForce);
    //applyForce(boundaryForce);
  }
    
  PVector separate (ArrayList<Vehicle> vehicles) {
      float desiredseparation = sep;
      PVector sum = new PVector();
      int count = 0;
      for (Vehicle other : vehicles) {
        float d = PVector.dist(position, other.position);
        if ((d > 0) && (d < desiredseparation)) {
          PVector diff = PVector.sub(position, other.position);
          diff.normalize();
          diff.div(d);
          sum.add(diff);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        sum.normalize();
        sum.mult(maxspeed);
        sum.sub(velocity);
        sum.limit(maxforce);
      }
      return sum;
    }

  void boundaries() {

    PVector desired = null;
    
    // Predict position 25 (arbitrary choice) frames ahead
    PVector predict = velocity.get();
    predict.mult(25);
    PVector futureposition = PVector.add(position, predict);
    float distance = PVector.dist(futureposition,circleposition);
    
    if (distance > circleRadius) {
      PVector toCenter = PVector.sub(circleposition,position);
      toCenter.normalize();
      toCenter.mult(velocity.mag());
      desired = PVector.add(velocity,toCenter);
      desired.normalize();
      desired.mult(maxspeed);
    }

    if (desired != null) {
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
    
    //fill(255,0,0);
    //ellipse(futureposition.x,futureposition.y,4,4);
    
  }  

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  void display() {
    // Draw a triangle rotated in the direction of velocity
    float theta = velocity.heading2D() + radians(90);
    fill(255,50);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    rotate(theta);
    ellipse(0,0,r,2*r);
    /*beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();*/
    popMatrix();
  }
}
