void setup() {
  size(1000,800);
  background(0);
}

void draw () {
  
  stroke(255);
  strokeWeight(2);
  fill(0);
  
  for (int circleX=0; circleX < width; circleX = circleX + 60) {
    for (int circleY=0; circleY < height; circleY = circleY + 60) {
      circle(circleX,circleY,55);
    }
  }
}