class Particle {
  
  //variables
  //movement
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float angle;
  
  //particle properties
  float size;
  float mass;
  float life;
  color lineColour;
  color fillColour;
  
  Particle(float x_, float y_) {
    //initaite properties
    position = new PVector(x_,y_);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    angle = 0;
    
    mass = random(2,9);
    size = mass;
    life = 120;
    maxSpeed = 10;
    
    lineColour = colors[(int)random(4)];
    fillColour = colors[(int)random(4)];
  }
  
  void display() {
    //display particle as a square
    fill(fillColour);
    stroke(lineColour);
    rectMode(CENTER);
    
    //rotate as it moves
    pushMatrix();
    translate(position.x,position.y);
    //update angle as it moves
    angle += velocity.mag()/50;
    rotate(angle);
    rect(0,0,size,size);
    popMatrix();
  }
  
  void update() {
    //cascade down movement updates and reset frame acceleration
    velocity.add(acceleration);
    velocity.limit(maxSpeed);
    position.add(velocity);
    acceleration.mult(0);
    
    //lower life
    life -=1;
  }
  
  void run() {
    //perform all actions a particle must take
    update();
    display();
  }
  
  boolean isDead() {
    //check if particle is dead for removal
    if ( life <= 0) {
      return true;
    } else {
      return false;
    }
  }
  
  void applyForce(PVector force) {
    //apply a force as an acceleration
    acceleration.add(force.copy().div(mass));
  }
}