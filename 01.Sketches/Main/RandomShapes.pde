class RandomShapes {
  final int NUM_PARTICULAS = 400;  
  ArrayList<PuntoLuz> particulas;
  
  RandomShapes(){
    particulas = new ArrayList<PuntoLuz>();
    for (int i = 0; i < NUM_PARTICULAS; i++) {
      particulas.add(new PuntoLuz());
    } 
  }
  
  void display(){
    blendMode(ADD); 
    noStroke();
    fill(0, 0, 0, 40);
    rect(0, 0, width, height);
    for (PuntoLuz p : particulas) {
      p.mover();
      p.mostrar();
    }
  }
}

class PuntoLuz {
  PVector posicion;  // Vector de posición (x, y)
  PVector velocidad; // Vector de velocidad (movimiento)
  float brillo;      // Almacena el valor de brillo/opacidad (Alpha)
  float tamano;      // Tamaño del punto
  
  // Constructor
  PuntoLuz() {
    // Posición inicial aleatoria
    posicion = new PVector(random(width), random(height));
    
    // Velocidad inicial pequeña y aleatoria
    velocidad = PVector.random2D(); // Vector aleatorio 2D
    velocidad.mult(random(0.5, 1.5)); // Escala la velocidad

    // ⭐ MODIFICACIÓN 1: Tamaño más pequeño para que parezcan puntos
    // Rango de 0.5 a 2.0 para puntos muy pequeños
    tamano = random(0.5, 2.0); 
    
    // Brillo inicial (será cambiado en draw)
    brillo = 0;
  }

  // Método para actualizar la posición y el brillo
  void mover() {
    // Aplica la velocidad a la posición
    posicion.add(velocidad);

    // Rebote simple en los bordes para mantener la partícula en pantalla
    if (posicion.x < 0 || posicion.x > width) {
      velocidad.x *= -1; 
      posicion.x = constrain(posicion.x, 0, width); 
    }
    if (posicion.y < 0 || posicion.y > height) {
      velocidad.y *= -1; 
      posicion.y = constrain(posicion.y, 0, height); 
    }
    
    // Calcula el brillo basado en una función sinusoidal para el parpadeo
    float ruido = noise(posicion.x * 0.01, posicion.y * 0.01 + frameCount * 0.01);
    brillo = map(sin(frameCount * 0.05 + ruido * 10), -1, 1, 100, 255); 
    
    // Opcional: añade un ligero cambio de velocidad para un movimiento más orgánico
    velocidad.add(PVector.random2D().mult(0.01));
    velocidad.limit(2);
  }

  // Método para dibujar la partícula
  void mostrar() {
    noStroke();
    
    // ⭐ MODIFICACIÓN 2: Halo de resplandor mucho más pequeño o casi nulo
    // Esto hace que el "punto" sea más dominante que su halo.
    fill(100, 150, 255, brillo / 8); // Color azul suave y muy transparente (brillo / 8)
    ellipse(posicion.x, posicion.y, tamano * 1.2, tamano * 1.2); // Multiplicador muy bajo (1.2 o 1.5)
    
    // El núcleo de luz (el "punto" brillante)
    fill(150, 200, 255, brillo); // Color azul brillante con opacidad variable
    ellipse(posicion.x, posicion.y, tamano, tamano);
  }
}
