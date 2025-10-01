class HandFast{
  String path = "/resources/images/hand/";
  ArrayList<PImage> hands;
  int nimages = 48;
  int w = 1920;
  int h = 1080;
  int duration = 2;
  int counter = 0;
  int index;
  
  HandFast(){
     hands = new ArrayList<PImage>();
     for(int i=1; i<=nimages; i++){
       String filename = path + "ALBUMLOGO-" + i + ".png";
       PImage img = loadImage(filename);
       img.resize(w, h);
       hands.add(img);
       index = (int) random(nimages);
     }
  }
  
  void display(){
    imageMode(CENTER);
    if(counter>=duration){
      index = (int) random(nimages);
      counter = 0;
    }
    pushMatrix();
    translate(width/2,height/2);
    image(hands.get(index),0,0);
    popMatrix();
    counter++;
  }
}
