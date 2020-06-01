ArrayList<Family> households = new ArrayList();


void setup() {
  size(800, 800);
  totalCount("sample.csv"); // sample from Arushi
}

void draw() {
  background(255);
  
  translate(30, 30);
  for (Family f: households) {
    f.run();
    translate(30, 0);
  }
}

void totalCount(String file) {
  
  BufferedReader reader = createReader(file);
  String line = null;
  print("Reading "+file+"... ");
  //float total = 0;
  int lines = 0;
  
  Family currentFamily = null;
  try {
    reader.readLine(); //skips first line
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      int pernum = int(pieces[1]);
      int relate = int(pieces[2]);
      int famId = int(pieces[0]);
      if(pernum == 1){
        currentFamily = new Family(famId);
        households.add(currentFamily);
      }
      currentFamily.addMember(new Member(famId, relate));
      
      lines++;
    }
    reader.close();
  } catch (IOException e) {
    e.printStackTrace();
  }
  //println("done.");
  printArray(households);
  //println(file+" lines: "+nfc(lines)+" count: "+nfc(total, 2));
}
