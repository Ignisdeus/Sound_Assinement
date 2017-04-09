
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

  if (average>0.01f) { //this shrinks the sun if you play the guitar
    sun-=0.25;
    //println("music");
  } else {
    //println("silence");
  }
  ai.enableMonitoring();

  if (stage2Timer>1000) {
    text("Increase the strength", 50, 100);
    text("of the BlackHole", 50, 120);
    text("with the power of music!", 50, 140);
    if (average>0.01f) {
      grow+=0.5f;
      blackRadius+=1f;
    }
  }
  if (average>0.01f) {
    xAngle+=speedAngle;
    zAngle+=speedZAngle;
  }
  if(freq>=1184 && average>0.01f){
    triPoint=0;
    lg=0;
  }
  if(average>0.1f){  //play the b strong on 12 up to get effect!
    cTestR=random(255);
    cTestG=random(255);
    cTestB=random(255);
  }
    println(average);
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

void first() {  //stage 2

  frequency();
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
}

void visual() {
  frequency();
  mainxAngle+=mainSpeedAngle;
  //zAngle+=speedZAngle;
  pushMatrix(); //this is the main sphere
  translate(triMidX, triMidY);
  rotateX(mainxAngle);
  rotateY(mainxAngle);
  rotateZ(mainxAngle);
  noFill();
  //stroke(255, 0, 0);
    stroke(cTestR,cTestG,cTestB);
  strokeWeight(0.5);
  sphere(test);  //////////////////////////////  the main sphere 355
  test=lerp(test, 356, 0.05);
  //println(test);

  popMatrix();

  for (int i=0; i<5; i++) {  //was 5
    //the pyramid
    triPoint=lerp(triPoint, 201, 0.005);
    float newTri=((triPoint-(i*65)));  //was triPoint/i;

    if (i==0) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=220;
      gColor2=2;
      bColor2=255;
    }
    if (i==1) {
      rColor=255;
      gColor=243;
      bColor=2;
      rColor2=13;
      gColor2=2;
      bColor2=255;
    }
    if (i==2) {
      rColor=132;
      gColor=255;
      bColor=2;
      rColor2=255;
      gColor2=255;
      bColor2=255;
    }
    if (i==3) {
      rColor=2;
      gColor=255;
      bColor=236;
      rColor2=2;
      gColor2=255;
      bColor2=297;
    }
    if (i==4) {
      rColor=255;
      gColor=255;
      bColor=255;
      rColor2=213;
      gColor2=255;
      bColor2=2;
      strokeWeight(1);
    }




    //stroke(0, 255, 255);  
    stroke(rColor, gColor, bColor);  //for pyramid
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
    rotateX(-xAngle);
    rotateY(-xAngle);
    rotateZ(-xAngle);
    noFill();
    //stroke(255, 255, 0);
    stroke(rColor2, gColor2, bColor2);//for sphere
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
    sphere(lg-(65*i));//(spSize/i));   //35 works well   ///////////////////// lg=200

    popMatrix();
    //println(lg-(65*i));
  }

  //println(frameRate);
}