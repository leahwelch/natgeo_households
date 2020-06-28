class Flock {
  ArrayList<Jelly> jellies; // An ArrayList for all the boids

  Flock() {
    jellies = new ArrayList<Jelly>(); // Initialize the ArrayList
  }

  void run() {
    for (Jelly j : jellies) {
      j.run(jellies);  // Passing the entire list of boids to each boid individually
    }
  }

  void addJelly(Jelly j) {
    jellies.add(j);
  }

}
