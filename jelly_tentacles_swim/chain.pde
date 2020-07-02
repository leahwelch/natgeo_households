class Chain {

  // Chain properties
  float totalLength;  // How long
  int numPoints;      // How many points
  float strength;     // Strength of springs
  float radius;       // Radius of ball at tail
  int x,y;            //position variables
  
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
  Chain(float l, int n, float r, float s, int x_, int y_) {
    particles = new ArrayList<Particle>();

    totalLength = l;
    numPoints = n;
    radius = r;
    strength = s;
    x = x_;
    y = y_;
    
    tx = 0;
    ty = 1000;

    float len = totalLength / numPoints;

    // Here is the real work, go through and add particles to the chain itself
    for(int i=0; i < numPoints; i++) {
      // Make a new particle with an initial starting position
      Particle particle=new Particle(x,i*len+y);

      // Redundancy, we put the particles both in physics and in our own ArrayList
      physics.addParticle(particle);
      particles.add(particle);

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
    tail = particles.get(numPoints-1);
    tail.radius = radius;
  }
   
  // Draw the chain
  void display() {
    // Draw line connecting all points
    //translate(width/2, height/2);
    beginShape();
    stroke(51,153,255,100);
    
    // OMG set this to perlin noise??
    //and set the heads too/make the heads at more specific locations
    tail.set(int(map(noise(tx),0,1, x-10, x+10)), int(map(noise(ty),0,1, y+80,y+130)));
    //x = int(map(noise(tx),0,1, x-10, x+10));
    //y = int(map(noise(ty),0,1, height/2+110, height/2+90));
    
    //strokeWeight(2);
    noFill();
    for (Particle p : particles) {
      vertex(p.x,p.y);
    }
    endShape();
    //tail.display();
  }
}
