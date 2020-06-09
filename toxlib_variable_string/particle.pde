class Particle extends VerletParticle2D {
  
  float dist;
  
  Particle(float x, float y, float d) {
    super(x,y);
    dist = d;
  }

  // All we're doing really is adding a display() function to a VerletParticle
  void display() {
    fill(127);
    stroke(0);
    strokeWeight(2);
    ellipse(x,y,10,10);
  }
}
