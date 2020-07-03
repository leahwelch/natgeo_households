class Jelly {
  float x, y;
  color col;
  PImage soft;
  
  ArrayList<Chain> springs;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  
  Jelly(float x_, float y_, color col_, PImage soft_) {
    x = x_;
    y = y_;
    
    col = col_;
    soft = soft_;
    tx = 0;
    ty = 1000;
    
    springs = new ArrayList<Chain>();
    for(int i = -30; i < 30; i+=5) {
      springs.add(new Chain(120, 20, 16, 0.2, i, -40, col)); 
    }
    
    //Movement stuff
    position = new PVector(random(0,width),random(0,height));
    velocity = new PVector(random(2,4),random(2,4));
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
  }
  
  void applyForce(PVector force) {
    acceleration.add(force);  
    }
    
  void applyBehaviors(Jelly[] jellies) {
    PVector separateForce = separate(jellies);
    //PVector seekForce = seek(new PVector(mouseX, mouseY));
    //weighting the forces
    //can this be done dynamically to be based in the data??
    //seekForce.mult(1);
    //separateForce.mult(2);
    applyForce(separateForce);
    //applyForce(seekForce);
   }
   
   PVector separate (Jelly[] jellies) {
      float desiredseparation = r*2;
      PVector sum = new PVector();
      int count = 0;
      for (Jelly other : jellies) {
        float d = PVector.dist(position, other.position);
        if ((d > 0) && (d < desiredseparation)) {
          PVector diff = PVector.sub(position, other.position);
          diff.normalize();
          diff.div(d);
          sum.add(diff);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        sum.normalize();
        sum.mult(maxspeed);
        sum.sub(velocity);
        sum.limit(maxforce);
      }
      return sum;
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
  }

  
  void display() {
    
    float theta = velocity.heading() + PI/2;
    push();
    translate(position.x,position.y);  
    rotate(theta);
    for (Chain c : springs) {
      c.display();
    }
    
    noFill();
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
    
    stroke(col,100);
    strokeWeight(1);
  
    beginShape();
    curveVertex(4*x, y);
    curveVertex(-x, y/2);
    curveVertex(-2*x, 0);
    curveVertex(-x, -y);
    curveVertex(x, -y);
    curveVertex(2*x, 0);
    curveVertex(x, y/2);
    curveVertex(-x, y/2);
    curveVertex(-2*y, y-y);
    endShape(CLOSE);
    
    pop();
    
  }
 
}
