class Squares{
  boolean active=false;
  // Variables para el Glitch
  int numCuadrados = 2; // Número de cuadrados que aparecerán
  int maxApagon = 70;    // Probabilidad de "apagón" (cuanto menor, más frecuente)
  float opacidadMaxima = 245; // Opacidad máxima para el blanco/colores
  float opacidadBase = 20;    // Opacidad de fondo persistente para el 'fade'
  
  // Colores Glitch
  color COLOR_BLANCO = color(255);
  color COLOR_NEON_ROSA = color(255, 51, 204); // Un rosa neón brillante
  color COLOR_AZUL_GLITCH = color(51, 153, 255); // Un azul vibrante
  
  Squares() {
  }
  
  void display() {
    // 1. Efecto de "Fade" o persistencia de imagen
    // Esto crea el arrastre y desenfoque. Un 'glitch' no borra la pantalla
    // por completo, sino que deja un rastro.
    fill(0, opacidadBase); 
    rect(width / 2, height / 2, width, height); 
  
    // 2. Apagón de Luz Blanca (Flicker Intenso)
    // Genera un destello de luz blanca que simula un fallo eléctrico o de pantalla.
    if (frameCount % maxApagon == 0) { // Ocurre cada 'maxApagon' frames
      // Un fuerte destello blanco que dura solo un frame
      fill(COLOR_BLANCO, opacidadMaxima);
      rect(width / 2, height / 2, width, height);
    }
  
    // 3. Generación y Dibujo de Cuadrados Glitch
    for (int i = 0; i < numCuadrados; i++) {
      // Posición aleatoria para el cuadrado
      float x = random(width);
      float y = random(height);
      
      // Tamaño aleatorio para el cuadrado (más pequeños para más detalle)
      float tam = random(10, 120); 
      
      // Opacidad aleatoria para un efecto más caótico
      float opacidadCuadrado = random(100, 255);
  
      // Selección de color aleatorio: Rosa Neon, Azul Glitch o Blanco
      int colorSeleccion = int(random(3)); // 0, 1, o 2
      
      if (colorSeleccion == 0) {
        fill(COLOR_NEON_ROSA, opacidadCuadrado);
      } else if (colorSeleccion == 1) {
        fill(COLOR_AZUL_GLITCH, opacidadCuadrado);
      } else {
        fill(COLOR_BLANCO, opacidadCuadrado);
      }
  
      // Pequeño desplazamiento aleatorio para simular el glitch de posición
      x += random(-15, 10); 
      y += random(-15, 10);
  
      // Dibujar el cuadrado
      rect(x, y, tam, tam);
    }
  }
}
