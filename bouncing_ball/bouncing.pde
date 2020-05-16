Ball[] balls = new Ball[100];

int total = 1;

void setup() {
  size(640,360);
  for (int i=0; i<balls.length; i++) {
    balls[i] = new Ball(i*2);
  }
}

void mousePressed() {
  total = total + 1;
}

void draw() {
  background(255);
  for (int i=0; i<total; i++) {
    balls[i].display();
    balls[i].move();
    balls[i].checkEdges();
  }
}