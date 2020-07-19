float t;
ArrayList<Family> families;

JSONObject json;

int income;

void setup() {
  size(800,600);
  smooth();
  
  families = new ArrayList();
  
  loadData();
}

void draw() {
  background(244,242,237);
  smooth();
  translate(125,height/2);
  //scale(0.75);

  for (Family f : families) {
    f.run();
  }
  
  t += 0.04;
}

void loadData() {
  json = loadJSONObject("kids_and_noKids.json"); //first entry from MS_children_2018
  JSONArray fams = json.getJSONArray("families");
  for(int j = 0; j < fams.size(); j++) {
    ArrayList<Integer> memberInc = new ArrayList();
    
    JSONObject family = fams.getJSONObject(j); 
    JSONArray couple = family.getJSONArray("couple");
    if(family.isNull("children") == true) {
      int famSize = 2;
      for(int k = 0; k < 2; k++){ 
        memberInc.add(couple.getJSONObject(k).getInt("income"));
      }
      int[] incomes = new int[famSize];
      for (int k = 0; k < famSize; k++) {
        incomes[k] = memberInc.get(k);  
      }
      income = 0;
      for(int k = 0; k < memberInc.size(); k++) {
        income += memberInc.get(k);
      }
      families.add(new Family(famSize, income, incomes));
    }else{
      JSONArray children = family.getJSONArray("children");
      int numKids = children.size();
      int famSize = numKids + 2;
      for(int k = 0; k < 2; k++){ 
        memberInc.add(couple.getJSONObject(k).getInt("income"));
      }
      for(int k = 0; k < numKids; k++){
        memberInc.add(children.getJSONObject(k).getInt("income"));
      }
      int[] incomes = new int[famSize];
      for (int k = 0; k < famSize; k++) {
        incomes[k] = memberInc.get(k);  
      }
      income = 0;
      for(int k = 0; k < memberInc.size(); k++) {
        income += memberInc.get(k);
      }
      families.add(new Family(famSize, income, incomes));
      
    }
    
  }
}

float r(float theta, float a, float b, float m1, float n1, float n2, float n3) {
   return pow(pow(abs(cos(m1 * theta/4.0)/a),n2) + 
     pow(abs(sin(m1 * theta/4.0)/b),n3), -1.0/n1)  ;
}
