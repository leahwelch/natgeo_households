class Square extends Particle{
  
  float theta;
  
  Square(PVector l) {
    super(l);
    theta = 0.0;
  }
  
  void update() {
    super.update();
    float theta_vel = (velocity.x * velocity.mag()) / 10.0f;
    theta += theta_vel;
    
  }
  
  void display() {
    pushMatrix();
    translate(location.x, location.y);
    rotate(theta);
    stroke(0);
    fill(0,100,255,100);
    rectMode(CENTER);
    rect(0, 0, 20,20);
    popMatrix();  
    }
}