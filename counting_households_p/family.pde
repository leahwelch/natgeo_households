class Family {
  
  ArrayList<Member> family;
  final int famId;
  
  Family(int famId) {
    this.famId = famId;
    family = new ArrayList();
  }
  
  int familyNumber(){
    return family.size();
  }
  
  void addMember(Member m) {
    family.add(m);
  }
  
  void run() {
    push();
    for(Member m: family) {
      m.display();  
      translate(0, 20);
    }
    pop();
  }
  
  
}
