class Prep {
  String text = "Press Enter to Start";
  PFont font;
  Prep(){
    font = createFont("resources/fonts/VCR_OSD_MONO_1.001.ttf",128);
    textFont(font);
    textSize(100);
  }
  
  void display(){
     fill(127*sin(frameCount*0.1) + 127);
     textAlign(CENTER);
     text(text,width/2,height/2);
  }
}
