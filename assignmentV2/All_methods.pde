
//////////////////////////


///my work//
void blackHole() { //black hole works
  tint(255, 128); 
  fill(255);
  stroke(255);
  ellipse(middleX, middleY, blackRadius, blackRadius); //white
  fill(0);
  stroke(0);
  grow+=rate;
  ellipse(blackHole.x, blackHole.y, grow, grow); //the black hole.
  if (grow>blackRadius-2) {
    rate=-0.05;
  }
  if (grow<blackRadius-11) {
    rate=+0.05;
  }

  for (int i=0; i<13; i++) { //to rotate the circles in the black hole
    theta+=0.001;
    float x=cx+sin(theta+(i*0.5))*22;
    float y=cy-cos(theta+(i*0.5))*22;
    fill(0);
    ellipse(x, y, 5, 5);
  }


  // println(stars.size());
}

/////////////////////////////////////////////////////////////////////////////////
void frequency() {
  //float min=100;
  //float minimaverage=0;
  //float mid=height/2.0f;
  float total=0;
  for (int i=0; i<ai.bufferSize()-1; i++) {
    //minimaverage+=Math.abs(in.left.get(i));
    total+=abs(ai.left.get(i));
  }
  float average=total/ai.bufferSize();
  radius=lerp(radius, average, 0.1f);
  //float target=min+minimaverage*mid;
  //radius=lerp(radius,target,0.0001f);
  //ellipse(radius,250,10,10);
  fft.window(FFT.HAMMING);
  fft.forward(ai.left);

  float maxEnergy=0;
  int maxBin=-1;
  for (int i=0; i<fft.specSize(); i++) { 
    float energy= fft.getBand(i);
    if (energy>maxEnergy) {
      maxEnergy=energy;
      maxBin=i;
    }
  }
  float freq=fft.indexToFreq(maxBin);

  textSize(16);
  text("Frequency: " + freq, 10, 50);
if(stage==5){
  if (average>0.01f) { //this shrinks the sun if you play the guitar
    sun-=0.25;
    //println("music");
  }
}
  else {
    //println("silence");
  }
  ai.enableMonitoring();

  if (stage2Timer>1000 && blackRadius<width) { //shows text
    text("Increase the strength", 50, 100);
    text("of the BlackHole", 50, 120);
    text("with the power of music!", 50, 140);
  }
  if (stage2Timer>1000) { //as you play the guitar the blackhole increases in size
    if (average>0.01f) {
      grow+=1f;
      blackRadius+=1f;
    }
  }
  if (blackRadius>width) {
    stage=2;
  }
  if (average>0.01f) {
    xAngle+=speedAngle;
    zAngle+=speedZAngle;
    ////this is to control the lerp colurs for the visuals
    nRate+=rate1; 
    nRate3+=rate3; 
    nRate5+=rate5;
    nRate2+=rate2;
    nRate4+=rate4;
    specialRate+=rate5;
    if (nRate>1) {
      rate1-=0.001;
    } else if (nRate<0.01) {
      rate1+=0.001;
    }

    if (nRate2>1) {
      rate2-=0.005;
    } else if (nRate2<0.01) {
      rate2+=0.005;
    }

    if (nRate3>1) {
      rate3-=0.0025;
    } else if (nRate3<0.01) {
      rate3+=0.0025;
    }

    if (nRate4>1) {
      rate4-=0.0125;
    } else if (nRate4<0.01) {
      rate4+=0.0125;
    }

    if (nRate5>1) {
      rate5-=0.028;
    } else if (nRate5<0.01) {
      rate5+=0.028;
    }
    if (specialRate>1) {
      rate6-=0.001;
    } else if (specialRate<0.01) {
      rate6+=0.001;
    }
  }


  if (freq>=1184 && average>0.01f) {
    circleRadius=0;
    triPoint=0;
    lg=0;
  }
  if (average>0.1f) {  //play the b strong on 12 up to get effect!
    cTestR=random(255);
    cTestG=random(255);
    cTestB=random(255);
  }
  //println(average);


  ///for the shooter level
  
  if (average>0.03f) {
    println("Spell: " + spell(freq));
    println("Music");
  } else {
    println("silence");
  }

  if (spell(freq)=="E" && average>0.3) { //make sure the guitar is on ryhtme and not on treble for this to work
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[0].x, areaOne[0].y));

    restartE++;
  }
    if (spell(freq)=="A" && average>0.1) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[1].x, areaOne[1].y));

    restartA++;
  }
    if (spell(freq)=="D" && average>0.1) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[2].x, areaOne[2].y));

    restartD++;
  }
    if (spell(freq)=="G" && average>0.2) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[3].x, areaOne[3].y));

    restartG++;
  }
    if (spell(freq)=="B" && average>0.1) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[4].x, areaOne[4].y));

    restartB++;
  }
    if (spell(freq)=="e" && average>0.1) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[5].x, areaOne[5].y));

    restartF++;  //it is actually e
  }
  
    if (spell(freq)=="gCheat" && average>0.1) {
    canPress = false; 
    gameObjects.add(new Bullet(areaOne[6].x, areaOne[6].y));

    restartG++;
  }
}
/////////////////////////////////////////////////////////////////////////////////////

void solarSyetm() {
  //camera(mouseX, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);//some intersting results with the camera.
  sx+=0.005;
  stest+=0.05;
  pushMatrix();
  translate(solarPos.x, solarPos.y);
  rotateX(sx);
  rotateY(sx);
  rotateZ(sx);
  noStroke();
  fill(255, 190, 2);
  sphere(sun); //355 //the sun
  popMatrix();
}





void first() {  //stage 5
  
  frequency();
  //muting beatMusic, playing my music
  if(stage==5){
    if(beatTimer>0){
    beatMusic.rewind();
    beatTimer=0;
    }
    beatMusic.setGain(-100);
  }
    if(stage==5){
  myMusicTimer+=myMusicTimerSpeed;
  
  if(myMusicTimer<0){
    
  myMusic.play();
  
  }
    }

  //float total2=0;  //doesnt work!
  //for(int i=0; i<myMusic.bufferSize(); i++){
  //  total2+=abs(myMusic.left.get(i));
  //}
  //float average3 = total2 /myMusic.bufferSize();
  //planetRadius=lerp(planetRadius,average3,0.1f);
  
  
  //stage1 the solar system
  if (venus<=10) {
    for (int i=0; i<stars.size(); i++) {//the other red planets
      Stars s=stars.get(i);
      s.update();
      s.render();
    }
    stage2Timer+=stage2TimerSpeed;
  }

  timer+=timerSpeed;
  if (sun<=0) {
    sun=0; //sun size stays at 0
  }

  blackHole();
  solarSyetm();
  //for inheritence stuff
  for (int i=0; i<planets.size(); i++) {
    Planets p=planets.get(i);
    p.update();
    p.render();
  }

  text("stage2timer :" + stage2Timer, 250, 50);
  if(blackRadius>width){
   stage=6; 
  }
}




void visual() {
  frequency();
  mainxAngle+=mainSpeedAngle;

  color newColor=lerpColor(first, second, nRate);

  color newColor3=lerpColor(fifth, sixth, nRate3);
  color newColor4=lerpColor(seventh, eight, nRate4);
  color newColor5=lerpColor(ninth, tenth, nRate5);
  //for lerp color pyramids
  color newColorP3=lerpColor(fifth, sixth, nRate3);
  color newColorP5=lerpColor(second, fifth, nRate5);
  color specialColor=lerpColor(special1, special2, nRate5);
  color specialColor2=lerpColor(special4, special3, specialRate);

  float mid2 = height / 2.0f;

  float average2 = 0;

  //int count23 = 0;

  for (int i = 1; i < ai.bufferSize(); i ++) //in replaced with audioInput

  {

    line(i, mid2, i, mid2 + ai.left.get(i) * mid2);

    average2 += Math.abs(ai.left.get(i));
  }

  average2 /= ai.bufferSize();  

  float min2 = 100;    

  float target2 = min2+ average2 *53;//* mid23;

  circleRadius = lerp(circleRadius, target2, 0.1f);



  //zAngle+=speedZAngle;
  pushMatrix(); //this is the main sphere
  translate(triMidX, triMidY);
  rotateX(mainxAngle);
  rotateY(mainxAngle);
  rotateZ(mainxAngle);
  noFill();
  //stroke(255, 0, 0);
  stroke(cTestR, cTestG, cTestB);
  strokeWeight(0.5);
  //sphere(test);  //////////////////////////////  the main sphere 355
  //test=lerp(test, 356, 0.05);
  //println(test);
  sphere(circleRadius*3.5);

  popMatrix();

  for (int i=0; i<5; i++) {  //was 5
    //the pyramid
    triPoint=lerp(triPoint, 201, 0.005);
    //float newTri=((triPoint-(i*65)));  //was triPoint/i;
    float newTri=((circleRadius*2-(i*65)));
    if (i==0) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=220;
      gColor2=2;
      bColor2=255;
      pyramidColor=newColorP3;
      sphereColor=newColor3;
    }
    if (i==1) {
      rColor=255;
      gColor=243;
      bColor=2;
      rColor2=13;
      gColor2=2;
      bColor2=255;
      pyramidColor=specialColor2;
      sphereColor=newColor4;
    }
    if (i==2) {
      rColor=132;
      gColor=255;
      bColor=2;
      rColor2=255;
      gColor2=255;
      bColor2=255;
      pyramidColor=specialColor;  
      sphereColor=newColor;
    }
    if (i==3) {
      rColor=2;
      gColor=255;
      bColor=236;
      rColor2=2;
      gColor2=255;
      bColor2=297;
      pyramidColor=color(2, 255, 297);   
      sphereColor=color(2, 255, 236);
    }
    if (i==4) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=213;
      gColor2=255;
      bColor2=2;
      pyramidColor=newColorP5;
      sphereColor=newColor5;
      strokeWeight(1);
    }




    //stroke(0, 255, 255);  
    //stroke(rColor, gColor, bColor);  //for pyramid  good ones
    stroke(pyramidColor);
    pushMatrix();
    translate(triMidX, (triMidY)+(12*i), 0);  //was 12*i
    //stroke(255);
    rotateX(PI/2);
    //rotateX(x);
    //rotateY(y);
    //rotateZ(-PI/6);
    rotateZ(zAngle);
    beginShape();
    strokeWeight(1);
    ////////////////////////////////////////////////////////////////////////
    vertex(-newTri, -newTri, -newTri);
    vertex( newTri, -newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex( newTri, -newTri, -newTri);
    vertex( newTri, newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex( newTri, newTri, -newTri);
    vertex(-newTri, newTri, -newTri);
    vertex(   0, 0, newTri);

    vertex(-newTri, newTri, -newTri);
    vertex(-newTri, -newTri, -newTri);
    vertex(   0, 0, newTri);
    endShape();

    popMatrix();
    /////////////////////////////////////////////////////////////////

    pushMatrix();

    translate(spMidX, spMidY-(i*-20));
    if (i==0) { //this is purple
      translate(0, 50);
    }
    if (i==1) {
      translate(0, 20);
    }
    rotateX(-xAngle);
    rotateY(-xAngle);
    rotateZ(-xAngle);
    noFill();
    //stroke(255, 255, 0);
    //stroke(rColor2, gColor2, bColor2);//for sphere  good ones
    stroke(sphereColor);
    strokeWeight(0.5);
    if (i==0) {
      //strokeWeight(0.15);
    }
    if (i>3) {
      //strokeWeight((0.15-(i/3)));
      strokeWeight(0.005);
    }
    if (i==4) {
      //strokeWeight(0.15);
    }


    lg=lerp(lg, 201, 0.005);
    //sphere(lg-(65*i));//(spSize/i));   //35 works well   ///////////////////// lg=200
    sphere(circleRadius*2-(65*i));
    popMatrix();
    //println(lg-(65*i));
  }

  //println(frameRate);
}