class Jelly {
  float x, y;
  float tx, ty, cty;
  
  PVector a,b,c;
  
  
  Jelly(float x_, float y_) {
    x = x_;
    y = y_;
    tx = 0;
    ty = 1000;
    cty = 1000;
    
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
    c = new PVector(x/8,y/4);
    
  }
  
  void run() {
  
    breathe();
    display();
  }
  
  void breathe() {
    x = map(noise(tx),0,1, 70, 90);
    y = map(noise(ty),0,1, 130, 150);
    c.y = map(noise(cty),0,1,y/5, y/3);
    
    tx += 0.01;
    ty += 0.01;
    cty += 0.03; 
  }

  
  void display() {
    //oscillations - not quite working right
    //a.x = map(sin(angle),-1,1,a.x,-amplitude);
    //a.y = amplitude * sin(angle);
    
    //b.x = map(sin(angle),-1,1,b.x,3*amplitude/2);
    //b.y = amplitude * sin(angle);
    
    strokeWeight(1);
    noFill();
  
    translate(width/2,height/2);
    
    noStroke();
    
    beginShape();
    texture(soft);
    vertex(x,y/2,60,100);
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
    curveVertex(a.x, a.y);
    curveVertex(-2*x, 0);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, 0);
    curveVertex(b.x, b.y);
    //curveVertex(c.x, c.y); //extra point at bottom, looks off
    curveVertex(a.x, a.y);
    
    curveVertex(-2*y, 0);
    endShape(CLOSE);
    
    /*stroke(51,153,255,150);
    strokeWeight(1);
    
    beginShape();
    curveVertex(-x, y/2); //control point
    curveVertex(-3*x/2, y/3+8); //start
    curveVertex(-x/2, -2*y/3); 
    curveVertex(x/2, -2*y/3);
    curveVertex(3*x/2, y/3+8); //end
    curveVertex(x, 0); //control point
    endShape();
    
    beginShape();
    curveVertex(2*x, 0); //control point
    curveVertex(0, -3*y/4-6); //start
    curveVertex(-x/2, y/2+6); //end
    curveVertex(0, y/2); //control point
    endShape();
    
    beginShape();
    curveVertex(-2*x, 0);
    curveVertex(0, -3*y/4-6);
    curveVertex(x/2, y/2+6);
    curveVertex(0, y/2);
    endShape();
    
    beginShape();
    curveVertex(-2*x, 0); //control point
    curveVertex(-2*x/3-5, -y/2); //start
    curveVertex(-x/4, y/2+6); //end
    curveVertex(0, y/2); //control point
    endShape();
    
    beginShape();
    curveVertex(2*x, 0); //control point
    curveVertex(2*x/3+5, -y/2); //start
    curveVertex(x/4, y/2+6); //end
    curveVertex(0, y/2); //control point
    endShape();*/
    
    angle += 0.08;
    
  }
 
}
