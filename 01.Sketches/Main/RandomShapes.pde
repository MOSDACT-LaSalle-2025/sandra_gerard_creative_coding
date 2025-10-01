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
  PVector posicion;  
  PVector velocidad; 
  float brillo;
  float tamano;
  
  // Constructor
  PuntoLuz() {
    posicion = new PVector(random(width), random(height));
    
    velocidad = PVector.random2D(); // Vector aleatorio 2D
    velocidad.mult(random(1000, 1200)); 

    tamano = random(0.5, 2.0); 
    
    brillo = 0;
  }

  // Posicion y brillo
  void mover() {
    // Velocidad a posicion
    posicion.add(velocidad);

    // Rebote mantiene particulas en pantalla
    if (posicion.x < 0 || posicion.x > width) {
      velocidad.x *= -1; 
      posicion.x = constrain(posicion.x, 0, width); 
    }
    if (posicion.y < 0 || posicion.y > height) {
      velocidad.y *= -1; 
      posicion.y = constrain(posicion.y, 0, height); 
    }
    
    //Parpadeo
    float ruido = noise(posicion.x * 0.01, posicion.y * 0.01 + frameCount * 0.01);
    brillo = map(sin(frameCount * 0.05 + ruido * 10), -1, 1, 100, 255); 
    
   
    velocidad.add(PVector.random2D().mult(0.01));
    velocidad.limit(2);
  }

  // Particula
  void mostrar() {
    noStroke();
    
    
   
    fill(100, 150, 255, brillo / 8); 
    ellipse(posicion.x, posicion.y, tamano * 1.2, tamano * 1.2);
    
    // Punto brillante 
    fill(150, 200, 255, brillo); 
    ellipse(posicion.x, posicion.y, tamano, tamano);
  }
}
