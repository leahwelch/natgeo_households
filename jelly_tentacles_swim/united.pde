class United {
  
  //ArrayList<Particle> particles;
  ArrayList<Chain> springs;
  Jelly jelly;
  
  //Movement stuff
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxforce;
  float maxspeed;
  float r;
  
  United() {
    //particles = new ArrayList<Particle>();
    springs = new ArrayList<Chain>();
    jelly = new Jelly(40,60);
    
    for(int i = -30; i < 30; i+=5) {
      springs.add(new Chain(120, 20, 16, 0.2, i, -40)); 
    }
    
    //Movement stuff
    position = new PVector(random(0,width/2),random(0,height/2));
    velocity = new PVector(random(2,5),random(2,5));
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
  

  void display() {
    float theta = velocity.heading() + PI/2;
    push();
    translate(position.x,position.y);  
    rotate(theta);
    for (Chain c : springs) {
      c.display();
    }
    jelly.display();
    jelly.breathe();
    pop();

  }
  
}
