//imports
import java.util.*;

//colour pallette
color darkRed = #530c0c;
color red = #8f0e0e;
color orange = #fa7e0a;
color yellow = #f7f6de;
color[] colors = {darkRed, red, orange, yellow};

//variables
Emitter emitter;
Mass attractor;
Mass repellor;
int seed = 43564;

void setup() {
  size(540,540);
  emitter = new Emitter(0.51*width, 0.52*height);
  attractor = new Mass(0.5*width, 0.5*height, 58000);
  repellor = new Mass(0.51*width, 0.52*height, 15000);
  background(yellow);
  frameRate(30);
  randomSeed(seed);
}

void draw() {
  //reset frame 
  //background(yellow);
  if(frameCount % 30 ==0) {
    //allow for looping
    randomSeed(seed);
  }
  
  for(int i = 0; i < 1; i++) {
    //create intial force for particles
    float angle = random(0,2*PI);
    float magnitude = 34;
    PVector force = new PVector(cos(angle),sin(angle));
    force.mult(magnitude);
    
    //create particles and deal with them
    if(frameCount % 30 < 30) {
      emitter.addParticle(force);
    }
  }
  
  emitter.runParticles(attractor, repellor);
  
  saveFrames2(30, 10);
}

//save first n frames
void saveFrames(int n) {
  if(frameCount <= n) {
    saveFrame("frame_###.png");
  }
}

//save ith set of n frames
//allows loops to reach stability
void saveFrames2(int n, int i) {
  if(frameCount > ((i-1)*n) && frameCount <= (i*n)) {
    saveFrame("frame_###.png");
  }
}