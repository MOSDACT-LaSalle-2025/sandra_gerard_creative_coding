class Squares{
  boolean active=false;
  // Variables Glitch
  int numCuadrados = 2; 
  int maxApagon = 70;    
  float opacidadMaxima = 245; 
  float opacidadBase = 20;    
  
  // Colores Glitch
  color COLOR_BLANCO = color(255);
  color COLOR_NEON_ROSA = color(255, 51, 204); 
  color COLOR_AZUL_GLITCH = color(51, 153, 255); 
  
  Squares() {
  }
  
  void display() {
   
    noStroke();
    //fill(0, opacidadBase); 
    //rect(0, 0, width, height); 
  
    // Apagon Luz 
    if (frameCount % maxApagon == 0) { 
      
      // Destello  
      fill(COLOR_BLANCO, opacidadMaxima);
      rect(0, 0, width, height);
    }
  
    // Dibujo Cuadrados
    for (int i = 0; i < numCuadrados; i++) {
     
      float x = random(width);
      float y = random(height);
      
      float tam = random(10, 120); 
      
      float opacidadCuadrado = random(100, 255);
   
      int colorSeleccion = int(random(3)); 
      
      if (colorSeleccion == 0) {
        fill(COLOR_NEON_ROSA, opacidadCuadrado);
      } else if (colorSeleccion == 1) {
        fill(COLOR_AZUL_GLITCH, opacidadCuadrado);
      } else {
        fill(COLOR_BLANCO, opacidadCuadrado);
      }
  
      // Desplazamiento  Glitch
      x += random(-15, 10); 
      y += random(-15, 10);
  
      rect(x, y, tam, tam);
    }
  }
}
