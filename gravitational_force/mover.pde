class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Mover() {
    position = new PVector(300,300);
    velocity = new PVector(1,0);
    acceleration = new PVector(0,0);
    mass = 1;
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
    strokeWeight(2);
    fill(127);
    ellipse(position.x,position.y,20,20);
  }
  
  void checkEdges() {
    if (position.x > width) {
      position.x = 0;
      velocity.x *= -1;
    } else if (position.x < 0) {
      position.x = width;
    }

    if (position.y > height) {
      velocity.y *= -1;
      position.y = height;
    }
  }
  
} 
  
  
  