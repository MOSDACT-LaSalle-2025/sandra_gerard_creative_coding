class MovingNoise{  
  float yoff = 0; // 3rd dimension for animation
  
  MovingNoise(){}
  
  void display() {
    // instead of clearing with full background, overlay a translucent rect
    fill(0, 10); // white with low alpha (20/255)
    noStroke();
    rect(0, 0, width, height);
  
    // draw the noise curve
    stroke(255);
    noFill();
  
    beginShape();
    float xoff = 0;
    for (int x = 0; x < width; x++) {
      float y = noise(xoff, yoff) * height;
      vertex(x, y);
      xoff += 0.001;
    }
    endShape();
  
    yoff += 0.01; // move through noise space
  }
}
