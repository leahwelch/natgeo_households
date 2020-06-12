Path path;
ArrayList<Vehicle> cars;

void setup() {
  size(800,600);
  
  path = new Path();
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

void mousePressed() {
  cars.add(new Vehicle(new PVector(mouseX,mouseY), random(1,5), random(0.01, 0.09)));  
}
