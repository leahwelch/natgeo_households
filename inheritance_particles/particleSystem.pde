class ParticleSystem {
 
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(PVector v) {
    particles = new ArrayList<Particle>();
    origin = v.copy();
  }
  
  void generate() {
    for(int i = particles.size()-1; i >= 0; i--) {
      Particle p = particles.get(i);
      p.run();
      
      if(p.isDead()) {
        particles.remove(i);
      }
    }
  }
  
  void addParticle() {
    //Polymorphism!!
    float r = random(1);
    if(r < 0.4) { 
      particles.add(new Square(origin));
    } else {
      particles.add(new Particle(origin));
    }
  }
  
}