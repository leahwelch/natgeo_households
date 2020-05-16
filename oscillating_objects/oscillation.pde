Oscillator[] oscillators = new Oscillator[10];


void setup() {
  size(640,360);
  
  for (int i = 0; i<oscillators.length; i++) {
    oscillators[i] = new Oscillator(((i+3)*2),i+random(0,100));
  }
  
  background(0);
}

void draw() {
  background(0);
  
  for (int i = 0; i<oscillators.length; i++) {
    oscillators[i].oscillate();
    oscillators[i].display();
  }
  
  stroke(255);
  fill(255,0,0);
  ellipse(width/2,height/2,20,20);
   
}