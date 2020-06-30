class United {
  
  ArrayList<Particle> particles;
  ArrayList<Connection> springs;
  Jelly jelly;
  
  United() {
    particles = new ArrayList<Particle>();
    springs = new ArrayList<Connection>();
    jelly = new Jelly(80,120);
    
    int w = 16;
    int h = 25;

    float len = 10;
    float strength = 0.125;

    for(int y=0; y< h; y++) {
      for(int x=0; x < w; x++) {

        if(y == 0) {
          particles.add(new Particle(new Vec2D(x*len, y*len)));
        }
        Particle p = new Particle(new Vec2D(x*len,y*len));
        physics.addParticle(p);
        particles.add(p);

        if (y > 0) {
          Particle above = particles.get(particles.size()-w-1);
          Connection c=new Connection(p,above,len,strength);
          physics.addSpring(c);
          springs.add(c);
        }
      }
    }
    for(Particle p : particles) {
      if(p.y <= 0) {
        p.lock(); 
      }
    }
    

  }

  void display() {
    for (Connection c : springs) {
      push();
      translate(width/4+35,height/2-100);
      c.display();
      pop();
    }
    jelly.display();
    jelly.breathe();

  }
  
   



}
