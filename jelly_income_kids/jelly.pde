class Jelly {
  final int numKids;
  final int income;
  final int famType;
  
  PImage soft;
  color col;
  
  float x, y;
  float mass;
  PVector a,b;
  
  ArrayList<Chain> springs;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  
  Jelly(int numKids, int income, int famType) {
    this.numKids = numKids;
    this.income = income;
    this.famType = famType;
    
    x = 40.0;
    y = 60.0;
    tx = 0;
    ty = 1000;
    
    a = new PVector(-x, y/2);
    b = new PVector(x, y/2);
    
    //soft = softs[numKids];
    if(famType == 1) {
      soft = blues[numKids]; 
      col = color(51,153,255);
    } else if(famType == 2) {
      soft = reds[numKids];
      col = color(140,43,54);
    } else {
      soft = greens[numKids];
      col = color(125,178,155);
    }
    
    springs = new ArrayList<Chain>();
    for(int i = -40; i < 40; i+=6) {
      springs.add(new Chain(random(100,200), 40, 16, 0.2, i, -20, col)); 
    }
    
    int q1, q2, q3, q4;
    float ypos;
    float xspeed;
    
    q1 = 35500;
    q2 = 68150;
    q3 = 99400;
    q4 = 470000;
    
    if(income <= q1) {
      ypos = height - 70; 
    } else if (income > q1 && income <= q2) {
      ypos = 3*height/4 - 70;
    } else if (income > q2 && income <= q3) {
      ypos = height/2 - 70;
    } else {
      ypos = height/4 - 70;
    }
    
    xspeed = 2*(log((income/100000)+1) + 0.5);
    
    //Movement stuff
    position = new PVector(random(width), ypos);
    velocity = new PVector(xspeed,0);
    acceleration = new PVector(0,0);
    r = 70;
    maxspeed = 4;
    maxforce = 0.1;
    mass = 10;
    
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
    x = map(noise(tx),0,1, 30, 50);
    y = map(noise(ty),0,1, 50, 70);
 
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
    
    stroke(col,150);
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
    
    pop();
    
  }
 
}
