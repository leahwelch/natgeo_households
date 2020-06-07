class FlowField {
   
    PVector [][] field;
    int cols, rows;
    int resolution;
    
    FlowField(int r) {
      resolution = r;
      
      cols = width/resolution;
      rows = height/resolution;
      field = new PVector[cols][rows];
    }
    
    void init() {
      float xoff = 0;
      for (int i = 0; i < cols; i++) {
        float yoff =0;
        for (int j = 0; j < rows; j++) {
          float theta = 0;
          field[i][j] = PVector.fromAngle(theta);
          yoff+= 0.1;
        }
      }
    }
  
}
