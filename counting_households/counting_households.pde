ArrayList<Family> households = new ArrayList();


void setup() {
  size(800, 800);
  totalCount("sample.csv"); // sample from Arushi
}

void draw() {
  background(255);
  
  for (Family f: households) {
    f.run();
    f.addParticle();  
  }
}

void totalCount(String file) {
  
  BufferedReader reader = createReader(file);
  String line = null;
  print("Reading "+file+"... ");
  //float total = 0;
  int lines = 0;
  
  
  try {
    reader.readLine(); //skips first line
    while ((line = reader.readLine()) != null) {
      String[] pieces = split(line, ",");
      for(int i=0; i < pieces.length; i++) {
        int relate = int(pieces[2]) + i;
        int pernum = int(pieces[1]);
        
        int n;
        if(pernum == 1) n = 1;
        else n = 0;
        
        int familyNum = i*10;
        boolean h = boolean(n);

        households.add(new Family(familyNum, relate, pernum, h));
       }
        //if(relate == 1){
          //households.add(new Family(relate, pernum, true));
        //} else {
          //households.add(new Family(relate, pernum, false));
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
