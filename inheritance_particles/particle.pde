class Particle {
  PVector location;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  float lifespan;
  
  Particle(PVector l) {
    acceleration = new PVector(0,0.05);
    velocity = new PVector(random(-1,1),random(-2,0));
    location = l.copy();
    lifespan = 255.0;
  }
  
  void run() {
    update();
    display();
  }
  
  void update() {
    
    velocity.add(acceleration);
    location.add(velocity); 
    //acceleration.mult(0);
    lifespan -= 2;
    //velocity.limit(5);
  }

  
   void display() {
    stroke(0,lifespan);
    fill(127,0,0,lifespan);
    ellipse(location.x,location.y,12,12);
  }
  
  boolean isDead() {
    if(lifespan <= 0) {
      return true;
    } else {
      return false;
    }
  }
} 
  
  
  