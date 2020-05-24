class Box {
  Body body;
  
  float w,h;
  
  Box(float x, float y) {
    
    w = random(4,16);
    h = random(4,16);
    
    makeBody(new Vec2(x,y),w,h);

  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(0,100,200);
    fill(100,200,0);
    rectMode(CENTER);
    rect(0,0,w,h);
    popMatrix();
  }
  
  void makeBody(Vec2 center, float tempW, float tempH) {
    //Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    //Create Body
    body = box2d.createBody(bd);
    
    //Create Shape
    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(tempW/2);
    float box2Dh = box2d.scalarPixelsToWorld(tempH/2);
    ps.setAsBox(box2Dw,box2Dh);
    
    //Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps;
    //Parameters that define the physics
    fd.density = 1.0;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    //Attach Shape to Body with Fixture
    body.createFixture(fd); 
  }
  
} 
  
  
  
