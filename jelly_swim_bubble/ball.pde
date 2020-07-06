class Ball {
  float x;
  float y;
  float xspeed;
  float yspeed;
  float xmin, xmax, ymin, ymax;
  
  float diameter;
  
  Ball(float xmin_, float xmax_, float ymin_, float ymax_) {
    xmin = xmin_;
    xmax = xmax_;
    ymin = ymin_;
    ymax = ymax_;
    x = random(xmin, xmax);
    y = random(ymin, ymax);
    xspeed = random(0.25,0.5);
    yspeed = random(0.25,0.5);
    diameter = random(2,5);

  }
  
  void run() {
    move();
    checkEdges();
    display();
  }
  
  void display() {
    noStroke();
    fill(51,153,255,150);
    ellipse(x,y,diameter,diameter);
  }
  
  void move() {
    x = x + xspeed;
    y = y + yspeed; 
  }
  
  void checkEdges() {
    if (x>xmax || x<xmin) {
      xspeed = xspeed * -1;
    }
    if (y>2*ymax || y<ymin) {
      yspeed = yspeed * -1;
    }
  }
} 
  
  
  
