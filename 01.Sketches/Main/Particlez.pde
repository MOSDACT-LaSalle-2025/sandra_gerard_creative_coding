// Aqui prueba de jugar con el ppf (particles per frame) y alpha. Dentro de la clase Particle, puedes jugar con mass y lifetime.

class Particlez{
  ArrayList<Particle> particles;
  Attractor attractor;
  int ppf = 100;
  int maxParticles = 10000;
  int margin = 25;
  float alpha = 0;
  
  Particlez(){
    particles = new ArrayList<Particle>();
    attractor = new Attractor(0.01, 0.08);  // play with values  background(0);
  }
  
  void reset(){
    background(0);
    particles.clear();
  }
  
  void display(){
    fill(0, 0, 0, alpha);  // black with low alpha
    noStroke();
    rect(0, 0, width, height);
    
    for(int i=0; i<ppf; i++){ 
      if(particles.size()>=maxParticles) { particles.remove(0); }
      particles.add(new Particle(int(random(width)), int(random(height)))); 
    }
    
    for(int i=0; i<particles.size(); i++) {
      attractor.attract(particles.get(i));
      particles.get(i).update();
      particles.get(i).display();
      if(particles.get(i).life <= 0) {particles.remove(i);}
    }
  }
  
  
  class Particle {
    PVector position;
    PVector velocity;
    PVector acceleration;
    float mass = 5;
    float lifetime = 5;
    float life;
    float radius=1;
    
    Particle(int x, int y) {
      position = new PVector(x,y);
      velocity = new PVector(0, 0);
      acceleration = new PVector(0, 0);
      life = lifetime;
    }
    
    void applyForce(PVector force){
      // F = ma -> a = F/m
      PVector f = force.copy().div(mass);
      acceleration.add(f);
    }
    
    void update(){
      velocity.add(acceleration);
      position.add(velocity);
      position.set(constrain(position.x,0+margin, width-margin), constrain(position.y, 0+margin, height-margin));
      acceleration.mult(0); 
    }
    
    void display(){
      float t = constrain(life / lifetime, 0, 1);
    
      // Gradient colors from the album art palette
      color c1 = color(186, 143, 202); // lavender
      color c2 = color(123, 63, 148);  // plum
      color c3 = color(136, 180, 255); // sky blue
    
      // Interpolate in two stages: lavender→plum→sky blue
      color c;
      if (t > 0.5) {
        c = lerpColor(c1, c2, map(t, 0.5, 1.0, 0, 1));
      } else {
        c = lerpColor(c2, c3, map(t, 0.0, 0.5, 0, 1));
      }

      noFill();
      stroke(c);
      strokeWeight(radius);
      point(position.x, position.y);
      life -= 1/frameRate;
    }
  }
  
  
  class Attractor {
    float scale;
    float strength;
    
    Attractor(float scale, float strength){
      this.scale = scale;
      this.strength = strength;
    }
    
    void attract(Particle particle){
      // sample noise at particle position
      float nx = noise(particle.position.x * scale, particle.position.y * scale);
      float ny = noise(particle.position.y * scale, particle.position.x * scale);
      
      // map [0,1] noise -> [-1,1] direction
      PVector force = new PVector(nx - 0.5, ny - 0.5);
      force.normalize();
      force.mult(strength);
      
      particle.applyForce(force);
    }
  }  
}
