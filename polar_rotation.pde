float r = 150;
float a = 0;
float aVelocity = 0.0;
float aAcceleration = 0.001;

void setup() {
  size(640,360);
}

void draw() {
  background(0);
  
  translate(width/2, height/2);
  float x = r * cos(a);
  float y = r * sin(a);
  fill(255);
  stroke(255);
  line(0,0,x,y);
  ellipse(x,y,20,20);
  
  a += aVelocity;
  aVelocity += aAcceleration;
  aVelocity = constrain(aVelocity,0,0.1);
}