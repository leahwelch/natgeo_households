class Ball {
  float x;
  float y;
  float xspeed;
  float yspeed;
  
  float diameter;
  
  Ball(float tempD) {
    x = random(width);
    y = random(height);
    xspeed = random(2,5);
    yspeed = random(2,5);
    diameter = tempD;
  }
  
  void display() {
    stroke(0);
    fill(127,0,0,100);
    ellipse(x,y,diameter,diameter);
  }
  
  void move() {
    x = x + xspeed;
    y = y + yspeed; 
  }
  
  void checkEdges() {
    if (x>width || x<0) {
      xspeed = xspeed * -1;
    }
    if (y>height || y<0) {
      yspeed = yspeed * -1;
    }
  }
} 
  
  
  