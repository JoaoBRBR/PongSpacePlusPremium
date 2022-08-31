
void powerUp() {
  //grow
  stroke(0, 255, 0);
  circle(grow.x, grow.y, powerGrow*bolaS);
  stroke(255);
  if (dist(bolaPos.x, bolaPos.y, grow.x, grow.y) < powerGrow*bolaS) {
    comPowerUp = true;
    grow.x=random(bdis*5, width-bdis*5);
    grow.y=random(bdis, height-bdis);
  }
  if (comPowerUp && colisaoEsq) {
    comPowerUp = false;
    bas+=growSize;
  }
  if (comPowerUp && colisaoDir) {
    comPowerUp = false;
    bbs+=growSize;
  }

  //trow
  stroke(255, 0, 0);
  circle(trow.x, trow.y, powerFire*bolaS);
  stroke(255);
  if (dist(bolaPos.x, bolaPos.y, trow.x, trow.y) < powerFire*bolaS) {
    metralha = true;
    trow.x=random(bdis*5, width-bdis*5);
    trow.y=random(bdis, height-bdis);
  }
  if (metralha && colisaoEsq) {
    metralha = false;
    metralhaEsq = true;
  }
  if (metralha && colisaoDir) {
    metralha = false;
    metralhaDir = true;
  }
  if (!(muroDir && muroEsq)) {
    //brick
    stroke(255, 255, 100);
    circle(brick.x, brick.y, powerBrick*bolaS);
    stroke(255);
    if (dist(bolaPos.x, bolaPos.y, brick.x, brick.y) < powerBrick*bolaS) {
      muro = true;
      brick.x=random(bdis*5, width-bdis*5);
      brick.y=random(bdis, height-bdis);
    }
  }
  if (muro && colisaoEsq) {
    muro = false;
    muroEsq = true;
  }
  if (muro && colisaoDir) {
    muro = false;
    muroDir = true;
  }
}
