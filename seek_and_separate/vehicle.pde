class Vehicle {
  
    PVector position;
    PVector velocity;
    PVector acceleration;
    float r;
    float maxforce;
    float maxspeed;
    
    Vehicle(float x, float y) {
      acceleration = new PVector(0,0);
      velocity = new PVector(0,-2);
      position = new PVector(x,y);
      r=6;
      maxspeed = 4;
      maxforce = 0.1;
    }
    
    void update() {
      velocity.add(acceleration);
      velocity.limit(maxspeed);
      position.add(velocity);
      acceleration.mult(0);
      
    }
    
    void applyForce(PVector force) {
      acceleration.add(force);  
    }
    
    //you can do stuff to an array list of this class within the class?!?!
    void applyBehaviors(ArrayList<Vehicle> vehicles) {
      PVector separateForce = separate(vehicles);
      PVector seekForce = seek(new PVector(mouseX, mouseY));
      //weighting the forces
      //can this be done dynamically to be based in the data??
      seekForce.mult(1);
      separateForce.mult(2);
      applyForce(separateForce);
      applyForce(seekForce);
    }
    
    PVector seek(PVector target) {
      PVector desired = PVector.sub(target,position);
      desired.normalize();
      desired.mult(maxspeed);
      
      PVector steer = PVector.sub(desired,velocity);
      steer.limit(maxforce);
      //applyForce(steer);
      return steer;
    }
    
    PVector separate (ArrayList<Vehicle> vehicles) {
      float desiredseparation = r*2;
      PVector sum = new PVector();
      int count = 0;
      for (Vehicle other : vehicles) {
        float d = PVector.dist(position, other.position);
        if ((d > 0) && (d < desiredseparation)) {
          PVector diff = PVector.sub(position, other.position);
          diff.normalize();
          diff.div(d);
          sum.add(diff);
          count++;
        }
      }
      if (count > 0) {
        sum.div(count);
        sum.normalize();
        sum.mult(maxspeed);
        sum.sub(velocity);
        sum.limit(maxforce);
      }
      return sum;
    }
    
    void display() {
      float theta = velocity.heading2D() + PI/2;
      fill(127);
      stroke(0);
      strokeWeight(1);
      push();
      translate(position.x, position.y);
      rotate(theta);
      beginShape();
      vertex(0, -r*2);
      vertex(-r, r*2);
      vertex(r, r*2);
      endShape(CLOSE);
      pop();
    }





}
