class Jelly {
  float x, y;
  float cty;
  
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
    x = map(noise(tx),0,1, 30, 50);
    y = map(noise(ty),0,1, 50, 70);
    c.y = map(noise(cty),0,1,y/5, y/3);
    
    //tx += 0.01;
    //ty += 0.01;
    cty += 0.03; 
  }

  
  void display() {
    
    strokeWeight(1);
    noFill();
  
    //translate(width/2,height/2);
    
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
    curveVertex(a.x, a.y);
    
    curveVertex(-2*y, 0);
    endShape(CLOSE);
    
    angle += 0.08;
    
  }
 
}
