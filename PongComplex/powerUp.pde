
void powerUp() {
  //grow
  stroke(0, 255, 0);
  circle(grow.x, grow.y, 6*bolaS);
  stroke(255);
  if (dist(bolaPos.x, bolaPos.y, grow.x, grow.y) < 6*bolaS) {
    comPowerUp = true;
    grow.x=random(bdis*5, width-bdis*5);
    grow.y=random(bdis, height-bdis);
  }
  if (comPowerUp && colisaoEsq) {
    comPowerUp = false;
    bas+=40;
  }
  if (comPowerUp && colisaoDir) {
    comPowerUp = false;
    bbs+=40;
  }
  
  //trow
  stroke(255, 0, 0);
  circle(trow.x, trow.y, 6*bolaS);
  stroke(255);
  if (dist(bolaPos.x, bolaPos.y, trow.x, trow.y) < 6*bolaS) {
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
}
