Table table;
Person[] people;

int margin;
float xSpacer;

void setup() {
 size(800,400);
 loadData();
}

void draw() {
  background(255);
  for (int i = 0; i < people.length; i++) {
    people[i].display();
  }
}

void loadData() {
  table = loadTable("sample.csv", "header");
  people = new Person[table.getRowCount()];
  
  margin = 50;
  xSpacer = (width - margin - margin) / 2;
  println(xSpacer);
  
  for(int i = 0; i < table.getRowCount(); i++) {
    TableRow row = table.getRow(i);
    float x = margin + (xSpacer*(row.getFloat("HOUSEHOLD")-1));
    float y = margin + 35 * (row.getFloat("PERNUM"));
    float d = row.getFloat("AGE") + 2;
    people[i] = new Person(x,y,d);
  }
}
