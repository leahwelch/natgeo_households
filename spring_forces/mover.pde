class Mover {
  PVector location;
  PVector velocity;
  PVector acceleration;
  float mass;
  
  Mover(float x, float y) {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = 1;
  }
  
  void display() {
    stroke(0);
    fill(0,100,255);
    ellipse(location.x, location.y, 30,30);
  }
  
  void update() {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void applyForce (PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
}