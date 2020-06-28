Flock[] flocks = new Flock[4];
color[] cols = new color[4];

PImage[] softs = new PImage[4];

void setup() {
  size(800,600, P2D);
  
  cols[0] = color(255);
  cols[1] = color(249,247,192);
  cols[2] = color(249,199,222);
  cols[3] = color(204, 252, 200);
  
  for (int i = 0; i < softs.length; i ++ ) {
    softs[i] = loadImage( "soft_" + (i+1) + ".png" );
  }
  
  for(int i = 0; i<flocks.length; i++) {
    flocks[i] = new Flock();
    for (int j = 0; j < 20; j++) {
      flocks[i].addJelly(new Jelly(width/2,height/2, 10, 15, cols[i], softs[i]));
    }
  }
}

void draw() {
  background(2,1,32);
  for(int i = 0; i<flocks.length; i++) {
    flocks[i].run();  
  }
  
  // Instructions
  /*fill(0);
  text("Drag the mouse to generate new jellies.",10,height-16);*/
}

// Add a new boid into the System
/*void mouseDragged() {
  flock.addJelly(new Jelly(mouseX,mouseY, 10, 15));
}*/
