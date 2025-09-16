class EyeStrobe{
  float sizeX;
  float sizeY;
  int counter = 0;
  float sine;
  
  final int DELAY = 1;
  final int RND_X = 1000;
  final int RND_Y = 1000;
  
  EyeStrobe(){
  }
  
  void initialize(){
    stroke(0);
    background(0);
    colorMode(HSB, 255);
  }
  
  
  void display(AudioPlayer player){
    //sine = sin(millis()/300)/1.2 + 1;
        
    float squareSum=0;
    for (int i = 0; i < player.bufferSize(); i++) {
      float sample = player.left.get(i);
      squareSum += sample * sample;
    }
    float rms = sqrt(squareSum/player.bufferSize());
    rms = map(rms, 0, 1, 0, 10);
    println(rms);
    if (counter==DELAY) {
      background(0);
      counter=0;
    }
    sizeX = random(1,RND_X*rms);
    sizeY = random(1,RND_Y*rms);
    colorMode(HSB, 255);
    fill(random(255), 255, 255);
    ellipse(width/2, height/2, sizeX, sizeY); 
    counter++;
  }  
}
