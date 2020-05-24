class Surface {
  Body body;
  ArrayList<Vec2> surface;
  
  Surface() {
    
    surface = new ArrayList<Vec2>();
    surface.add(new Vec2(0, height/2));
    surface.add(new Vec2(width/4+50, height/3+100));
    surface.add(new Vec2(width/2, height/2-50));
    surface.add(new Vec2(width-100, height/4+150));
    surface.add(new Vec2(width, height/2));
    
    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i)); 
    }
    
    chain.createChain(vertices, vertices.length);
    
    BodyDef bd = new BodyDef();
    body = box2d.world.createBody(bd);
    bd.type = BodyType.STATIC;
    body.createFixture(chain,1);
    //bd.position.set(box2d.coordPixelsToWorld(x,y));
      
  }
  
  void display() {
    fill(0);
    stroke(0);
    beginShape();
    for (Vec2 v: surface) {
      vertex(v.x, v.y);
    }
    vertex(width,height);
    vertex(0,height);
    endShape(CLOSE);
  }
  
}
