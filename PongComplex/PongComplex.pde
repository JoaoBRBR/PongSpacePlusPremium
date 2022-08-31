///sobre a bolinha///
PVector bolaPos = new PVector(0, 0); //bola posição
PVector bolaDir = new PVector(0, 0); //bola direção
float v = 5;//velocidade bola
int bolaS = 10;//bola tamanho


///sobre as duas barrinhas////
float pa=0, pb=0, bx=0, by=0, bax=0, bay=0;//players
float qv = 6;//velocidade barra
int bs = 60;//barra tamanho
int bas = bs;//barra esq
int bbs = bs;//barra dir
int bdis = 40;//barra distancia da parede
int bthic = 15;//barra groçura
boolean colisaoEsq = false;//colisao na barra esquerda
boolean colisaoDir = false;//colisao na barra direita

///power ups///
int powerGrow= 6, powerFire=4, powerBrick=2;//tamanhos dos powerUps
int growSize = 40;
PVector grow = new PVector(0, 0);
PVector trow = new PVector(0, 0);
PVector brick = new PVector(0, 0);
boolean comPowerUp = false;
boolean muro = false;
boolean muroEsq = false;
boolean muroDir = false;
//tudo da arma
boolean metralha = false;
boolean metralhaEsq = false;
boolean metralhaDir = false;
int guntime = 10;
int timerDir = 0;
int timerEsq = 0;
int ka = 0;
int kb = 0;
int ammoQuant = 100;
int tiroV=10;
int tiroTiraVida=5;
PVector[] ammoA = new PVector[ammoQuant];
PVector[] ammoB = new PVector[ammoQuant];
//bricks
int brickAmount=20;
boolean[] brickAliveA = new boolean[brickAmount];
boolean[] brickAliveB = new boolean[brickAmount];


///buracos negros///
PVector blackHole = new PVector(0, 0);
PVector antBH = new PVector(0, 0);
PVector newDir = new PVector(0, 0);
float g = 5;//força gravidade
float bhDis = 200;//campo de influencia
float blackS = bhDis;//so pra animação do blackHole
float blackG = blackS/2;//so pra animação do blackHole


///rabinho da bola///
int raboSize = 30;
PVector[] rabo = new PVector[raboSize];


///para teclas simultaneas///
boolean[] keys;


///pontuacao///
int pontoA=0, pontoB=0;

///muda gravidade///
float gg = 0.1;
PVector gravida = new PVector();
boolean gravidaMesmo = false;
boolean gravidadeMuda = false;
int powerGravi = 3;//tamanho do powerup
int timeGrav = 0;//timer
int GravTime = 700;//limite do timer
///background///
int totaLinha = 20;
float[] linha = new float[totaLinha];//
float[] linhaV = new float[totaLinha];//

void setup() {
  size(900, 500, P2D);//tela
  ///valores independente de tela///
  float mw = width/100;
  float mh = height/100;
  qv = mw/1.5;//velocidade barra//////////////
  bs = int(7*mw);//barra tamanho
  growSize = int(2*mw);
  bas = bs;//barra esq
  bbs = bs;//barra dir
  bdis = int(7*mh);//barra distancia da parede
  bthic = int(3*mh);//barra groçura
  v = mw/2;//velocidade bola///////////////////
  bolaS = int(2.5*mh);//bola tamanho
  powerGrow= int(mw/2);
  powerFire= int(mw/3);
  powerBrick= int(mw/4);
  powerGravi = int(mw/4);//tamanho do powerup
  tiroTiraVida=int(mw/2);
  tiroV=int(mw);
  guntime = int(mw);
  g = mw/2;//força gravidade buraco negro
  gg = mw/180;//gravidade chao
  bhDis = int(20*mw);//campo de influencia
  ///...///
  keys=new boolean[4];//varias teclas
  keys[0]=false;
  keys[1]=false;
  keys[2]=false;
  keys[3]=false;

  bolaPos.x=width/2;//inicio da bola
  bolaPos.y=height/2;

  bolaDir = PVector.random2D();//direcao aleatoria
  bolaDir.setMag(v);

  pa = height/2;//barras no meio
  pb = height/2;

  blackSpawn();//spawnar buraco negro

  grow.x=random(bdis*5, width-bdis*5);//power ups posicao aleatora
  grow.y=random(bdis, height-bdis);

  trow.x=random(bdis*5, width-bdis*5);
  trow.y=random(bdis, height-bdis);

  brick.x=random(bdis*5, width-bdis*5);
  brick.y=random(bdis, height-bdis);

  gravida.x=random(bdis*5, width-bdis*5);
  gravida.y=random(bdis, height-bdis);

  bx=random(bdis*5, width-bdis*5);//barras do meio
  by=height;
  bax=random(bdis*5, width-bdis*5);
  bay=height;

  for (int i = 0; i< ammoQuant; i++) {//inicia municao
    ammoA[i] = new PVector(0, 0);
    ammoB[i] = new PVector(0, 0);
  }

  for (int i = 0; i< raboSize; i++) {//inicia rabo
    rabo[i] = new PVector(bolaPos.x, bolaPos.y);
  }
  rabo[0].set(bolaPos);

  for (int i = 0; i < brickAmount; i++) {//inicia barede de tijolos
    brickAliveA[i] = true;
    brickAliveB[i] =  true;
  }

  for (int i = 0; i < totaLinha; i++) {//inicia barede de tijolos
    linha[i] = i*(height/totaLinha);
    linhaV[i]=0;
  }

  noFill();
  stroke(255);
}

void draw() {
  background(10);
  gravida();
  powerUp();
  metralha();
  parede();
  bola();
  colisaoDirecao();
  colisaoParede();
  colisaoBarras();
  desenhaBarras();
  barraMeio();
  desenhaBlackHole();
  keyAperta();
  UI();
}

void gravida() {
  timeGrav++;
  if ((timeGrav > GravTime) && !gravidadeMuda) {
    timeGrav = 0;
    gravidaMesmo = true;
  }
  if (gravidaMesmo) {
    stroke(255, 0, 255);
    circle(gravida.x, gravida.y, powerGravi*bolaS);
    stroke(255);
    if (dist(bolaPos.x, bolaPos.y, gravida.x, gravida.y) < powerGravi*bolaS) {
      gravidadeMuda = true;
      gravidaMesmo = false;
      gravida.x=random(bdis*5, width-bdis*5);
      gravida.y=random(bdis, height-bdis);
    }
  }

  if (gravidadeMuda) {
    PVector grav = new PVector(0, gg);
    bolaDir.add(grav);
    stroke(60, 0, 60);
    for (int i = 0; i < totaLinha; i++) {//inicia barede de tijolos
      linhaV[i]+=grav.y/2;
      linha[i]+=linhaV[i];
      line(0, linha[i], width, linha[i]);
      if (linha[i] > height) {
        linha[i] = -linhaV[i];
        linhaV[i] = 0;
      }
    }
  } else {
    stroke(30, 0, 30);
    for (int i = 0; i < totaLinha; i++) {//inicia barede de tijolos
      line(0, linha[i], width, linha[i]);
    }
  }
  int ki = int(height/totaLinha);
  for (int i = 0; i < 2*ki; i++) {//inicia barede de tijolos
    line(i*ki, 0, i*ki, height);
  }
  stroke(255);
}


void UI() {
  textSize(width/20);
  text(pontoA, (width/2)-2*bdis, bdis);
  text(pontoB, (width/2)+2*bdis+4, bdis);
  for (int i=0; i<height; i+=30) {
    line(width/2, i, width/2, 10+i);
  }
}


void bola() {
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
    } else if (muro == true) {
      fill(255, 255, 100);
    } else {
      fill(255);
    }
  circle(bolaPos.x, bolaPos.y, bolaS);
  noFill();
  bolaPos.add(bolaDir);
}


void desenhaBarras() {
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


void colisaoDirecao() {
  if (colisaoEsq && keys[0]) {
    bolaDir.set(1, -1);
    bolaDir.setMag(v);
  } else if (colisaoEsq && keys[1]) {
    bolaDir.set(1, 1);
    bolaDir.setMag(v);
  } else if (colisaoDir && keys[2]) {
    bolaDir.set(-1, -1);
    bolaDir.setMag(v);
  } else if (colisaoDir && keys[3]) {
    bolaDir.set(-1, 1);
    bolaDir.setMag(v);
  }
}


void keyPressed() {
  if (key =='r') {
    resets();
    brickResetDois();
    pontoA=0;
    pontoB=0;
  }
  if (key =='t') {
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
void keyReleased() {
  if (key=='w')
    keys[0]=false;
  if (key=='s')
    keys[1]=false;
  if (keyCode==UP)
    keys[2]=false;
  if (keyCode==DOWN)
    keys[3]=false;
}
void keyAperta() {
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


void barraMeio() {
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
