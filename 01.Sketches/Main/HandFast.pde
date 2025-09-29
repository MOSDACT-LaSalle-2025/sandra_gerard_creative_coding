class HandFast{
  String path = "/resources/images/hand/";
  ArrayList<PImage> hands;
  int nimages = 49;
  int targetW = 1920; // set the desired width
  int targetH = 1080; // set the desired height
  
  HandFast(){
     hands = new ArrayList<PImage>();
     for(int i=1; i<=nimages; i++){
       String filename = path + "ALBUMLOGO" + i + ".png";
       PImage img = loadImage(filename);
       hands.add(img);
     }
  }
  
  void display(){
    imageMode(CENTER);
    int rnd = (int) random(1,49);
    
    pushMatrix();
    translate(width/2,height/2);
    image(hands.get(rnd),0,0);
    popMatrix();
  }
}
