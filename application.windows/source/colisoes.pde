
void colisaoBarras() {
  if (bolaPos.y > pa - bas/2 && bolaPos.y < pa + bas/2 && bolaPos.x < bdis + bthic/2 && bolaPos.x > bdis - bthic/2) {
    bolaDir.x *= -1 ;
    colisaoEsq = true;
  } else {
    colisaoEsq = false;
  }
  if (bolaPos.y > pb - bbs/2 && bolaPos.y < pb + bbs/2 && bolaPos.x > width - bdis - bthic/2 && bolaPos.x < width - bdis + bthic/2) {
    bolaDir.x *= -1 ;
    colisaoDir = true;
  } else {
    colisaoDir = false;
  }
  if (bolaPos.y > by - bs/2 && bolaPos.y < by + bs/2 && bolaPos.x > bx - bthic/2 && bolaPos.x < bx + bthic/2) {
    bolaDir.x *= -1 ;
  }
  if (bolaPos.y > bay - bs/2 && bolaPos.y < bay + bs/2 && bolaPos.x > bax - bthic/2 && bolaPos.x < bax + bthic/2) {
    bolaDir.x *= -1 ;
  }
}

void colisaoParede() {//colisao e pontuação :)
  if (bas<10) {
    pontoB++;
    resets();
  }
  if (bbs<10) {
    pontoA++;
    resets();
  }
  if (bolaPos.x > width) {
    resets();
    pontoA++;
  }
  if (bolaPos.x < 0) {
    resets();
    pontoB++;
  }
  if (bolaPos.y > height) {
    bolaPos.y--;
    bolaDir.y*=-1;
  } else if (bolaPos.y < 0) {
    bolaPos.y++;
    bolaDir.y*=-1;
  }
}

void resets() {
  kb=0;
  ka=0;
  bas = bs;
  bbs = bs;
  comPowerUp = false;
  metralha = false;
  metralhaEsq = false;
  metralhaDir = false;
  bolaDir = PVector.random2D();
  bolaDir.setMag(v);
  bolaPos.x=width/2;
  bolaPos.y=height/2;
  blackSpawn();
}
