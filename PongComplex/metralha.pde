
void metralha() {

  if (metralhaDir == true) {
    stroke(255);
    colideAmmoA();
    for (int i = kb; i < ammoQuant-1; i++) {
      ammoB[i].x = width-bdis-10;
      ammoB[i].y = pb;
    }

    for (int j = 0; j < kb+1; j++) {
      if (kb == ammoQuant-1) {
        metralhaDir = false;
        kb = 0;
      }
      if (j == 0 && kb == 0) {
        kb++;
      }
      ammoB[j].x-=tiroV;
      strokeWeight(3);
      point(ammoB[j].x, ammoB[j].y, 2);
      strokeWeight(1);
      stroke(255);
    }

    timerDir++;
    if (timerDir > guntime) {
      timerDir = 0;
      kb++;
    }
  }


  if (metralhaEsq == true) {
    stroke(255);
    colideAmmoB();
    for (int i = ka; i < ammoQuant-1; i++) {
      ammoA[i].x = bdis+10;
      ammoA[i].y = pa;
    }

    for (int j = 0; j < ka+1; j++) {
      if (ka == ammoQuant-1) {
        metralhaEsq = false;
        ka = 0;
      }
      if (j == 0 && ka == 0) {
        ka++;
      }
      ammoA[j].x+=tiroV;
      strokeWeight(3);
      point(ammoA[j].x, ammoA[j].y, 2);
      strokeWeight(1);
      stroke(255);
    }

    timerEsq++;
    if (timerEsq > guntime) {
      timerEsq = 0;
      ka++;
    }
  }
}


void colideAmmoA() {
  for (int i = 0; i < ammoQuant-1; i++) {
    if (ammoB[i].y > pa - bas/2 && ammoB[i].y < pa + bas/2 && ammoB[i].x < bdis + bthic/2 && ammoB[i].x > bdis - bthic/2) {
      ammoB[i].x=0;
      ammoB[i].y=0;
      bas-=tiroTiraVida;
    }
  }
}

void colideAmmoB() {
  for (int i = 0; i < ammoQuant-1; i++) {
    if (ammoA[i].y > pb - bbs/2 && ammoA[i].y < pb + bbs/2 && ammoA[i].x > width - bdis - bthic/2 && ammoA[i].x < width - bdis + bthic/2) {
      ammoA[i].x=width;
      ammoA[i].y=height;
      bbs-=tiroTiraVida;
    }
  }
}
