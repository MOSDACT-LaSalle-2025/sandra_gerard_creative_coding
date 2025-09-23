/* 
  =========================================================
   CONTROL GUIDE for this Processing Sketch
  =========================================================
  
   BACKGROUNDS (Upper row of keyboard):
     - 'P' → Flowing Perlin noise background
  
   MAIN VISUALS (Middle row of keyboard):
     - 'A' → Strobe eye effect
     - 'S' → Shape oscilloscope
     - 'D' → Random shapes (press again for redraw)
     - 'F' → Random shapes + FFT reactive (press again for redraw)
     - 'G' → Particle system (press again for reset)
     
   MAIN VISUAL PARAMETERS (Numbers from 1 to 9):
     - In shape oscilloscope -> Changes the shape
     - In strobe eye effect -> Stacks more or less ellipses
  
   OVERLAYS (Lower row of keyboard):
     - 'M' → Single part(s) of the Porter Robinson logo
     - 'N' → Full Porter Robinson logo
     - 'B' → Growing shapes for chords
  
   SPECIAL CONTROLS:
     - SPACEBAR → Strobe flash
     - BACKSPACE → Reset canvas
     
  =========================================================

  =========================================================
*/


import ddf.minim.*;
import ddf.minim.analysis.*;

Minim minim;
AudioPlayer player;

EyeStrobe eyestrobe;
Oscilloscope osci;
RandomShapes randomshapes;
JoyDivision joydivision;
Circle circle;
LogoParts lp;
MovingNoise mn;
Particlez particlez;

int sketchPointer=100;
int bgPointer=100;
int param=0;

void setup(){
  size(1920, 1080);
  fullScreen();
  background(0);
  frameRate(30);
  
  // Audio Library loading
  minim = new Minim(this);
  player = minim.loadFile("/resources/audio/divinity.wav", 512);
  //player.cue(50000);  -> por si necesitamos empezar en un punto en concreto

  
  eyestrobe = new EyeStrobe();
  osci = new Oscilloscope();
  randomshapes = new RandomShapes();
  joydivision = new JoyDivision(player);
  circle = new Circle();
  lp = new LogoParts();
  mn = new MovingNoise();
  particlez = new Particlez();
  
  player.play();
}


void draw(){
  switch(bgPointer){
    case 0:
      mn.display();
      break;
    case 100:
      //background(0);
      break;
  }
  
  
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
    case 4:
      particlez.display();
      break;
    case 100:
      break;
  }
  
  
  // Overlays
  if(circle.active) {
    circle.display(); 
  }
  if(lp.active){
     lp.display();
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
    case 'g':
      particlez.reset();
      sketchPointer=4;
      break;
    case 'b':
      circle.active = true;
      break;
     // ___________BACKGROUNDS_____________
     case 'p':
       bgPointer = 0;
       break;
     // ___________OVERLAYS______________
    case '\u0008':
      bgPointer = 100;
      sketchPointer = 100;
      break;
    case 'm':
      lp.active=true;
      lp.full=false;
      break;
    case 'n':
      lp.active=true;
      lp.full=true;
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

void keyReleased(){
  switch(key){
    case 'b':
      circle.reset();
      break;
    case 'm':
      lp.reset();
      lp.activate();
      break;
    case 'n':
      lp.reset();
      lp.activate();
      break;
  }
}
