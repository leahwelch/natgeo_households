class Member {
  int relateVal;
  int pernumVal;
  int famId;
  
  color col;
  
  Member(int famId, int r, int num, boolean head) {
   relateVal = r;
   pernumVal = num;
   
   if(head) {
     col = color(255,0,0); 
   } else {
     col = color(0,0,255);  
   }
  }
  
  void display() {
    fill(col);
    stroke(0);
    ellipse((famId+10), (relateVal*20), 10, 10);
  }

}
