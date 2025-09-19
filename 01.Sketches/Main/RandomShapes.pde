class RandomShapes {
  int npoints;
  PVector[] points;
  color c;
  float speed = 0.005;
  float amplitude;

  RandomShapes() {
  }

  void initialize() {
    npoints = (int) random(4, 25);
    points = new PVector[npoints];
    for (int i = 0; i < npoints; i++) {
      points[i] = new PVector(random(width), random(height));
    }
    colorMode(HSB, 255);
    c = color(random(255), 200, 255); 
    strokeWeight(2);
    stroke(255);
    background(0);
  }

  void display(AudioPlayer player, int param) {
    background(0);
        float squareSum=0;
    for (int i = 0; i < player.bufferSize(); i++) {
      float sample = player.left.get(i);
      squareSum += sample * sample;
    }
    float rms = sqrt(squareSum/player.bufferSize());
    rms = map(rms, 0, 1, 0, 600);
    amplitude = rms;
    fill(hue(c), 200, 255, map(amplitude, 0, 200, 50, 150));
    stroke(c);
    beginShape();
    // add extra points at start and end for curveVertex smoothing
    vertex(points[npoints - 1].x, points[npoints - 1].y);
    for (int i = 0; i < npoints; i++) {
      // wiggle points with noise for animation
      float nx = points[i].x + map(noise(frameCount*speed + i*10), 0, 1, -500, 500);
      float ny = points[i].y + map(noise(frameCount*speed + i*20), 0, 1, -500, 500);
      vertex(nx, ny);
    }
    // repeat first point for closing
    vertex(points[0].x, points[0].y);
    vertex(points[1].x, points[1].y);
    endShape(CLOSE);
  }
  
  
  float sCurve(float x, float threshold, float steepness) {
    return 1.0 / (1.0 + exp(-steepness * (x - threshold)));
  }
}
