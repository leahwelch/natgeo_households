class Lollipop {
  Body body;
  
  float w,h;
  float r;
  
  Lollipop(float x, float y) {
    
    w = 4;
    h = 24;
    r = 8;
    
    makeBody(new Vec2(x,y));
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    rectMode(CENTER);
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(0);
    fill(127,0,0);
    rect(0,0,w,h);
    ellipse(0,-h/2, r*2, r*2);
    popMatrix();
  }
    
  void makeBody(Vec2 center) {
    //Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    //Create Body
    body = box2d.createBody(bd);
    
    //Create Circle Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    Vec2 offset = new Vec2(0, -h/2);
    offset = box2d.vectorPixelsToWorld(offset);
    cs.m_p.set(offset.x, offset.y);
    
    //Create Rectangle Shape
    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(w/2);
    float box2Dh = box2d.scalarPixelsToWorld(h/2);
    ps.setAsBox(box2Dw,box2Dh);
    
    //Attach Each Shape to Body with Fixture
    body.createFixture(ps, 1.0);
    body.createFixture(cs, 1.0);
  }
  
} 
  
  
  
