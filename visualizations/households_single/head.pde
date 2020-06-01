class Head {
 
  float x;
  float y;
  float diameter;
  
  float mass;
  float G;
  
  Head(float x_, float y_, float diameter_) {
    x = x_;
    y = y_;
    diameter = diameter_;
    mass = diameter_;
    G = 1;
  }
  
  PVector attract(Person p) {
    PVector force = PVector.sub(new PVector(x,y),p.position);
    float d = force.mag();
    d = constrain(d,10.0,15.0);
    force.normalize();
    float strength = (G * mass * p.mass) / (d * d);
    force.mult(strength);
    return force;
  }
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(x,y,diameter,diameter);
  }
  
}
