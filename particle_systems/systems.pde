ArrayList<ParticleSystem> systems;

void setup() {
  size(640,450);
  systems = new ArrayList<ParticleSystem>();
}

void draw() {
  background(255);
  
  for (ParticleSystem ps: systems) {
    ps.generate();
    ps.addParticle();
  }
  
}

void mousePressed() {
  systems.add(new ParticleSystem(1, new PVector(mouseX, mouseY)));
}