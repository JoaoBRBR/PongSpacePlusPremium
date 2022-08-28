/* autogenerated by Processing revision 1277 on 2022-08-28 */
import processing.core.*;
import processing.data.*;
import processing.event.*;
import processing.opengl.*;

import java.util.HashMap;
import java.util.ArrayList;
import java.io.File;
import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

public class PongComplex extends PApplet {

float pa=0, pb=0, bx=0, by=0, bax=0, bay=0;//players

PVector bolaPos = new PVector(0, 0); //bola posição
PVector bolaDir = new PVector(0, 0); //bola direção
PVector blackHole = new PVector(0, 0);
PVector antBH = new PVector(0, 0);
PVector newDir = new PVector(0, 0);
PVector grow = new PVector(0, 0);
PVector trow = new PVector(0, 0);

int ammoQuant = 100;
int tiroV=10;
int tiroTiraVida=5;

PVector[] ammoA = new PVector[ammoQuant];
PVector[] ammoB = new PVector[ammoQuant];

int raboSize = 30;
PVector[] rabo = new PVector[raboSize];

float v = 5;//velocidade bola
float qv = 6;//velocidade barra
int bs = 60;//barra tamanho
int bolaS = 10;//bola tamanho
int bas = bs;
int bbs = bs;
int bdis = 40;//barra distancia da parede
int bthic = 15;//barra groçura
float g = 5;//força gravidade
float bhDis = 200;//campo de influencia
float blackS = bhDis;//so pra animação do blackHole
float blackG = blackS/2;//so pra animação do blackHole

boolean comPowerUp = false;
boolean metralha = false;
boolean metralhaEsq = false;
boolean metralhaDir = false;
boolean colisaoEsq = false;
boolean colisaoDir = false;

boolean[] keys;
/////////////////////////////////////////////

int guntime = 10;
int timerDir = 0;
int timerEsq = 0;

int ka = 0;
int kb = 0;

int pontoA=0, pontoB=0;

 public void setup() {
  /* size commented out by preprocessor */;//tamanho

  keys=new boolean[4];//varias teclas
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;

  bolaPos.x=width/2;
  bolaPos.y=height/2;

  bolaDir = PVector.random2D();
  bolaDir.setMag(v);

  pa = height/2;
  pb = height/2;

  blackSpawn();

  grow.x=random(bdis*5, width-bdis*5);
  grow.y=random(bdis, height-bdis);

  trow.x=random(bdis*5, width-bdis*5);
  trow.y=random(bdis, height-bdis);

  bx=random(bdis*5, width-bdis*5);
  by=height;
  bax=random(bdis*5, width-bdis*5);
  bay=height;

  for (int i = 0; i< ammoQuant; i++) {
    ammoA[i] = new PVector(0, 0);
    ammoB[i] = new PVector(0, 0);
  }
  for (int i = 0; i< raboSize; i++) {
    rabo[i] = new PVector(bolaPos.x, bolaPos.y);
  }
  rabo[0].set(bolaPos);

  noFill();
  stroke(255);
}

 public void draw() {
  background(10);
  powerUp();
  metralha();
  bola();
  colisaoParede();
  colisaoBarras();
  desenhaBarras();
  barraMeio();
  desenhaBlackHole();
  keyAperta();
  UI();
}

 public void UI() {
  textSize(width/30);
  text(pontoA, 2*bdis, bdis);
  text(pontoB, width-2*bdis, bdis);
  for (int i=0; i<height; i+=30) {
    line(width/2, i, width/2, 10+i);
  }
}

 public void bola() {
  //rabo
  rabo[0].set(bolaPos);
  for (int i=raboSize-1; i>=1; i--) {
    noStroke();
    fill(map(i, raboSize, 1, 0, 255));
    rabo[i].set(rabo[i-1]);
    circle(rabo[i].x, rabo[i].y, bolaS);
  }




  if (comPowerUp == true) {
    fill(0, 255, 0);
  } else
    if (metralha == true) {
      fill(255, 0, 0);
    } else {
      fill(255);
    }
  circle(bolaPos.x, bolaPos.y, bolaS);
  noFill();
  bolaPos.add(bolaDir);
}

 public void desenhaBarras() {
  rectMode(CENTER);
  stroke(255);
  fill(255);
  rect(bdis, pa, bthic, bas);
  rect(width-bdis, pb, bthic, bbs);
  rect(bx, by, bthic, bs);
  rect(bax, bay, bthic, bs);
  noFill();
  if (pa < bas/2) {
    pa = bas/2;
  } else if (pa > height-bas/2) {
    pa = height-bas/2;
  }
  if (pb < bbs/2) {
    pb = bbs/2;
  } else if (pb > height-bbs/2) {
    pb = height-bbs/2;
  }
}

 public void keyPressed() {
  if(key =='r'){
   resets();
   pontoA=0;
   pontoB=0;
  }
  if(key =='t'){
   resets();
  }
  if (key=='w')
    keys[0]=true;
  if (key=='s')
    keys[1]=true;
  if (keyCode==UP)
    keys[2]=true;
  if (keyCode==DOWN)
    keys[3]=true;
}
 public void keyReleased() {
  if (key=='w')
    keys[0]=false;
  if (key=='s')
    keys[1]=false;
  if (keyCode==UP)
    keys[2]=false;
  if (keyCode==DOWN)
    keys[3]=false;
}
 public void keyAperta() {
  if (keys[0]) {
    pa-=qv;
  } else if (keys[1]) {
    pa+=qv;
  }
  if (keys[2]) {
    pb-=qv;
  } else if (keys[3]) {
    pb+=qv;
  }
}


 public void barraMeio() {
  by-=v;
  bay+=v;
  if (bay > height+bs) {
    bay=-bs;
    bax=random(bdis*5, width-bdis*5);
  }
  if (by < -bs) {
    by=height;
    bx=random(bdis*5, width-bdis*5);
  }
}

 public void desenhaBlackHole() {
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
  ///anti bleck
  if (dist(bolaPos.x, bolaPos.y, antBH.x, antBH.y) < bhDis) {
    PVector grav = new PVector(antBH.x - bolaPos.x, antBH.y - bolaPos.y);
    grav.normalize();
    grav.div(dist(antBH.x, antBH.y, bolaPos.x, bolaPos.y) / g);
    bolaDir.sub(grav);
  }
  stroke(100);
  float a = map(blackS, 1, 100, 100, 1);
  float b = map(blackG, 1, 100, 100, 1);
  circle(antBH.x, antBH.y, a);
  circle(antBH.x, antBH.y, b);
}

 public void blackSpawn() {
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

 public void colisaoBarras() {
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

 public void colisaoParede() {//colisao e pontuação :)
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

 public void resets() {
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

 public void metralha() {

  if (metralhaDir == true) {
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
      stroke(0, 0, 255);
      circle(ammoB[j].x, ammoB[j].y, 2);
      stroke(255);
    }

    timerDir++;
    if (timerDir > guntime) {
      timerDir = 0;
      kb++;
    }
  }


  if (metralhaEsq == true) {
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
      stroke(0, 0, 255);
      circle(ammoA[j].x, ammoA[j].y, 2);
      stroke(255);
    }

    timerEsq++;
    if (timerEsq > guntime) {
      timerEsq = 0;
      ka++;
    }
  }
}


 public void colideAmmoA() {
  for (int i = 0; i < ammoQuant-1; i++) {
    if (ammoB[i].y > pa - bas/2 && ammoB[i].y < pa + bas/2 && ammoB[i].x < bdis + bthic/2 && ammoB[i].x > bdis - bthic/2) {
      ammoB[i].x=0;
      ammoB[i].y=0;
      bas-=tiroTiraVida;
    }
  }
}

 public void colideAmmoB() {
  for (int i = 0; i < ammoQuant-1; i++) {
    if (ammoA[i].y > pb - bbs/2 && ammoA[i].y < pb + bbs/2 && ammoA[i].x > width - bdis - bthic/2 && ammoA[i].x < width - bdis + bthic/2) {
      ammoA[i].x=width;
      ammoA[i].y=height;
      bbs-=tiroTiraVida;
    }
  }
}

 public void powerUp() {
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


  public void settings() { size(900, 500, P2D); }

  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "PongComplex" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}