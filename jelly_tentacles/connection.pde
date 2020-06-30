class Connection extends VerletSpring2D {
  Connection(Particle p1, Particle p2, float len, float strength) {
    super(p1,p2,len,strength);
  }

  void display() {
    stroke(51,153,255,50);
    strokeWeight(2);
    line(a.x,a.y,b.x,b.y);
  }
}
