import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

EyeStrobe eyestrobe;
Oscilloscope osci;
RandomShapes randomshapes;
JoyDivision joydivision;

int sketchPointer=0;
int param=0;

void setup(){
  size(1920, 1080);
  fullScreen();
  background(0);
  frameRate(30);
  
  // Audio Library loading
  minim = new Minim(this);
  player = minim.loadFile("/resources/audio/divinity.mp3", 512);
  //player.cue(50000);  -> por si necesitamos empezar en un punto en concreto
  player.play();
  
  eyestrobe = new EyeStrobe();
  osci = new Oscilloscope();
  randomshapes = new RandomShapes();
  joydivision = new JoyDivision(player);
}


void draw(){
  switch(sketchPointer){
    case 0:
      eyestrobe.display(player, param);
      break;
    case 1:
      osci.display(player, param);
      break;
    case 2:
      randomshapes.display(player, param);
      break;
    case 3:
      randomshapes.display(player, param);
      joydivision.display(player);
      break;
  }
}


void keyPressed(){
  switch(key){
    case 'a':
      sketchPointer=0;
      eyestrobe.initialize();
      break;
    case 's':
      sketchPointer=1;
      osci.initialize();
      break;
    case 'd':
      sketchPointer=2;
      randomshapes.initialize();
      break;
    case 'f':
      sketchPointer=3;
      randomshapes.initialize();
      joydivision.initialize();
      break;
    case ' ':
      filter(INVERT);
      break;
    default:
      if (key >= '1' && key <= '9'){
        param = (int) key - '1';
        println(param);
      }
      break;
      
  }
}
