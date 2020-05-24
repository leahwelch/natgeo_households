class Particle {
  Body body;
 
  float r;
  
  Particle(float x, float y) {
    r = 10;
    
    makeBody(x,y,r);
  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(47,9,9);
    fill(255,182,193);
    ellipse(0,0,r*2,r*2);
    line(0,0,r,0);
    popMatrix();
  }
  
  void makeBody(float x, float y, float r) {
    //Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    
    //Create Body
    body = box2d.createBody(bd);
    
    //Create Shape
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    //float box2Dh = box2d.scalarPixelsToWorld(h/2);
    //ps.setAsBox(box2Dw,box2Dh);
    
    //Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = cs;
    //Parameters that define the physics
    fd.density = 1.0;
    fd.friction = 0.3;
    fd.restitution = 0.5;
    
    //Attach Shape to Body with Fixture
    body.createFixture(fd);
    
    body.setLinearVelocity(new Vec2(random(-10f,10f),random(5f,10f)));
    body.setAngularVelocity(random(-10,10));
  }
  
} 
  
  
  
