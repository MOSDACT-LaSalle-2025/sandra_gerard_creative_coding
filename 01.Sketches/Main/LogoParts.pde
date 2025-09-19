class LogoParts{
  boolean active = false;
  int photoPointer;
  ArrayList<PImage> images;
  ArrayList<Float> positions;
  float offset = 49;
  boolean full = false;
  
  LogoParts(){
    images = new ArrayList<PImage>();
    positions = new ArrayList<Float>();
    for(int i=1; i<=7; i++){
       String path = "/resources/images/logo/Logo 1-7-0" + i + ".png";
       PImage img = loadImage(path);
       img.resize(200,0);
       images.add(img);
       
       float posx = i*img.width*0.5 - offset;
       posx = map(posx, 0, img.width*7*0.5, -width*0.4, width*0.4);
       positions.add(posx);
    }
  }
  
  void reset(){
    active = false;
  }
  
  void activate(){
    photoPointer = (int) random(1,7); 
  }
  
  void display(){
    pushMatrix();
    translate(width/2, height/2);
    imageMode(CENTER);
    strokeWeight(10);
    if(full){
      for(int i=0; i<7; i++){
        image(images.get(i),positions.get(i),0);
      }
    }else{
      image(images.get(photoPointer),positions.get(photoPointer),0);
    }
    popMatrix();
  }
}
