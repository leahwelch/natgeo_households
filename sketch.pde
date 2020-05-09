int circleX;
int circleY;

void setup() {
  size(1000,800);
  circleX = 0;
  circleY = 0;
  background(0,0,0);
}

void draw () {
  
  stroke(255);
  strokeWeight(2);
  fill(0);
  
  circle(circleX,circleY,55);
  circleX = circleX + 60;

  if (circleX>width+50) {
    circleX = 0;
    circleY = circleY + 60;
  }
}