Particle p;
Particle p2;

void setup() {
  size(1000,800);
  p = new Particle(200, 200, 200);
  p2 = new Particle(300, 300, 100);
}

void draw() {
  background(0);

  if(p.overlaps(p2)) {
    background(0,255,0);
  }
  
  p2.x = mouseX;
  p2.y = mouseY;
  
  p.display();
  p2.display();
}