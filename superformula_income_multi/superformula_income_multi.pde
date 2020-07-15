float t;
ArrayList<Family> families;

JSONObject json;

int income;

void setup() {
  size(500,500);
  smooth();
  
  families = new ArrayList();
  
  loadData();
}

void draw() {
  background(244,242,237);
  smooth();
  translate(125,height/2);

  for (Family f : families) {
    f.run();
  }
  
  t += 0.04;
}

void loadData() {
  json = loadJSONObject("test_multiple.json"); //first entry from MS_children_2018
  JSONArray fams = json.getJSONArray("families");
  for(int j = 0; j < fams.size(); j++) {
    JSONObject family = fams.getJSONObject(j); 
    JSONArray children = family.getJSONArray("children");
    JSONArray couple = family.getJSONArray("couple");
    
    //getting size of family
    int numKids = children.size();
    int famSize = numKids + 2;
    //println(famSize);
    
    ArrayList<Integer> memberInc = new ArrayList();
    
    //creating the arrayList with the income for each family member
    for(int i = 0; i < 2; i++){ 
      memberInc.add(couple.getJSONObject(i).getInt("income"));
    }
    for(int i = 0; i < numKids; i++){
      memberInc.add(children.getJSONObject(i).getInt("income"));
    }
    
    int[] incomes = new int[famSize];
    for (int i = 0; i < famSize; i++) {
      incomes[i] = memberInc.get(i);  
    }
    //printArray(incomes);
    
    //total household income
    income = 0;
      for(int i = 0; i < memberInc.size(); i++) {
        income += memberInc.get(i);
      }
     //println(income);
    
    
    
    //creating my objects
    families.add(new Family(famSize, income, incomes));
    //c = new Comparison(famSize, income);
    //d = new Distribution(famSize, income);
  }
}

float r(float theta, float a, float b, float m1, float n1, float n2, float n3) {
   return pow(pow(abs(cos(m1 * theta/4.0)/a),n2) + 
     pow(abs(sin(m1 * theta/4.0)/b),n3), -1.0/n1)  ;
}
