float t;

Distribution d;
Comparison c;

JSONObject json;

ArrayList<Integer> memberInc = new ArrayList();
int income;

void setup() {
  size(500,500);
  smooth();
  
  loadData();
}

void draw() {
  background(244,242,237);
  smooth();
  translate(width/2,height/2);
  d.display();
  c.display();
  
  t += 0.04;

}

void loadData() {
  json = loadJSONObject("test2.json"); //first entry from MS_children_2018
  JSONObject family = json.getJSONObject("family");
  JSONArray children = family.getJSONArray("children");
  JSONArray couple = family.getJSONArray("couple");
  
  //creating the arrayList with the income for each family member
  for(int i = 0; i < couple.size(); i++){
    memberInc.add(couple.getJSONObject(i).getInt("income"));
  }
  memberInc.add(children.getJSONObject(0).getInt("income"));
  
  //total household income
  income = 0;
    for(int i = 0; i < memberInc.size(); i++) {
      income += memberInc.get(i);
    }
  
  //getting size of family
  int numKids = children.size();
  int famSize = numKids + 2;
  
  //creating my objects
  c = new Comparison(famSize, income);
  d = new Distribution(famSize, income);
}

float r(float theta, float a, float b, float m1, float n1, float n2, float n3) {
   return pow(pow(abs(cos(m1 * theta/4.0)/a),n2) + 
     pow(abs(sin(m1 * theta/4.0)/b),n3), -1.0/n1)  ;
}
