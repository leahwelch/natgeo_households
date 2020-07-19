class Comparison {
  
  final int famSize;
  final int income;
  int totalInc;
  int opacity;
  
  
  Comparison(int famSize, int income) {
    this.famSize = famSize;
    this.income = income;
    
    opacity = int(map(income, 0, 364000, 50, 255));
  
  }
  
  void display() {
    push();
    rotate(PI/famSize);
    noStroke();
    fill(0,0,255,opacity);
    beginShape();
      for (float theta = 0; theta <= 2* PI; theta += 0.01) {
        float rad = r(theta,
          1, //a
          1, //b
          
          famSize, //m1
          4.5, //n1
          map(cos(t), 0, 1, 8, 10), //n2
          map(sin(t), 0, 1, 8, 10) //n3
          //8,
          //8
        );
        float x = rad * cos(theta) * 60;
        float y = rad * sin(theta) * 60;
        curveVertex(x,y);
      }
      endShape(CLOSE);
      pop();
      
  }
  
}
