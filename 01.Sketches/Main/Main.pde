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
Particlez particlez;
Birds birds;
HandFast hands;
Clouds clouds;
Squares squares;

//------------------------------------------------------------
//                         SANDY
//------------------------------------------------------------
// VARIABLES PARA EL FADE GLOBAL DE IMÁGENES
float alphaTarget = 255; // Objetivo de transparencia (255: visible, 0: oculto)
float alphaCurrent = 255; // Transparencia actual
float fadeSpeed = 10; // Velocidad del fade (ajusta a tu gusto)
ArrayList<PImage> imagenes;
ArrayList<Visual> visuals;
int cantidadImagenes = 98;
int duracion = 10;
int frecuencia = 3;
int indiceActual = 0;


int sketchPointer=100;
int bgPointer=100;
int param=0;
int reversecounter;

void setup(){
  //size(1920, 1080);
  fullScreen();
  background(0);
  frameRate(30);

  //reversecounter = 1/frameRate * 
  
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
  particlez = new Particlez();
  birds = new Birds();
  hands = new HandFast(); 
  loadHandsSlow();
  clouds = new Clouds();
  squares = new Squares();
  
  player.play();
}


void draw(){
  switch(bgPointer){
    case 0:
      break;
    case 100:
      background(0);
      break;
    case 101:  // Leave transparent
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
      randomshapes.display();
      break;
    case 3:
      randomshapes.display();
      joydivision.display(player);
      break;
    case 4:
      particlez.display(param);
      break;
    case 5:
      birds.display(param);
      break;
    case 6:
      hands.display();
      break;
    case 7:
        // 2. DIBUJAR IMÁGENES (Visuals)
        if (alphaTarget == 255 || alphaCurrent > 1) {
            if (frameCount % frecuencia == 0) {
                if (!imagenes.isEmpty()) {
                    PImage imgNueva = imagenes.get(indiceActual);
                    visuals.add(new Visual(imgNueva, duracion));
                    indiceActual = (indiceActual + 1) % imagenes.size();
                }
            }
            // Asegura el modo de mezcla normal para las imágenes
            blendMode(BLEND);
            for (int i = visuals.size() - 1; i >= 0; i--) {
                Visual v = visuals.get(i);
                v.update();
                v.display();
                if (v.isDead()) {
                    visuals.remove(i);
                }
            }
        }
      break;
    case 100:
      break;
    // PREP________________________________________________
      
      
  }
  
  
  // Overlays
  if(circle.active) {
    circle.display(); 
  }
  if(lp.active){
     lp.display();
  }
  if(clouds.active){
    clouds.display();
  }
  if(squares.active){
    squares.display();
  }
}


void keyPressed(){
  blendMode(BLEND);
  
  switch(key){
    case 'a':
      sketchPointer=0;
      bgPointer=101;
      eyestrobe.initialize();
      break;
    case 's':
      sketchPointer=1;
      osci.initialize();
      break;
    case 'd':
      sketchPointer=2;
      bgPointer=101;
      background(0);
      break;
    case 'f':
      sketchPointer=3;
      joydivision.initialize();
      break;
    case 'q':
      particlez.reset();
      bgPointer=101;
      sketchPointer=4;
      break;
    case 'w':
      birds.reset();
      sketchPointer=5;
      bgPointer=101;
      break;
    case 'e':
      sketchPointer=6;
      bgPointer=100;
      break;
    case 'r':
      sketchPointer=7;
      bgPointer=101;
      alphaTarget = (alphaTarget == 255) ? 0 : 255;
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
    case 'b':
      circle.active = true;
      break;
    case 'm':
      lp.active=true;
      lp.full=false;
      break;
    case 'n':
      lp.active=true;
      lp.full=true;
      break;
    case 'v':
      clouds.active=true;
      break;
    case 'c':
      squares.active=true;
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
    case 'v':
      clouds.active=false;
      break;
    case 'c':
      squares.active=false;
      break;
  }
}


void loadHandsSlow(){
    imagenes = new ArrayList<PImage>();
    for (int i = 1; i <= cantidadImagenes; i++) {
        // Asegúrate de que las imágenes están en la carpeta 'data' del sketch
        PImage img = loadImage("resources/images/handslow/downloadedImage (" + i + ").png");
        if (img != null) imagenes.add(img);
    }
    println("✅ Se cargaron " + imagenes.size() + " imágenes.");
    
    visuals = new ArrayList<Visual>();
    if (!imagenes.isEmpty()) {
        PImage imgInicial = imagenes.get(indiceActual);
        visuals.add(new Visual(imgInicial, duracion));
        indiceActual = (indiceActual + 1) % imagenes.size();
    }
}
