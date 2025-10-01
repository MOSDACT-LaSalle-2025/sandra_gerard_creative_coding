class Clouds{
  // Variables para la cuadricula y el tamaño
  int cloudGridWidth = 37;
  int cloudGridHeight = 7;
  int minPixelSize = 2;
  int maxPixelSize = 15;
  
  boolean active=false;
  
  // Colores degradados base
  color baseDark = color(50, 20, 100);
  color baseMedium = color(100, 50, 150);
  color baseLight = color(50, 100, 200);
  
  ArrayList<CloudData> cloudsData;
  
  // Clase nubes
  class CloudData {
    float x, y;
    int width, height;
    int pixelSize;
    int[][] shape;
  
    CloudData(float x, float y, int w, int h, int pSize) {
      this.x = x;
      this.y = y;
      this.width = w;
      this.height = h;
      this.pixelSize = pSize;
      this.shape = generateRandomShape();
    }
  
    // Regenerar 
    void regenerateShape() {
      this.shape = generateRandomShape();
    }
  }
  
  Clouds(){
  
    cloudsData = new ArrayList<CloudData>();
  
    int maxAttempts = 500;
    int numClouds = 30;
  
    for (int i = 0; i < numClouds; i++) {
      int attempts = 0;
      boolean placed = false;
  
      while (!placed && attempts < maxAttempts) {
        int randomPixelSize = int(random(minPixelSize, maxPixelSize + 1));
        int cloudWidth = cloudGridWidth * randomPixelSize;
        int cloudHeight = cloudGridHeight * randomPixelSize;
  
        float randomX = random(width);
        float randomY = random(height);
  
        boolean overlapping = false;
        for (CloudData existingCloud : cloudsData) {
          if (dist(randomX, randomY, existingCloud.x, existingCloud.y) < 200) {
            overlapping = true;
            break;
          }
        }
  
        if (!overlapping) {
          cloudsData.add(new CloudData(randomX, randomY, cloudWidth, cloudHeight, randomPixelSize));
          placed = true;
        }
        attempts++;
      }
    }
  }
  
  void display() {
    //background(50, 150, 200);
  
    for (CloudData cloud : cloudsData) {
      // Mover la nube
      cloud.x -= 1;
  
      // Si la nube sale de la pantalla, resetea
      if (cloud.x < - (cloud.width)) {
        cloud.x = width;
        cloud.y = random(height);
        cloud.regenerateShape(); // Nueva forma al reaparecer
      }
  
      drawCloud(cloud.x, cloud.y, cloud.pixelSize, cloud.shape);
    }
  }
  
  // ==========================
  // Dibujo Nube
  // ==========================
  void drawCloud(float startX, float startY, int pixelSize, int[][] cloudShape) {
    for (int row = 0; row < cloudGridHeight; row++) {
      for (int col = 0; col < cloudGridWidth; col++) {
        if (cloudShape[row][col] == 1) {
          float rowNormalized = map(row, 0, cloudGridHeight - 1, 0, 1);
          color interpolatedColor;
  
          if (rowNormalized < 0.5) {
            interpolatedColor = lerpColor(baseDark, baseMedium, rowNormalized * 2);
          } else {
            interpolatedColor = lerpColor(baseMedium, baseLight, (rowNormalized - 0.5) * 2);
          }
  
          fill(interpolatedColor);
          noStroke();
          rect(startX + col * pixelSize, startY + row * pixelSize, pixelSize, pixelSize);
        }
      }
    }
  }
  
  // ==========================
  // Función para generar una forma de nube más aleatoria
  // ==========================
  int[][] generateRandomShape() {
    int[][] shape = new int[cloudGridHeight][cloudGridWidth];
    float centralX = cloudGridWidth / 2.0;
    float centralY = cloudGridHeight / 2.0;
  
    for (int y = 0; y < cloudGridHeight; y++) {
      for (int x = 0; x < cloudGridWidth; x++) {
        float distToCenter = dist(x, y, centralX, centralY);
        // Reduce la probabilidad en las esquinas para un perfil más orgánico
        float probability = map(distToCenter, 0, cloudGridWidth / 2.0, 1.0, 0.2);
  
        if (random(1) < probability) {
          shape[y][x] = 1;
        } else {
          shape[y][x] = 0;
        }
      }
    }
    return shape;
  }
}
