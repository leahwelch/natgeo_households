class Chain {

  // Chain properties
  float totalLength;  // How long
  //int numPoints;      // How many points
  float strength;     // Strength of springs
  float radius;       // Radius of ball at tail
  int distance;
  
  int[] ages = {42,38,17/*,14,11,8,7,5,1*/};
  
  color col;
  
  // This list is redundant since we can ask for physics.particles, but in case we have many of these
  // it's a convenient to keep track of our own list
  ArrayList<Particle> particles;

  // Let's keep an extra reference to the tail particle
  // This is just the last particle in the ArrayList
  Particle tail;

  // Some variables for mouse dragging
  PVector offset = new PVector();
  boolean dragged = false;

  // Chain constructor
  Chain(float l, float r, float s) {
    particles = new ArrayList<Particle>();

    totalLength = l;
    radius = r;
    strength = s;

    float len = totalLength / ages.length;

    // Here is the real work, go through and add particles to the chain itself
       
    for(int i=0; i < ages.length + 1; i++) {
      // Make a new particle with an initial starting position
      Particle particle;
      if(i==0) {
        particle=new Particle(width/2,0);
      }
        //particle=new Particle(width/2,distance); //this isn't exactly working right


      // Redundancy, we put the particles both in physics and in our own ArrayList
      physics.addParticle(new Particle(width/2,distance));
      particles.add(new Particle(width/2,distance));

      // Connect the particles with a Spring (except for the head)
      if (i != 0) {
        Particle previous = particles.get(i-1);
        VerletSpring2D spring = new VerletSpring2D(particle,previous,len,strength);
        // Add the spring to the physics world
        physics.addSpring(spring);
      }
    }

    // Keep the top fixed
    Particle head=particles.get(0);
    head.lock();

    // Store reference to the tail
    tail = particles.get(ages.length-1);
    //tail.radius = radius;
  }

  //Trying to figure out how to dynamially update the distance between vertices based on data
  void updateDistance() {
    distance = 0;
    for(int i=0; i < ages.length + 1; i++) { 
      distance += ages[i-1];
    }
  }

  // Check if a point is within the ball at the end of the chain
  // If so, set dragged = true;
  void pull(int contains, int y) {
     
    //float d = dist(x,y,tail.x,tail.y);
    //if (d < radius) { offset.x = tail.x - x;
      offset.y = tail.y - y;
      tail.lock();
      dragged = true;
  }


    //}  // Release the ball
  void release() {
    tail.unlock();
    dragged = false;
  }

  // Update tail position if being dragged
  void updateTail(int x, int y) {
    if (dragged) {
      tail.set(x+offset.x,y+offset.y);
    }
  }

  // Draw the chain
  void display() {
    // Draw line connecting all points
    beginShape();
    stroke(140,200,50);
    strokeWeight(2);
    noFill();
    for (Particle p : particles) {
      //col = round(map(p.dist, 1, 10, 0, 255));
      vertex(p.x,p.y);
    }
    endShape();
    //tail.display();
    
  }
}
