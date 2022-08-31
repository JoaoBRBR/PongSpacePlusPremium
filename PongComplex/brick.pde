
void parede() {//logica da paredinha

  if (muroDir == true) {//direita
    fill(255, 255, 0);
    int soma=0;
    for (int i=0; i<brickAmount; i++) {
      int check=0;
      float x = (width/2)+bdis;
      float y = i*(height/brickAmount)+(height/brickAmount)/2;
      float s = (height/brickAmount);
      if (brickAliveA[i]) {
        check = 1;
      } else {
        check = 0;
      }
      soma = soma + check;
      if (brickAliveA[i]) {
        if (bolaPos.y > y-s/2  && bolaPos.y < y+s/2 && bolaPos.x < x+s/2 && bolaPos.x > x-s/2) {
          bolaDir.x*=-1;
          brickAliveA[i] = false;
        }
        rect(x, y, s, s);
      }
    }
    if (soma == 0) {
      muroDir=false;
      brickResetA();
    }
    noFill();
  }


  if (muroEsq == true) {//esquerda
    fill(255, 255, 0);
    int soma=0;
    for (int i=0; i<brickAmount; i++) {
      int check=0;
      float x = (width/2)-bdis;
      float y = i*(height/brickAmount)+(height/brickAmount)/2;
      float s = (height/brickAmount);
      if (brickAliveB[i]) {
        check = 1;
      } else {
        check = 0;
      }
      soma = soma + check;
      if (brickAliveB[i]) {
        if (bolaPos.y > y-s/2  && bolaPos.y < y+s/2 && bolaPos.x < x+s/2 && bolaPos.x > x-s/2) {
          bolaDir.x*=-1;
          brickAliveB[i] = false;
        }
        rect(x, y, s, s);
      }
    }
    if (soma == 0) {
      muroEsq=false;
      brickResetB();
    }
    noFill();
  }
}
