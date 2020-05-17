class Oscillator {
  float theta;
  float amplitude;
  
  Oscillator(float r) {
    theta = 0;
    amplitude = r;
  }
  
  void update(float thetaVel) {
    theta += thetaVel;
  }
  
  void display(PVector position) {
    float x = map(cos(theta),-1,1,0,amplitude);
    
    stroke(0);
    fill(50);
    line(0,0,x,0);
    ellipse(x,0,8,8);
  }
}