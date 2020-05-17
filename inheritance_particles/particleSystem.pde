class ParticleSystem {
 
  ArrayList<Particle> particles;
  PVector origin;
  
  ParticleSystem(int num, PVector v) {
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
    particles.add(new Square(origin));
  }
  
}