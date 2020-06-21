class Jelly {
  float x;
  float y;
  
  Jelly() {
    x = 80;
    y = 140;
  }
  
  void vibrate() {
    y = constrain((y + random(-1,1)), 130, 150);
    x = constrain((x + random(-1,1)), 70, 90);
  }
  
  void display() {
    stroke(255,50);
    strokeWeight(2);
    noFill();
  
    translate(width/2,height/2);
    //curveTightness(-2.5);
  
    beginShape();
    curveVertex(x, y);
    curveVertex(-x, y);
    curveVertex(-2*x, y-y);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, y-y);
    curveVertex(x, y);
    curveVertex(-x, y);
    
    curveVertex(-140, 0);
    endShape(CLOSE); 
  }
}
