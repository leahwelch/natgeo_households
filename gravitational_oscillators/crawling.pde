Mover[] movers = new Mover[20];
Attractor a;

void setup() {
  size(640,360);
  for (int i = 0; i < movers.length; i++) {
    movers[i] = new Mover();
  }
  a = new Attractor();
}

void draw() {
  background(255);
  
  for (int i = 0; i < movers.length; i++) {
    PVector force = a.attract(movers[i]);
    movers[i].applyForce(force);
    movers[i].update();
    movers[i].display();
  }
  
  //a.drag();
  //a.hover(mouseX,mouseY);
  
  a.display();
  
}