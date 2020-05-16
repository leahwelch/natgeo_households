class Ball {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Ball() {
    location = new PVector(random(width),0);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    mass = random(0.5,5);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    //PVector mouse = new PVector(mouseX,mouseY);
    //mouse.sub(location);
    //mouse.setMag(0.5);
    //acceleration = mouse;
    
    velocity.add(acceleration);
    location.add(velocity); 
    acceleration.mult(0);
    //velocity.limit(5);
  }
  
  void checkEdges() {
    if (location.x > width) {
      location.x = width;
      velocity.x *= -1;
    } else if (location.x < 0) {
      velocity.x *= -1;
      location.x = 0;
    }

    if (location.y > height) {
      velocity.y *= -1;
      location.y = height;
    }
  }
  
    void display() {
    stroke(0);
    fill(127,0,0,100);
    ellipse(location.x,location.y,mass*20,mass*20);
  }
} 
  
  
  