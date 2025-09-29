class Circle {
  float starting_r = 50;
  float increment = 60;
  float counter;
  boolean active = false;
  float ncircles = 15;
  
  Circle(){
    counter = 0;
  }
  
  
  
  void display(){
    pushMatrix();
    noFill();
    stroke(255);
    strokeWeight(2);
    int rnd=(int) random(1,3);
    translate(width/2, height/2);
    float current_r = starting_r + counter*increment;
    for(int i=0;i<=ncircles;i++){
      rotate(random(-PI, PI));
      float nrad = current_r - 20*i;
      nrad = constrain(nrad, 0, height);
      if(rnd==1){circle(0, 0, nrad);}
      else if(rnd==2){rect(0, 0, nrad, nrad);}
    }
    counter++;
    popMatrix();
  }
  
  void reset(){
    active = false;
    counter = 0;
  }

}
