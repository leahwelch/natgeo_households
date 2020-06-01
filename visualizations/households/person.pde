class Person {
  float x,y;
  float diameter;
  
  Person(float x_, float y_, float diameter_) {
    x = x_;
    y = y_;
    diameter = diameter_;
  }
  
  void display() {
    stroke(0);
    fill(255);
    ellipse(x,y,diameter,diameter);
  }
  
}
