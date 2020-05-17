class Spring {
  PVector anchor;
  float restLength;
  float k = 0.05;
  
  Spring(float x, float y) {
    restLength = 200;
    anchor = new PVector(x,y); 
  }
  
  void connect(Mover m) {
    PVector force = PVector.sub(m.location,anchor);
    float currentLength = force.mag();
    float stretch = currentLength - restLength;
    force.normalize();
    force.mult(-k*stretch);
    
    m.applyForce(force);
  }
  
  void display(Mover m) {
    strokeWeight(2);
    stroke(0);
    line(m.location.x, m.location.y, anchor.x, anchor.y);
  }
  
  
}