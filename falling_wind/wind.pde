Ball[] balls;

void setup() {
  size(640,360);
  balls = new Ball[5];
  for(int i = 0; i<balls.length; i++) {
    balls[i] = new Ball();
  }
}

void draw() {
  background(255);
  
  for(Ball b : balls) {
  
    PVector gravity = new PVector(0,0.3);
    gravity.mult(b.mass);
    b.applyForce(gravity);
    
    PVector wind = new PVector(0.4,0);
    b.applyForce(wind);
    
    
    b.display();
    b.update();
    b.checkEdges();
  }
}