//setting stuff up as an inheritence for the solar mix
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//AudioInput in;

//black hole engulfing the solar system

//Drawing a solar system for the visual effects
//working but not fully done yet

void setup() {
  //fullScreen(P3D);
  size(1028, 768, P3D);
  //for ther black hole
  minim=new Minim(this);
  //in = minim.getLineIn();
  //in.setGain(1);

  ai=minim.getLineIn(Minim.STEREO, frameSize, sampleRate, resolution);

  fft=new FFT(frameSize, sampleRate);
  //////////////////////////////////////////////////////////////////////
  //for the inheritance thingy\\
  for (int i=0; i<5; i++) {
    Earth e= new Earth(width/2+(600), height/2, -500);
    planets.add(e);
    Mars m=new Mars(width/2+(100), height/2, 0);
    planets.add(m);
    Merc merc=new Merc(width /2+(250), height/2, 0);
    planets.add(merc);
    Venus v= new Venus(width/2, height/2+(350), 0);
    planets.add(v);
  }


  /////////////////////////////////////////////////

  cx=width/2;
  cy=height/2;
  middleX=width/2;
  middleY=height/2;
  for (int i=0; i<300; i++) { // 20 150
    Stars s=new Stars();
    stars.add(s);
  }
  solarPos=new PVector(width/2, height/2);



  //earthpos=new PVector(width/2+(600), height/2, -500);
  blackHole=new PVector(width/2, height/2);
  //earthFoward=new PVector();
  //marsFoward=new PVector();
  //mercFoward=new PVector();
  //venFoward=new PVector();
  //marspos=new PVector(width/2+(100), height/2);
  //mercpos=new PVector(width /2+(250), height/2); 
  //venpos=new PVector(width/2, height/2+(350));

  halfHeight=height/2;
}


//variables for the sound and frequency stuff\\
Minim minim;
FFT fft;
AudioInput ai;
int sampleRate=44100;
int resolution = 16;
float thereshold=0.2;
float halfHeight;
int frameSize=2048;
float eRadius;
float numBands=10.0f;
///for inheritence thingy
ArrayList<Planets>planets=new ArrayList<Planets>();


//for the black hole./////////////////////////
float middleX, middleY;
float cx, cy;
float theta=0;
float grow=39;
float rate=0.05;
ArrayList<Stars>stars=new ArrayList<Stars>();
/////////////////////////////////////////
float sx;

float stest;
float sun=255, earth=155, mars=125, mercury=20, venus=100;
//float shrink2=0.5;
float shrinkRate2=0.005;     


//timers
float timer;
float timerSpeed=1.5;

//vectors
PVector solarPos;//=new PVector(width/2,height/2);
PVector blackHole;
float blackRadius=50;


int stage;
float stage2Timer;
float stage2TimerSpeed=1.5;

//stuff for the visual effects sphere and pyramid
//mid points
float triMidX;
float triMidY;
float spMidY;


float spMidX;


float xAngle;
float speedAngle=0.005;

float mainxAngle;
float mainSpeedAngle=0.005;

float zAngle;
float speedZAngle=0.015;


float triPoint=0; //200


float spSize=70;
float lg= 0;

float rColor, gColor, bColor, rColor2, gColor2, bColor2;

///these are for tests
float test=0;

float cTestR=255;
float cTestG=0;
float cTestB=0;

void draw() {
  background(0);
  //stage1 the solar system has its own music
  //first(); 
  //stage 2 the growth of the black hole and the infinite pyramid. might have its own music
  pushMatrix();
  translate(width/2,height/2);
  visual();
  popMatrix();

  //stage 3
  //the cubes play guitar and the suck back in, background changes colour after each beat
  //has its own music

}

float radius=0;

/*
the sun has to shrink iside the blackhole
 PVectors doesnt work in this case for some reason. another way is 1) use lerp
 or 2)make the solar system a class.
 
 idea 1)Make a pop up text saying make some noise to shrink the sun into the black hole
 2)if sun = 0 then play more to allign the planets back and suck them in aswell.
 the shrinking works fine, just wont work with all of them at the same time.
 two ways of fixing, 1) make 4 new variables for shrink for each planet (noobish move)
 2)make a class out of this (more advanced)
 3)make the inheritence code (expert) checked
 4)do the beat detector thingy that patrick did
 */