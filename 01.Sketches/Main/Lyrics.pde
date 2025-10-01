class Lyrics{
  String text;
  float widthFactor;
  float b=0.5;
  float alpha = 25;
  PFont font;
  float textWidth=20;
  boolean active=false;
  
  Lyrics(){
    text = "Lean into my side";
    font = createFont("resources/fonts/Akira Expanded Demo.otf",128);
  }
  
  void init(){
    textFont(font);
    textSize(20);
    textAlign(CENTER);
  }
  
  void display() {
    noStroke();
    fill(0,alpha);
    rect(0, 0, width, height);
    //background(0);
    
    for(int j=0; j<=height; j+=20){
      float offset = j*PI/512;
      widthFactor = b*sin((frameCount*0.02) + offset) + 3;
      pushMatrix();
      translate(width/2, j);
      //textAlign(CENTER,CENTER);
      fill(127 + 32 * sin(frameCount * 0.02 + QUARTER_PI + offset), 100, 255);
      //fill(255);
      stroke(255,0,0);
      //float x = -textWidth(text)*0.5 * widthFactor + 20;
      float x = -text.length()*textWidth*0.5 * widthFactor;
      for(int i=0; i<text.length(); i++){
        //text(text.charAt(i),x,20*sin(frameCount*0.01 + i));
        //float yOffset = 20 * sin(frameCount * 0.02 + i * 0.5);
        text(text.charAt(i),x,0);
        //x += textWidth(text.charAt(i))*widthFactor;
        x += textWidth*widthFactor;
      }
      popMatrix();
    }
  }
  
  void toggleActive(){
    active = !active; 
  }
}
