class Distribution {
  
  final int famSize;
  final int income;
  final int[] incomes;
  
  ArrayList<Float> incomeDist = new ArrayList();
  ArrayList<Integer> opacities = new ArrayList();
  
  float income_;

  Distribution(int famSize, int income, int[] incomes) {
    this.famSize = famSize;
    this.income = income;
    this.incomes = incomes;
    
    printArray(incomes);
    
    income_ = float(income);
    
    for(int i = 0; i < incomes.length; i++) { 
      incomeDist.add(incomes[i]/income_);
    }
    for(int i = 0; i < famSize; i++) {
      opacities.add(int(map(incomeDist.get(i), 0, 1, 0, 255)));  
    }
  }
  
  void display() {
    stroke(255,0,0);
    for(int i = 0; i < famSize; i++){
      fill(255,0,0,opacities.get(i));
      //fill(255);
      beginShape();
        for (float theta = i*(2* PI)/famSize; theta <= (i+1)*(2* PI)/famSize; theta += 0.01) {
          float rad = r(theta,
            1, //a
            1, //b
            famSize, //m1
            4.5, //n1
            map(cos(t), 0, 1, 8, 10), //n2
            map(sin(t), 0, 1, 8, 10) //n3
          );
          float x = rad * cos(theta) * 60;
          float y = rad * sin(theta) * 60;
          curveVertex(x,y);
        }
        endShape(CLOSE);
       }
  }
  
}
