class Family {
  final int famSize;
  final int income;
  final int[] incomes;
  
  Comparison c;
  Distribution d;
  
  Family(int famSize, int income, int[] incomes) {
    this.famSize = famSize;
    this.income = income;
    this.incomes = incomes;
    c = new Comparison(famSize, income);
    d = new Distribution(famSize, income, incomes);  
  }
  
  void run() {
    d.display();
    c.display();
    translate(250,0);
    
  }
  
}
