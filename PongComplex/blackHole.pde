
void desenhaBlackHole() {
  if (dist(bolaPos.x, bolaPos.y, blackHole.x, blackHole.y) < bhDis) {
    PVector grav = new PVector(blackHole.x - bolaPos.x, blackHole.y - bolaPos.y);
    grav.normalize();
    grav.div(dist(blackHole.x, blackHole.y, bolaPos.x, bolaPos.y) / g);
    bolaDir.add(grav);
  }
  stroke(100);
  circle(blackHole.x, blackHole.y, blackS);
  circle(blackHole.x, blackHole.y, blackG);
  blackS--;
  blackG--;
  if (blackS < 1) {
    blackS = bhDis;
  }
  if (blackG < 1) {
    blackG = 100;
  }
  ///segundo bleck
  if (dist(bolaPos.x, bolaPos.y, antBH.x, antBH.y) < bhDis) {
    PVector grav = new PVector(antBH.x - bolaPos.x, antBH.y - bolaPos.y);
    grav.normalize();
    grav.div(dist(antBH.x, antBH.y, bolaPos.x, bolaPos.y) / g);
    bolaDir.add(grav);
  }
  stroke(100);
  float a = blackS;//map(blackS, 1, 100, 100, 1);
  float b = blackG;//map(blackG, 1, 100, 100, 1);
  circle(antBH.x, antBH.y, a);
  circle(antBH.x, antBH.y, b);
}


void blackSpawn() {//spawner dos buracos negros
  blackHole.x=random(bdis*5, width-bdis*5);
  blackHole.y=random(bdis, height-bdis);

  if (blackHole.x<width/2) {
    antBH.x=random(width/2, width-bdis*5);
  } else {
    antBH.x=random(bdis*5, width/2);
    antBH.y=random(bdis, height-bdis);
  }
  if (blackHole.y<height/2) {
    antBH.y=random(height/2, height-bdis);
  } else {
    antBH.y=random(bdis, height/2);
  }
}
