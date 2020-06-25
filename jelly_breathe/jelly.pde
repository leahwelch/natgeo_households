class Jelly {
  float x, y;
  float tx, ty;
  
  PVector[] points;
  
  Jelly(float x_, float y_) {
    x = x_;
    y = y_;
    tx = 0;
    ty = 1000;
    
  }
  
  void breathe() {
    x = map(noise(tx),0,1, 70, 90);
    y = map(noise(ty),0,1, 130, 150);
    
    tx += 0.01;
    ty += 0.01;
    
    if (debug) drawVertices(); 
  }

  
  void display() {
    stroke(51,153,255,200);
    strokeWeight(1);
    noFill();
  
    translate(width/2,height/2);
    
    noStroke();
    
    beginShape();
    texture(soft);
    vertex(x, y/2,60,100);
    vertex(-x, y/2,20,100);
    vertex(-2*x, y-y, 0, 50);
    vertex(-x, -y-10, 20, 0);
    vertex(x, -y-10, 60, 0);
    vertex(2*x, y-y, 80, 50);
    endShape(CLOSE);
    
    stroke(51,153,255,100);
    strokeWeight(1);
  
    beginShape();
    curveVertex(4*x, y);
    curveVertex(-x, y/2);
    curveVertex(-2*x, 0);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, 0);
    curveVertex(x, y/2);
    curveVertex(-x, y/2);
    
    curveVertex(-2*y, y-y);
    endShape(CLOSE);
    
    /*beginShape();
    curveVertex(2*x, 0); //control point
    curveVertex(0, -y-(y/8)); //start
    curveVertex(-x, y/2); //end
    curveVertex(0, y/2); //control point
    endShape();
    
    beginShape();
    curveVertex(-2*x, 0);
    curveVertex(0, -y-(y/8));
    curveVertex(x, y/2);
    curveVertex(0, y/2);
    endShape();*/
  }
  
  void drawVertices() {
    //tempx = x;
    //tempy = y;
    push();
    translate(width/2,height/2);
    noStroke();
    fill(255,0,0);
    ellipse(-x, y/2,10,10);
    //ellipse(-x/4, -y,10,10);
    //ellipse(-3*x/5, -y/2,10,10);
    //ellipse(x/4, -y,10,10);
    //ellipse(3*x/5, -y/2,10,10);
    ellipse(-2*x, 0,10,10);
    ellipse(-x, -y,10,10);
    ellipse(x, -y,10,10);
    ellipse(0, -y-(y/8),10,10);
    ellipse(2*x, 0,10,10);
    ellipse(x, y/2,10,10);
    ellipse(-x, y/2,10,10);
    pop();
 }
}
