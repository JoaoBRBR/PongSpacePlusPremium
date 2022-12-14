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

void setup() {
  size(900, 500,P2D);//tamanho

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

void draw() {
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

void UI() {
  textSize(width/30);
  text(pontoA, 2*bdis, bdis);
  text(pontoB, width-2*bdis, bdis);
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

void keyPressed() {
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
