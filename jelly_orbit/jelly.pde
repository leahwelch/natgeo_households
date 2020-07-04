class Jelly {
  float x, y;
  float mass;
  PVector a,b;
  
  ArrayList<Chain> springs;
  ArrayList<Chain> longs;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  Bubble bubble;
  
  
  Jelly(float x_, float y_) {
    x = x_;
    y = y_;
    tx = 0;
    ty = 1000;
    
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
    
    springs = new ArrayList<Chain>();
    longs = new ArrayList<Chain>();
    for(int i = -40; i < 40; i+=6) {
      springs.add(new Chain(random(100,200), 40, 16, 0.2, i, -40, int(random(50,125)), int(random(1,3)))); 
    }
    
    //Movement stuff
    position = new PVector(random(0,width/2),random(0,height/2));
    velocity = new PVector(2,1);
    acceleration = new PVector(0,0);
    r = 30;
    maxspeed = 4;
    maxforce = 0.1;
    mass = 10;
    
    bubble = new Bubble(-40, 40, -60, 15);
    
  }
  
  void applyForce(PVector force) {
    PVector f = PVector.div(force,mass);
    acceleration.add(f);
  }
  
  void update() {
    
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void checkEdges() {
    if (position.x>width || position.x<0) {
      velocity.x = velocity.x * -1;
    }
    if (position.y>height || position.y<0) {
      velocity.y = velocity.y * -1;
    }
  }
  
  void borders() {
    if (position.x < -r) position.x = width;
    if (position.y < -r) position.y = height;
    if (position.x > width) position.x = -r;
    if (position.y > height) position.y = -r;
  }
  
  void run() {
  
    breathe();
    display();
  }
  
  void breathe() {
    x = map(noise(tx),0,1, 25, 55);
    y = map(noise(ty),0,1, 45, 75);
    //c.y = map(noise(cty),0,1,y/5, y/3);
    
    //tx += 0.01;
    //ty += 0.01;
    //cty += 0.03; 
  }

  
  void display() {
    
    float theta = velocity.heading() + PI/2;
    push();
    translate(position.x,position.y);  
    rotate(theta);
    for (Chain c : springs) {
      c.display();
    }
    
    strokeWeight(1);
    noFill();
  
    //translate(width/2,height/2);
    
    
    
    stroke(51,153,255,100);
    //fill(51,153,255,50);
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
    
    bubble.run();
    
    pop();
    
  }
 
}
