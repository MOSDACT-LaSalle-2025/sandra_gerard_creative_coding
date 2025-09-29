class HandFast{
  String path = "/resources/images/hand/";
  ArrayList<PImage> hands;
  int nimages = 48;

  
  HandFast(){
     hands = new ArrayList<PImage>();
     for(int i=1; i<=nimages; i++){
       String filename = path + "ALBUMLOGO-" + i + ".png";
       PImage img = loadImage(filename);
       hands.add(img);
     }
  }
  
  void display(){
    imageMode(CENTER);
    int rnd = (int) random(1,nimages);
    
    pushMatrix();
    translate(width/2,height/2);
    image(hands.get(rnd),0,0);
    popMatrix();
  }
}
