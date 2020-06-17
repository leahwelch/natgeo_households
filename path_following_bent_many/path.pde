class Path {
  ArrayList<PVector> points;
  
  float radius;
  
  //PVector start;
  //PVector end;
  
  Path() {
    
   radius = 20;
   //start = new PVector(0, height/3);
   //end = new PVector(width, 2*height/3);
   points = new ArrayList();
  }
  
  void addPoint(float x, float y) {
    PVector point = new PVector(x,y);
    points.add(point);
  }
  
  PVector getStart() {
    return points.get(0);
  }
  
  PVector getEnd() {
    return points.get(points.size()-1);
  }
  
  void display() {
    strokeWeight(radius*2);
    stroke(175);
    strokeWeight(radius*2);
    noFill();
    beginShape();
    for(PVector v : points) {
      vertex(v.x, v.y);  
    }
    endShape();
    stroke(0);
    strokeWeight(1);
    noFill();
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);  
    }
    endShape();
    
  }
  
  
}
