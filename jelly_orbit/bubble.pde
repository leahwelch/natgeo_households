class Bubble {
  float x;
  float y;
  float xspeed;
  float yspeed;
  float xmin, xmax, ymin, ymax;
  
  float diameter;
  
  Bubble(float xmin_, float xmax_, float ymin_, float ymax_) {
    xmin = xmin_;
    xmax = xmax_;
    ymin = ymin_;
    ymax = ymax_;
    x = random(xmin, xmax);
    y = random(ymin, ymax);
    xspeed = random(1,2);
    yspeed = random(1,2);
    diameter = random(2,5);

  }
  
  void run() {
    move();
    checkEdges();
    display();
  }
  
  void display() {
    noStroke();
    fill(255,100);
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
  
  
  
