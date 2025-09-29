class Birds{
  int nbirds;
  ArrayList<Bird> birds;
  int npoints;
   float min_dist = 75;
  final float margin = 1;
  float alpha;
  
  Birds(){
    birds = new ArrayList<Bird>();
    ArrayList<PVector> points = poissonDisc(min_dist, 30, margin);
    nbirds = points.size();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      birds.add(new Bird(p.x, p.y));
    }
    background(0);
  }
  
  void reset(){
    colorMode(RGB);
    birds.clear();
    ArrayList<PVector> points = poissonDisc(min_dist, 30, margin);
    nbirds = points.size();
    for (int i = 0; i < points.size(); i++) {
      PVector p = points.get(i);
      birds.add(new Bird(p.x, p.y));
    }
  }
  
  void display(int param){
    alpha = map(param, 0, 8, 100, 0);
    fill(0,alpha);
    noStroke();
    pushMatrix();
    translate(0,0);
    rect(0,0,width,height);
    popMatrix();
    for(int i=0; i<birds.size(); i++) {
      birds.get(i).display();
    }
  }
}


// SINGLE BIRD CLASS
class Bird{
  float posx, posy;
  float wingspan_r;
  float wingspan_theta = QUARTER_PI;
  float angle;
  PVector wingpos;
  float speed_mult;
  float offset;
  float life;
  color c;
  
  
  Bird(float x, float y){
    posx = x;
    posy = y;
    wingpos = new PVector(cos(wingspan_theta)*wingspan_r, sin(wingspan_theta)*wingspan_r);
    offset = random(-QUARTER_PI,QUARTER_PI);
    speed_mult = random(0.02,0.075);
    wingspan_r = random(80,100);
    c = color(random(200,240), 200, 255);
  }
  
  void display() {
    noFill();
    stroke(c);
    strokeWeight(1);
    pushMatrix();
    translate(posx, posy);
    
    // nº segments per wing
    int segments = 12;
    float wingLength = wingspan_r;
  
    beginShape();
    
    // Left wing (from left to body)
    for (int i = segments; i >= 0; i--) {
      float t = i/float(segments);
  
      // Lag: points farther from body flap later
      float lag = map(t, 0, 1, 0.0, 0.4);
      float flap = sin(frameCount * speed_mult + offset - lag * TWO_PI);
      if (flap > 0) flap *= 0.6; else flap *= 1.4;
  
      float localAngle = flap * wingspan_theta;
  
      float x = lerp(0, -cos(localAngle) * wingLength, t);
      float y = lerp(0,  sin(localAngle) * wingLength, t);
  
      y -= sin(t * PI) * 3; // wing bend
  
      vertex(x, y);
    }
  
    // --- Body point ---
    vertex(0, 0);
  
    // --- Right wing (from body to tip) ---
    for (int i = 0; i <= segments; i++) {
      float t = i / float(segments);
  
      float lag = map(t, 0, 1, 0.0, 0.4);
      float flap = sin(frameCount * speed_mult + offset - lag * TWO_PI);
      if (flap > 0) flap *= 0.6; else flap *= 1.4;
  
      float localAngle = flap * wingspan_theta;
  
      float x = lerp(0, cos(localAngle) * wingLength, t);
      float y = lerp(0, sin(localAngle) * wingLength, t);
  
      y -= sin(t * PI) * 3;
  
      vertex(x, y);
    }
  
    endShape(); // not CLOSED!
    wingspan_r -= 0.2;
    if(wingspan_r<-400){wingspan_r=400;}
    popMatrix();
  }
}


// POISSON DISC SAMPLING
ArrayList<PVector> poissonDisc(float r, int k, float margin) {
  ArrayList<PVector> points = new ArrayList<PVector>();
  ArrayList<PVector> active = new ArrayList<PVector>();
  
  PVector first = new PVector(random(width), random(height));
  points.add(first);
  active.add(first);
  
  while (!active.isEmpty()) {
    int randIndex = int(random(active.size()));
    PVector point = active.get(randIndex);
    boolean found = false;
    
    for (int n = 0; n < k; n++) {
      float angle = random(TWO_PI);
      float mag = random(r, 2*r);
      float nx = point.x + cos(angle) * mag;
      float ny = point.y + sin(angle) * mag;
      PVector newPoint = new PVector(nx, ny);
      
      if (nx >= margin && nx < width - margin && ny >= margin && ny < height - margin) {
        boolean ok = true;
        for (PVector p : points) {
          if (dist(nx, ny, p.x, p.y) < r) {
            ok = false;
            break;
          }
        }
        if (ok) {
          points.add(newPoint);
          active.add(newPoint);
          found = true;
          break;
        }
      }
    }
    
    if (!found) {
      active.remove(randIndex);
    }
  }
  
  return points;
}
