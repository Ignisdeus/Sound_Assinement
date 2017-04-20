

int boxSize, boxX, boxY;
char[] title = {'R', 'e', 'a', 'l', ' ', 'B', 'e', 'a', 't', 's'};
float[] titleY = new float[title.length]; 
float [] inc = new float[title.length];
float thetaIntro = 0.0f, varation;

void intro() {
  beatTimer+=beatTimerSpeed;
  if (beatTimer>0 && beatTimer<=3000) {
    beatMusic.play();
  }
  if (beatTimer>3000 && beatTimer<3002) {
    beatMusic.rewind();
    beatTimer=0;
  }

  noStroke();
  noFill();
  rect(boxX, boxY, boxSize, boxSize/3);

  //println(objects.size());

  for (int i =0; i < objects.size(); i ++) {
    Objects c;
    c = objects.get(i);
    stroke(255);
    fill(255);
    c.render();
    c.update();
  }


  yCalulation();
  for ( int i =0; i < title.length; i ++) {
    textFont(soundFont);
    textSize(150);
    textAlign(LEFT);
    int mod = 70 *i;
    text(title[i], (boxX - boxSize * 0.25f ) + mod, titleY[i]  );
  }
  textFont(playFont);
  textSize(75 + change);
  noFill();
  //rect(width/2, height* 0.82f, 200, 100);
  textAlign(CENTER, CENTER);
  text("Play", width/2, height* 0.7f);
  if (change < 0) {
    scaleUp =true;
  }
  if (change > 50) {
    scaleUp =false;
  }
  if (mouseX > width/2 - collisonBox/2
    && mouseX < width/2 + collisonBox/2
    && mouseY > (height* 0.7f) - ((collisonBox/2)/2)
    && mouseY < (height* 0.7f) + ((collisonBox/2)/2)) {



    if (scaleUp == true) {
      change ++;
    } else {
      change --;
    }

    if (mousePressed == true) {
      stage =1;
    }
  } else if ( change > 0) {
    change--;
  }
}
float change = 0, collisonBox = 200;
boolean scaleUp = true;
void yCalulation() {

  theta += 0.02f;

  // For every x value, calculate a y value with sine function
  float x = theta;
  for (int i = 0; i < titleY.length; i++) {

    x+=inc[i];
    titleY[i] =  (boxY+ boxSize * 0.05f) + sin(x)*varation;
  }
}

float lineSpaceing, lineMaxHieght;
float miniLine = 30;
PVector[] areaOne = new PVector[7];
PVector[] areaSpawn = new PVector[7];
char[] notes = {'E', 'A', 'D', 'G', 'B', 'e', 'g'};
float speed = 1.0f, spawnTimer, killLine ;

//Audio restart after you play a note
float restartA, restartB, restartC, restartD, restartE, restartF, restartG;

void shooterLevel() {
  shooterHud();
  frequency();
  beatTimer+=beatTimerSpeed;
  if (beatTimer>0 && beatTimer<=3000) {
    beatMusic.play();
  }
  if (beatTimer>3000 && beatTimer<3002) {
    beatMusic.rewind();
    beatTimer=0;
  }

  if (speed > 10) {
    speed =10;
  }

  spawnTimer ++;
  if (spawnTimer > 60 -speed) {
    spawnTimer =0;
    int dice = (int)random(0, 7);
    PVector toUse = areaSpawn[dice];
    gameBadGuy.add(new BadGuy(toUse.x, toUse.y, speed));
  }

  for (int i =0; i < gameBadGuy.size(); i ++) {
    Objects c;
    c = gameBadGuy.get(i);
    c.render();
    c.update();
  }
  for ( float i =lineSpaceing *3; i < width * 0.75f; i += lineSpaceing) {

    for ( int d =0; d < lineMaxHieght; d += miniLine) {
      boolean changer = true; 
      if (changer ==true) {
        stroke(255);
      } else {
        stroke(0);
      }
      line(i, d, i, d + miniLine/2);
    }
  }
  textFont(playFont);
  fill(255, 0, 0);
  ellipse( lineSpaceing *6.5f, killLine, 700, 20);

  for (int i =0; i < 7; i++) {
    fill(255);
    text(notes[i], areaOne[i].x, areaOne[i].y);
  }
  text(notes[0], areaOne[0].x, areaOne[0].y);
  for (int i =0; i < gameObjects.size(); i ++) {
    Objects c;
    c = gameObjects.get(i);
    stroke(255);
    fill(255);
    c.render();
    c.update();
  }
  if (killLineB == true) {
    killer();
  }
  if ( life ==0) {
    reset();
  }

  //////////////////////////////////////////////////////// 
  if (keyPressed ==true) {  
    if (key == 'a' && canPress ==true|| key == 'A' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[0].x, areaOne[0].y));

      restartA++;
      //Anote.play();
    }
    if (key == 'b' && canPress ==true|| key == 'B' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[1].x, areaOne[1].y));

      restartB++;
      //Bnote.play();
    }
    if (key == 'c' && canPress ==true|| key == 'C' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[2].x, areaOne[2].y));

      restartC++;
      //Cnote.play();
    }
    if (key == 'd' && canPress ==true|| key == 'D' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[3].x, areaOne[3].y));

      restartD++;
      //Dnote.play();
    }
    if (key == 'e' && canPress ==true|| key == 'E' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[4].x, areaOne[4].y));

      restartE++;
      //Enote.play();
    }
    if (key == 'f' && canPress ==true|| key == 'F' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[5].x, areaOne[5].y));

      restartF++;
      //Fnote.play();
    }
    if (key == 'g' && canPress ==true|| key == 'G' && canPress ==true) {
      canPress = false; 
      gameObjects.add(new Bullet(areaOne[6].x, areaOne[6].y));

      restartG++;
      //Gnote.play();
    }
  }
  if (restartA>=1) {
    //Anote.rewind();
    restartA=0;
  }

  if (restartB>=1) {
    //Bnote.rewind();
    restartB=0;
  }

  if (restartC>=1) {
    //Cnote.rewind();
    restartC=0;
  }
  if (restartD>=1) {
    //Dnote.rewind();
    restartD=0;
  }
  if (restartE>=1) {
    //Enote.rewind();
    restartE=0;
  }
  if (restartF>=1) {
    //Fnote.rewind();
    restartF=0;
  }
  if (restartG>=1) {
    //Gnote.rewind();
    restartG=0;
  }
  ////////////////////////////////////////////////////////////////////////////////
}
boolean canPress = true; 

int combo =0, score =0, life =1;

void hit() {

  speed += 0.2f;
  combo ++;

  if ( combo > 0) {
    score += 10 * combo;
  } else {
    score += 10;
  }
}
void miss(String c) {

  if (c == "BadGuy") {
    combo =0;
    speed = 1.0f;
    //life --;
  }

  if (c == "Bullet") {
    combo =0;
  }
}
boolean killLineB =false;
float hudX, hudY, hudSize = 400;
void shooterHud() {
  fill(255);
  rect(hudX, hudY, hudSize * 0.75f, hudSize);
  fill(0);
  rect(hudX, hudY, hudSize * 0.74f, hudSize * 0.99f);
  fill(255);
  textAlign(CENTER, CENTER);
  text("Score: " + score, hudX, hudY - hudSize * 0.45f );
  text("Combo X : " + combo, hudX, hudY - hudSize * 0.25f );

  for (int i =0; i < life; i++) {

    rect((hudX - hudSize * 0.25f) + (50 *i), hudY + hudSize * 0.25f, 40, 40);
  }
}

void killer() {

  killLine -= 10;

  if (killLine < -50) {
    killLine = height -170;
    killLineB =false;
  }
}

void reset() {

  score =0;
  life=1;
  while ( gameBadGuy.size() >0) {
    gameBadGuy.remove(0);
  }
  killLine = height -170;
  killLineB =false;
  stage =0;
}