class Walker {
  
  float x,y;
  float tx,ty;
  
  Walker() {
    tx = 0;
    tx = 10000;
  }
  
  void render() {
    stroke(0);
    point(x,y);
  }
  
  void step() {
    x = map(noise(tx),0,1,0,width);
    y = map(noise(ty),0,1,0,height);
    
    tx += 0.01;
    ty += 0.01;
  }  
}