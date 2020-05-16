class Attractor {
  float mass;
  float G;
  PVector position;
  
  Attractor() {
    position = new PVector(width/2,height/2);
    mass = 10;
    G = 1;
    //dragOffset = new PVector(0.0,0.0);
  }
  
  PVector attract(Mover m) {
    PVector force = PVector.sub(position,m.position);
    float d = force.mag();
    d = constrain(d,5.0,25.0);
    force.normalize();
    float strength = (G * mass * m.mass) / (d * d);
    force.mult(strength);
    return force;
  }
  
  void display() {
    ellipseMode(CENTER);
    stroke(0);
    strokeWeight(4);
    fill(127);
    ellipse(position.x,position.y,mass*2,mass*2);
  }
  
  
} 
  
  
  