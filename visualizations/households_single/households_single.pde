Table table;
ArrayList<Head> heads = new ArrayList<Head>();
ArrayList<Person> people = new ArrayList<Person>();

int margin;
float xSpacer;

void setup() {
 size(800,400);
 loadData();
}

void draw() {
  background(255);
  for(Head h : heads) {
    h.display(); 
    for(Person p : people) {
      PVector force = h.attract(p);
      p.applyForce(force);
      p.update();
      p.display(); 
    }
  } 
   
}

void loadData() {
  table = loadTable("sample.csv", "header");
  
  margin = 100;
  xSpacer = (width - margin - margin) / 2;
  println(xSpacer);
  
  for(int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    float x = width/2;
    float y = height/2;
    float d = row.getFloat("AGE") + 2;
    if(row.getFloat("RELATE") == 1) {
      Head h = new Head(x,y,d); 
      heads.add(h);
    } else {
      people.add(new Person(random(width), random(height),d));
    }
    
  }
}
