class Mover {
  PVector position;
  PVector velocity;
  PVector acceleration;
  
  float mass;
  
  Oscillator osc;
  
  Mover() {
    position = new PVector(random(width),random(height));
    velocity = new PVector(random(-1,1),random(-1,1));
    acceleration = new PVector();
    mass = random(8,16);
    osc = new Oscillator(mass*2);
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    
    velocity.add(acceleration);
    position.add(velocity); 
    acceleration.mult(0);
    
    osc.update(velocity.mag()/10);
  }
  
  void display() {
    float angle = velocity.heading();
    pushMatrix();
    translate(position.x,position.y);
    rotate(angle);
    ellipseMode(CENTER);
    stroke(0);
    strokeWeight(2);
    fill(255,0,0,100);
    ellipse(0,0,mass*2,mass*2);
    
    osc.display(position);
    popMatrix();
  }
  
} 
  
  
  