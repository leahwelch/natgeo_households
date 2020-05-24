class Trapezoid {
  Body body;
  
  float w,h;
  
  Trapezoid(float x, float y) {

    
    makeBody(new Vec2(x,y));

  }
  
  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();
    
    Fixture f = body.getFixtureList();
    PolygonShape ps = (PolygonShape) f.getShape();
    
    pushMatrix();
    translate(pos.x,pos.y);
    rotate(-a);
    stroke(0,100,200);
    fill(100,200,0);
    beginShape();
      for (int i = 0; i < ps.getVertexCount(); i++) {
        Vec2 v = box2d.vectorWorldToPixels(ps.getVertex(i)); 
        vertex(v.x, v.y);
      }
    endShape(CLOSE);
    popMatrix();
  }
  
  void makeBody(Vec2 center) {
    //Define Body
    Vec2[] vertices = new Vec2[4];
    vertices[0] = box2d.vectorPixelsToWorld(new Vec2(0,15));
    vertices[1] = box2d.vectorPixelsToWorld(new Vec2(10,10));
    vertices[2] = box2d.vectorPixelsToWorld(new Vec2(20,-15));
    vertices[3] = box2d.vectorPixelsToWorld(new Vec2(-20,0));
    
    //Create Shape
    PolygonShape ps = new PolygonShape();
    ps.set(vertices, vertices.length);
    
    //Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    
    //Create Body
    body = box2d.createBody(bd);
    
    //Attach Shape to Body with Fixture
    body.createFixture(ps,1.0);
    
    body.setLinearVelocity(new Vec2(random(-5,5), random(2,5)));
    body.setAngularVelocity(random(-5,5));
  }
  
} 
  
  
  
