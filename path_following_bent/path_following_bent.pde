Path path;
Vehicle v1;
Vehicle v2;

void setup() {
  size(800,600);
  
  path = new Path();
  
  v1 = new Vehicle(new PVector(0, height/2), 2, 0.02);
  v2 = new Vehicle(new PVector(0, height/2), 3, 0.05);
}

void draw() {
  background(255);
  path.display();
  
  v1.follow(path);
  v2.follow(path);
  v1.run();
  v2.run();
  
  v1.borders(path);
  v2.borders(path);
}
