class Jelly {
  float x, y;

  PVector a,b;
  
  ArrayList<Chain> springs;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  
  Jelly(float x_, float y_) {
    x = x_;
    y = y_;
    tx = 0;
    ty = 1000;
    
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
    
    springs = new ArrayList<Chain>();
    for(int i = -30; i < 30; i+=5) {
      springs.add(new Chain(120, 20, 16, 0.2, i, -40)); 
    }
    
    //Movement stuff
    position = new PVector(random(0,width/2),random(0,height/2));
    velocity = new PVector(random(2,4),random(2,4));
    acceleration = new PVector(0,0);
    r = 30;
    maxspeed = 4;
    maxforce = 0.1;
    
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
    
    pop();
    
  }
 
}
