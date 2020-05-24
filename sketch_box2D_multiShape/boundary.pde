class Boundary {
  Body body;
  
  float x;
  float y;
  float w;
  float h;
  
  Body b;
  
  Boundary(float tempx, float tempy, float tempw, float temph, float a) {
    x = tempx;
    y = tempy;
    w = tempw;
    h = temph;
    
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle = a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    
    body = box2d.createBody(bd);
    
    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w/2);
    float box2Dh = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2Dw,box2Dh);
    
    body.createFixture(ps,1);
  }
  
  void display() { 
    noFill();
    stroke(0);
    strokeWeight(1);
    rectMode(CENTER);
    
    float a = body.getAngle();
    
    pushMatrix();
    translate(x,y);
    rotate(-a);
    fill(0);
    stroke(0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
}
