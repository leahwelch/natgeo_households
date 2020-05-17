Mover bob;
Spring spring;

void setup() {
  size(640,360);
  spring = new Spring(width/2,10);
  bob = new Mover(width/2,250);
}

void draw() {
  background(255);

  spring.connect(bob);
  spring.display(bob);

  //bob.applyForce(force);
  bob.update();
  bob.display();

}