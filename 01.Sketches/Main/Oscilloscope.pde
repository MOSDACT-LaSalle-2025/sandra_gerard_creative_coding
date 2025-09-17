class Oscilloscope{
  float scale = 800;
  int shape;
  int[] shapes = new int[10];

  Oscilloscope() {
    shapes[0] = QUAD_STRIP;
    shapes[1] = TRIANGLE_FAN;
    shapes[2] = POINTS;
    shapes[3] = TRIANGLES;
    shapes[4] = TRIANGLE_STRIP;
    shapes[5] = TRIANGLE_FAN;
    shapes[6] = QUADS;
    shapes[7] = QUAD_STRIP;
    shapes[8] = POINTS;
    shapes[9] = TRIANGLE_FAN;
  }
  
  void initialize(){
    colorMode(RGB, 255);
    stroke(100, 100, 255);
    strokeWeight(0.5);
  }
  
  void display(AudioPlayer player, int param) {
    background(0);
    fill(128,128,255);
    
    shape = shapes[param];
    if(shape==POINTS){strokeWeight(2);}else{strokeWeight(1);}
    
    translate(width/2, height/2);
    // En la referencia: The parameters available for beginShape() are POINTS(nice), LINES, TRIANGLES(nice), TRIANGLE_FAN(nice), TRIANGLE_STRIP(nice), QUADS, and QUAD_STRIP(nice)
    beginShape(shape);
    for (int i = 0; i < player.bufferSize(); i++) {
      float x = player.left.get(i) * scale;
      float y = player.right.get(i) * scale;
      vertex(x, y);
    }
    endShape();
    //filter(BLUR,3);
  }
  
}
