class Oscilloscope{
  float scale = 800;
  

  Oscilloscope() {
  }
  
  void initialize(){
    colorMode(RGB, 255);
    stroke(255);
    strokeWeight(0.5);
  }
  
  void display(AudioPlayer player) {
    background(0);
    fill(0,200,0);
    
    translate(width/2, height/2);
  
    // En la referencia: The parameters available for beginShape() are POINTS(nice), LINES, TRIANGLES(nice), TRIANGLE_FAN(nice), TRIANGLE_STRIP(nice), QUADS, and QUAD_STRIP(nice)
    beginShape(QUAD_STRIP);
    for (int i = 0; i < player.bufferSize(); i++) {
      float x = player.left.get(i) * scale;
      float y = player.right.get(i) * scale;
      vertex(x, y);
    }
    endShape();
    //filter(BLUR,3);
  }
}
