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

void setup() {
  size(540,540);
  emitter = new Emitter(width/2, height/2);
  background(yellow);
  frameRate(30);
  randomSeed(55);
}

void draw() {
  //reset frame 
  background(yellow);
  if(frameCount % 80 ==0) {
    //allow for looping
    randomSeed(55);
  }
  
  for(int i = 0; i < 50; i++) {
    //create intial force for particles
    float angle = random(0,2*PI);
    float magnitude = 25;
    PVector force = new PVector(cos(angle),sin(angle));
    force.mult(magnitude);
    
    //create particles and deal with them
    if(frameCount % 80 < 30) {
      emitter.addParticle(force);
    }
  }
  
  emitter.runParticles();
  
  saveFrames2(80);
}

//save first n frames
void saveFrames(int n) {
  if(frameCount <= n) {
    saveFrame("frame_###.png");
  }
}

//save third set of n frames
//allows loops to reach stability
void saveFrames2(int n) {
  if(frameCount > (2*n) && frameCount <= (3*n)) {
    saveFrame("frame_###.png");
  }
}