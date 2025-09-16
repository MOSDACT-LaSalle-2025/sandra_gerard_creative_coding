import ddf.minim.*;

Minim minim;
AudioPlayer player;

Ascii ascii;
EyeStrobe eyestrobe;
Oscilloscope osci;

int sketchPointer=0;
int param=0;

void setup(){
  size(1920, 1080);
  fullScreen();
  background(0);
  frameRate(30);
  
  // Audio Library loading
  minim = new Minim(this);
  player = minim.loadFile("/resources/audio/divinity.mp3");
  //player.cue(50000);  -> por si necesitamos empezar en un punto en concreto
  player.play();
  
  eyestrobe = new EyeStrobe();
  osci = new Oscilloscope();
}


void draw(){
  switch(sketchPointer){
    case 0:
      eyestrobe.display(player, param);
      break;
    case 1:
      osci.display(player);
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
    default:
      if (key >= '1' && key <= '9'){
        param = (int) key - '1';
        println(param);
      }
      break;
      
  }
}
