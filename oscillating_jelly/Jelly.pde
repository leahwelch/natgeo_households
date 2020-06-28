class Jelly {
  float x, y;
  PVector a,b,c,d,e,f;
  PVector control1, control2;
  
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;

  Jelly(float x_, float y_) {
    x = x_;
    y = y_;
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
    c = new PVector(2*x, 0);
    d = new PVector(-2*x, 0);
    e = new PVector(-x,-y);
    f = new PVector(x,-y);
    control1 = new PVector(x, -2*y);
    control2 = new PVector(4*x, y);
    
    position = new PVector(random(0,width),random(0,height));
    velocity = new PVector(random(2,5),random(2,5));
    acceleration = new PVector(0,0);
    r = 100;
    maxspeed = 4;
    maxforce = 0.1;
  }
  
   void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0); 
    
    angle += velocity.mag()/50;
  }
  
   void checkEdges() {
    if (position.x>width || position.x<0) {
      velocity.x = velocity.x * -1;
    }
    if (position.y>height || position.y<0) {
      velocity.y = velocity.y * -1;
    }
  }
  
  
  void display() {
    a.x = map(sin(angle),-1,1,a.x,-amplitude);
    a.y = amplitude * sin(angle)+10;
    
    b.x = map(sin(angle),-1,1,b.x,3*amplitude/2);
    b.y = amplitude * sin(angle)+10;
    
    float theta = velocity.heading() + PI/2;
    
    strokeWeight(1);
    stroke(51,153,255);
    noFill();
  
    push();
    translate(position.x,position.y);  
    rotate(theta);
    
    beginShape();
    curveVertex(control2.x, control2.y);
    curveVertex(a.x,a.y);
    curveVertex(d.x,d.y);
    curveVertex(e.x, e.y);
    curveVertex(f.x, f.y);
    curveVertex(c.x, c.y);
    curveVertex(b.x, b.y);
    curveVertex(x/8,y);
    curveVertex(a.x,a.y);
    
    curveVertex(-2*y, 0);
    endShape(CLOSE);
    
    pop();
    
    angle += 0.08;
    
    if (debug) drawVertices();
  }
  
  void drawVertices() {
    //tempx = x;
    //tempy = y;
    noStroke();
    fill(255,0,0);
    ellipse(a.x,a.y,10,10);
    ellipse(d.x,d.y,10,10);
    /*ellipse(-x, -y,10,10);
    ellipse(x, -y,10,10);
    ellipse(0, -y-(y/8),10,10);*/
    ellipse(c.x, c.y,10,10);
    ellipse(b.x,b.y,10,10);
    //ellipse(-x, y/2,10,10);
 }
  
  
}
