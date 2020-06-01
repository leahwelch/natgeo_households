class Person {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  float diameter;
  
  Person(float x, float y, float d) {
    position = new PVector(x, y);
    diameter = d;
    mass = d;
    velocity = new PVector(.5,0);
    acceleration = new PVector(0,0);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    
    velocity.add(acceleration);
    position.add(velocity); 
    acceleration.mult(0);
  }
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(position.x,position.y,diameter,diameter);
  }
  
}
