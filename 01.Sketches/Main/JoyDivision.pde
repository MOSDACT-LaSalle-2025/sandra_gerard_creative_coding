class JoyDivision {
  FFT fft;
  float range;
  float fftRange;
  float separation = 20;
  ArrayList<float[]> history;
  int maxHistory = 40;

  JoyDivision(AudioPlayer player) {
      fft = new FFT(player.bufferSize(), player.sampleRate());
      history = new ArrayList<float[]>();
   }

  void initialize() {
    range = (fft.specSize()/8);
    colorMode(HSB, 255);
  }

  void display(AudioPlayer player) {
    //background(0);
    stroke(255);
    noFill();
    
    // perform a forward FFT on the samples in jingle's mix buffer,
    // which contains the mix of both the left and right channels of the file
    fft.forward(player.mix);
    
    float[] snapshot = new float[fft.specSize()];
    for(int i=0; i < fft.specSize(); i++){
      snapshot[i] = fft.getBand(i); 
    }
    
    history.add(0, snapshot);
    if (history.size() > maxHistory) { // limit history length
      history.remove(history.size()-1);
    }
    
    
    pushMatrix();
    translate(width/2, height/2);
    
    float strk = 0.5;
    int j=0;
    int hue = 150;
    for (int h = history.size()-1; h>=0; h--) {
      fill(hue, 200, 200);
      strokeWeight(strk);
      float[] ss = history.get(h);
      float y = j * separation - (maxHistory/2.0) * separation;
      
      float depthScale = map(h, history.size()-1, 0, 1.0, 1.6);
      ss[0]=0;
      ss[ss.length/8 - 1] = 0;

      beginShape();
      for (int i = 0; i < ss.length/8; i++) { // focus on low freq
        float x = map(i, 0, ss.length/8, -width/4, width/4);
        float amp = ss[i]; // scale factor
        x *= depthScale;
        vertex(x, y - amp);
      }
      endShape();
      j++;
      strk += 0.05;
      hue++;
    }
    popMatrix();
  }
}
