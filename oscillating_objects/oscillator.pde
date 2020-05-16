class Oscillator {
  PVector angle;
  PVector velocity;
  PVector amplitude;
  float diameter;
  float fillColor;
  
  Oscillator(float tempD, float tempC) {
    angle = new PVector();
    velocity = new PVector(random(-0.05,0.05),random(-0.05,0.05));
    amplitude = new PVector(random(20,width/2),random(20,height/2));
    diameter=tempD;
    fillColor = tempC;
  }
  
  void oscillate() {
    angle.add(velocity);
  }
  
  void display() {
    float x = sin(angle.x)*amplitude.x;
    float y = sin(angle.y)*amplitude.y;
    
    pushMatrix();
    translate(width/2,height/2);
    stroke(255);
    strokeWeight(2);
    fill(fillColor * 3 % 255, fillColor * 5 % 255,
      fillColor * 7 % 255);
    line(0,0,x,y);
    ellipse(x,y,diameter,diameter);
    popMatrix();
  }
  
}