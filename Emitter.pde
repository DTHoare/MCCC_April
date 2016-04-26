class Emitter{
  
  //variables
  PVector position;
  
  //hold a bunch of particles that are emitted
  ArrayList<Particle> particles;
  
  Emitter(float x_, float y_) {
    position = new PVector(x_,y_);
    particles = new ArrayList<Particle>();
  }
  
  void addParticle() {
    //create and add a new particle 
    Particle p = new Particle(position.x, position.y);
    particles.add(p);
  }
  
  void addParticle(PVector force) {
    //create and add a new particle 
    Particle p = new Particle(position.x, position.y);
    p.applyImpulse(force);
    particles.add(p);
  }
  
  void runParticles() {
    //update and display particles
    //dead particles are to be removed
    //iterator allows particles to removed while iterating
    Iterator<Particle> iterator = particles.iterator();
    
    while (iterator.hasNext() ) {
      Particle p = iterator.next();
      p.run();
      if (p.isDead() ) {
        iterator.remove(); 
      }
    }
  }
  
  void runParticles(Mass a, Mass r) {
    //update and display particles
    //dead particles are to be removed
    //iterator allows particles to removed while iterating
    Iterator<Particle> iterator = particles.iterator();
    
    while (iterator.hasNext() ) {
      Particle p = iterator.next();
      p.getAttracted(a);
      p.getRepelled(r);
      p.run();
      if (p.isDead() ) {
        iterator.remove(); 
      }
    }
  }
  
}