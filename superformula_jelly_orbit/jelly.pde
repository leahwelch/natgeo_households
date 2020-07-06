class Jelly {
  
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
  
  Jelly() {
    tx = 0;
    ty = 1000;
    
    springs = new ArrayList<Chain>();
    for(int i = -40; i < 40; i+=8) {
      springs.add(new Chain(random(150,250), 40, 16, 0.2, i, -20, int(random(50,125)), int(random(1,3)))); 
    }
    
    //Movement stuff
    position = new PVector(random(0,width/2),random(0,height/2));
    velocity = new PVector(2,2);
    acceleration = new PVector(0,0);
    r = 30;
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
  
  void borders() {
    if (position.x < -r) position.x = width;
    if (position.y < -r) position.y = height;
    if (position.x > width) position.x = -r;
    if (position.y > height) position.y = -r;
  }
  
  void display() {
    
    noFill();
    noStroke();
    
    //translate(width/2, height/2);
    //rotate(-PI / 2);
    
    float angle = velocity.heading() ;//+ PI/2;
    //rotate(-PI / 2);

    push();
    translate(position.x,position.y);
    scale(0.8);
    
    rotate(angle);
    
    beginShape();
    texture(soft);
    for (float theta = 0; theta <= 2 * PI; theta += 0.01) {
      float rad = r(theta,
        map(noise(t1),0,1, 1, 1.25), //a
        //3, //b
        5, //b
        4, //m1
        6, //m2
        //3, //n1
        4, //n1
        sin(t) + 14.0/4.0, //n2
        1.5 //n3
      );
      float x = rad * cos(theta) * 80;
      float y = rad * sin(theta) * 50;
      float xtex = map(x, -78.0, 40.0, 0.0, 80.0);//* cos(theta) ;
      float ytex = map(y, -87.0, 150.0, 0.0, 100.0); //* sin(theta) ;
      //xtex = xtex + cos(t) * 8.0;
      //ytex = ytex + sin(t);
      vertex(x,y, xtex, ytex);
    }
    
    endShape(CLOSE);
    
    stroke(51,153,255,50);
  
    beginShape();
    for (float theta = 0; theta <= 2 * PI; theta += 0.01) {
      float rad = r(theta,
        map(noise(t1),0,1, 1, 1.25), //a
        5, //b
        4, //m1
        6, //m2
        4, //n1
        sin(t) + 14.0/4.0, //n2
        1.5 //n3
      );
      float x = rad * cos(theta) * 80;
      float y = rad * sin(theta) * 50;
      curveVertex(x,y);
    }
    
    endShape(CLOSE);
    
    for (Chain c : springs) {
      c.display();
    }
    
    pop();
  
  }

}
