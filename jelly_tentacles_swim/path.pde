class Path {
  
  float x;
  float y;
  
  PVector[] points;
  
  float radius;
  
  Path(float x_, float y_) {
    
   x = x_;
   y = y_; 
   
   radius = 0.01;
   points = new PVector[4];
   points[0] = new PVector(0, -y-(y/8));
   points[1] = new PVector(-x/4, -y);
   points[2] = new PVector(-3*x/5, -y/2);
   points[3] = new PVector(-x, y/4);
  }
  
  PVector getStart() {
    return points[0];
  }
  
  PVector getEnd() {
    return points[3];
  }
  
  void display() {
    noStroke();
    noFill();
    beginShape();
    for(PVector v : points) {
      vertex(v.x, v.y);  
    }
    endShape();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);  
    }
    endShape();
    
  }
  
  
}
