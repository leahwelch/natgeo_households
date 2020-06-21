

class Vehicle {

  PVector position;
  PVector velocity;
  PVector acceleration;
  float r;

  float maxspeed;
  float maxforce;
  
  Vehicle(float x, float y) {
    acceleration = new PVector(0, 0);
    velocity = new PVector(random(0,3),random(-2,2));
    velocity.mult(5);
    position = new PVector(x, y);
    r = random(5,10);
    maxspeed = 3;
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

  void boundaries() {

    PVector desired = null;

    if (position.x < -80) {
      desired = new PVector(maxspeed, velocity.y);
    } 
    else if (position.x > 80) {
      desired = new PVector(-maxspeed, velocity.y);
    } 

    if (position.y < -140) {
      desired = new PVector(velocity.x, maxspeed);
    } 
    else if (position.y > 140) {
      desired = new PVector(velocity.x, -maxspeed);
    } 

    if (desired != null) {
      desired.normalize();
      desired.mult(maxspeed);
      PVector steer = PVector.sub(desired, velocity);
      steer.limit(maxforce);
      applyForce(steer);
    }
  }  

  void applyForce(PVector force) {
    // We could add mass here if we want A = F / M
    acceleration.add(force);
  }


  void display() {
    // Draw a triangle rotated in the direction of velocity
    //float theta = velocity.heading2D() + radians(90);
    fill(255,100);
    noStroke();
    pushMatrix();
    translate(position.x, position.y);
    //rotate(theta);
    ellipse(0,0,r,r);
    /*beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();*/
    popMatrix();
  }
}
