//Toxic Libs
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

// Reference to physics "world" (2D)
VerletPhysics2D physics;
float tx, ty;
ArrayList<Jelly> jellies;

float amplitude = 5;
float angle = 0.0;

//Textures
PImage[] blues = new PImage[7];
PImage[] reds = new PImage[7];
PImage[] greens = new PImage[7];

//Data Stuff
JSONObject json;
int income;
int famType;

void setup() {
  size(800,600, P2D);
  
  physics=new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.01)));
  jellies = new ArrayList();
  
  for (int i = 0; i < blues.length; i ++ ) {
    blues[i] = loadImage( "blue_" + (i) + ".png" );
  }
  
  for (int i = 0; i < reds.length; i ++ ) {
    reds[i] = loadImage( "red_" + (i) + ".png" );
  }
  for (int i = 0; i < greens.length; i ++ ) {
    greens[i] = loadImage( "green_" + (i) + ".png" );
  }
  
  loadData();
  
}

void draw() {
  background(2,1,32);
  smooth();
  
  // Update physics
  physics.update();

  for(Jelly j : jellies) {
    j.update();
    j.borders();
    j.run();
  }
  
  tx += 0.01;
  ty += 0.01;
}

void loadData() {
  famType = 0;
  int manInc, womInc;
  manInc = 0;
  womInc = 0;
  json = loadJSONObject("kids_and_noKids.json"); //first 3 entries from MS_children_2018
  JSONArray fams = json.getJSONArray("families");
  for(int j = 0; j < fams.size(); j++) {
    ArrayList<Integer> memberInc = new ArrayList();
    
    JSONObject family = fams.getJSONObject(j); 
    JSONArray couple = family.getJSONArray("couple");
    if(family.isNull("children") == true) {
      int famSize = 2;
      int numKids = 0;
      for(int k = 0; k < 2; k++){ 
        int sex = couple.getJSONObject(k).getInt("sex");
        int personInc = couple.getJSONObject(k).getInt("income");
 
        if(sex == 1) {
          manInc = personInc;
        }
        if(sex == 2) {
          womInc = personInc;
        }
        if(manInc > womInc) {
          famType = 1;  
        } else if (manInc < womInc) {
          famType = 2;  
        } else {
          famType = 3;  
        }
        memberInc.add(personInc);
        
      }
      int[] incomes = new int[2];
      for (int k = 0; k < famSize; k++) {
        incomes[k] = memberInc.get(k);  
      }
      income = 0;
      for(int k = 0; k < memberInc.size(); k++) {
        income += memberInc.get(k);
      }
      jellies.add(new Jelly(numKids, income, famType));
    }else{
      JSONArray children = family.getJSONArray("children");
      int numKids = children.size();
      int famSize = numKids + 2;
      for(int k = 0; k < 2; k++){
        int sex = couple.getJSONObject(k).getInt("sex");
        int personInc = couple.getJSONObject(k).getInt("income");
        
        if(sex == 1) {
          manInc = personInc;
        }
        if(sex == 2) {
          womInc = personInc;
        }
        if(manInc > womInc) {
          famType = 1;  
        } else if (manInc < womInc) {
          famType = 2;  
        } else {
          famType = 3;  
        }
        
        memberInc.add(personInc);
      }
      /*for(int k = 0; k < numKids; k++){
        memberInc.add(children.getJSONObject(k).getInt("income"));
      }*/
      int[] incomes = new int[2];
      for (int k = 0; k < 2; k++) {
        incomes[k] = memberInc.get(k);  
      }
      income = 0;
      for(int k = 0; k < memberInc.size(); k++) {
        income += memberInc.get(k);
      }
      jellies.add(new Jelly(numKids, income, famType));
    }
    
  }
}
