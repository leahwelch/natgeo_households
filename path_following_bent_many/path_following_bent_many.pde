Path path;
ArrayList<Vehicle> cars;

void setup() {
  size(800,600);
  
  newPath();
  
  cars = new ArrayList();
}

void draw() {
  background(255);
  path.display();
  
  for (Vehicle v: cars) {
    v.follow(path);
    v.run();
    
    v.borders(path);
  }
}

void newPath() {
  // A path is a series of connected points
  // A more sophisticated path might be a curve
  path = new Path();
  path.addPoint(-20, height/2);
  path.addPoint(random(0, width/2), random(0, height));
  path.addPoint(random(width/2, width), random(0, height));
  path.addPoint(width+20, height/2);
}

void mousePressed() {
  newPath();
  cars.add(new Vehicle(new PVector(mouseX,mouseY), random(1,5), random(0.01, 0.09)));  
}
