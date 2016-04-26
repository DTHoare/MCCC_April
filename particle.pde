class Particle {
  
  //variables
  //movement
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxSpeed;
  float maxForce;
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
    life = 100;
    maxSpeed = 10;
    maxForce = 2;
    
    int int1 = (int)random(3);
    int int2 = (int1 + (int)random(1,3))%4;
    lineColour = colors[int1];
    fillColour = colors[int2];
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
  
  void getAttracted(Mass a) {
    PVector force = PVector.sub(a.position, position);
    float mag = force.mag();
    if(mag > 0) {
      force.normalize();
      force.div(mag*mag);
      force.mult(a.mass);
      applyForce(force);
    }
  }
  
  void getRepelled(Mass b) {
    PVector force = PVector.sub(position, b.position);
    float mag = force.mag();
    if(mag > 0) {
      force.normalize();
      force.div(mag*mag);
      force.mult(b.mass);
      applyForce(force);
    }
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
    acceleration.add(force.copy().limit(maxForce).div(mass));
  }
  
  void applyImpulse(PVector force) {
    //apply an unlimited force as an acceleration
    acceleration.add(force.copy().div(mass));
  }
}