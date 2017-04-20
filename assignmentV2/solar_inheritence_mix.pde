//setting stuff up as an inheritence for the solar mix
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//AudioInput in;

AudioPlayer beatMusic;
//AudioSample myMusic;
AudioPlayer myMusic;
//black hole engulfing the solar system

//Drawing a solar system for the visual effects
//working but not fully done yet

float hWidth, hHeight;
PFont soundFont, playFont; 


void setup() {
  //fullScreen(P3D);
  size(1028, 768, P3D);
  ////////////////////////////mw///////////
  rectMode(CENTER);
  soundFont = createFont("Sound-Sample.ttf", 150);

  playFont = createFont("PartTwo.ttf", 50);
  boxX = width/2;
  boxY = height/3;
  boxSize = width-1;
  lineMaxHieght = height-200;
  varation= 50;
  objects. add(new Speaker(boxX+50, boxY-30));
  float range=0.05f;
  for (int i =0; i< title.length; i++) {

    titleY[i] = (boxY+ boxSize * 0.05f);
    inc[i] = range * i ;
  }
  lineSpaceing = (width* 0.5) /7;

  for (int i =0; i < 7; i++) {
    //320, 600
    areaOne[i] = new PVector(320 +(lineSpaceing * i), 600);
    areaSpawn[i] = new PVector(320 +(lineSpaceing * i), - 50);
  }

  hudX = width- 170;
  hudY = height* 0.30f;
  killLine= height-170;



  ////////////////////////////////
  //for ther black hole
  minim=new Minim(this);
  beatMusic=minim.loadFile("beat.mp3");
  //myMusic = minim.loadSample("myMusicWav2.wav");
  myMusic = minim.loadFile("myMusicWav2.wav");
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

  blackHole=new PVector(width/2, height/2);


  halfHeight=height/2;

  ///lerp colours for the visuals
  first=color(255, 0, 0); //red
  second=color(0, 255, 0);//lightish green
  third=color(190, 80, 120);//darkish purple
  fourth=color(0, 255, 255);// turquoise
  fifth=color(255, 255, 255);//white
  sixth=color(255, 243, 2); //yellow
  seventh=color(220, 2, 255); //purple kjnm
  eight=color(255, 0, 155); // hbkj
  ninth=color(233, 120, 13); //orange 
  tenth=color(0, 255, 178); //dark read (maroon)
  special1=color(255, 185, 0);
  special2=color(0, 197, 255);
  special3=color(32, 175, 64);
  special4=color(136, 228, 255);
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


int stage=0;
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

///lerp colours for the visuals


float nRate=0, nRate2=0, nRate3=0, nRate4=0, nRate5=0; 
float rate1=0.002, rate2=0.005, rate3=0.0025, rate4=0.0125, rate5=0.028, specialRate=0.01, rate6;
color first, second, third, fourth, fifth, sixth, seventh, eight, ninth, tenth, special1, special2, special3, special4;

color sphereColor;
color pyramidColor;





///these are for tests
float test=0;

float cTestR=255;
float cTestG=0;
float cTestB=0;

/////////////////mw
ArrayList<Objects> objects = new ArrayList<Objects>();
ArrayList<Objects> gameObjects = new ArrayList<Objects>();
//for collsion points :)
ArrayList<Objects> gameBadGuy = new ArrayList<Objects>();
int level =0;
///////////////////////
//to detect each string\\
float[] allFreq={172, 215, 301, 387, 409, 473, 645, 796};
String[] guitarNotes={"E", "A", "D", "G", "gCheat", "B", "e", "gCheat"};

///controlling the songs
float beatTimer;
float beatTimerSpeed=1.5;
float myMusicTimer;
float myMusicTimerSpeed=1.5;



String spell(float freq) {
  float minDiff=10000;
  int minIndex=-1;

  for (int i=0; i<allFreq.length; i++)
  {
    float diff=abs(freq-allFreq[i]);
    if (diff<minDiff) {
      minDiff=diff;
      minIndex=i;
    }
  }
  return guitarNotes[minIndex];
}



///MW
void keyReleased() {

  canPress =true;
}
///////////////
void draw() {
  background(0);
  //stage1 the solar system has its own music
  //stage=0;
  println(blackRadius);
  if (stage == 0) {
    intro();
  }

  if (stage == 1) {
    shooterLevel();
  }
  if (score>=10) {
    stage=5;
  }
  if (stage ==2) {
    reset();
  }

  if (stage==5) {
    first();
  }

  //stage 2 the growth of the black hole and the infinite pyramid. might have its own music
  if (stage==6) {
    pushMatrix();
    translate(width/2, height/2);
    visual();
    popMatrix();
  }
  //stage 3
  //the cubes play guitar and the suck back in, background changes colour after each beat
  //has its own music
}

float radius=0;
float planetRadius=0;
float circleRadius = 0;


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
 
 
 Stages.
 0 is the intro screen.
 1 is the duck shooter without the guitar
 2 is the duck shooter with the guitar
 3 is the visualisation representaion of music part 1
 4 is the visualisation representaion of music part 2
 5 is the visualisation representaion of music part 3
 6 is the visualisation representaion of music part 4
 7: is the end screen
 
 
 
 
 */