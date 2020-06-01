class Member {
  final int relate;
  final int famId;
  
  color col;
  
  Member(int famId, int relate) {
   this.relate = relate;
   this.famId = famId;
   
   if(isHead()) {
     col = color(255,0,0); 
   } else {
     col = color(0,0,255);  
   }
  }
  
  void display() {
    fill(col);
    stroke(0);
    ellipse(0, 0, 10, 10);
  }
  
  boolean isHead(){
    return (relate == 1);
  }

}
