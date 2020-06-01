class Family {
  
  ArrayList<Member> family;
  int relationship;
  int quantity;
  int familyNumber;
  
  Family(int famNum, int r, int n, boolean head) {
    family = new ArrayList();
    relationship = r;
    quantity = n;
    familyNumber = famNum;
    for(int i = 0; i<n; i++) {
      addParticle();
    }
  }
  
  void addParticle() {
    if(relationship == 1) {
      family.add(new Member(familyNumber, relationship, quantity, true));
    } else {
      family.add(new Member(familyNumber, relationship, quantity, false));
    }
  }
  
  void run() {
    for(Member m: family) {
      m.display();  
    }
  }
  
  
}
