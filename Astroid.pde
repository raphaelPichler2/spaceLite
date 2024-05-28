class Astroid{

  float posX, posY;
  float speedX, speedY;
  float size;
  float angle;
  
  Astroid(){
    size=30+15*(int)Math.abs(1.3*randomGaussian());
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    float speed = 1.5;
    if(gameMode==1)speed = 2.1;
    speedX=getSpeedX(r,speed);
    speedY=getSpeedY(r,speed);
    angle=random(TWO_PI);
    astroids.add(this);
  }
  
  void draw(){
    posX=posX+speedX;
    posY=posY+speedY;
    turnImg(komet1I,posX,posY,size*2,size*2,angle);
  }
  
  void checkDistances(int index){
    if(posX>1300 || posX<-100 || posY>1100 || posY<-100)astroids.remove(this);
    if(ship != null && distance(ship.posX,ship.posY,posX,posY)<(size+ship.size)/2)inGame=false;
    for(int i=1+index;i<astroids.size();i++){
      if( distance(astroids.get(i).posX,astroids.get(i).posY,posX,posY) < (astroids.get(i).size+size)/2)explode(astroids.get(i));
    }
  }
  
  void explode(Astroid a){
    astroids.remove(this);
    astroids.remove(a);
    float pellets= 6;
    for(int i=0;i<pellets;i++){
      float speedX = 2.4*cos(TWO_PI/pellets*i);
      float speedY = 2.4*sin(TWO_PI/pellets*i);
      Bullet b = new Bullet((posX+a.posX)/2 + 7*speedX,(posY+a.posY)/2 + 7*speedY, speedX, speedY, 16);
      b.playerB=false;
    }
  }
  
  void getHit(Bullet b){
    size-=15*b.dmg;
    if(size<30)astroids.remove(this);
    else{
      float weigth=size/15;
      speedX+=b.speedX/weigth;
      speedY+=b.speedY/weigth;
    }
  }
}
abstract class MapExtras{
  float posX, posY;
  float speedX, speedY;
  float size;
  float angle;
  
  abstract void checkDistances();
  abstract void draw();
  abstract void getHit();
}

class BombenFass extends MapExtras{
  
  BombenFass(){
    size=50;  
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    speedX=getSpeedX(r,1.5);
    speedY=getSpeedY(r,1.5);
    angle=random(TWO_PI);
    mapExtras.add(this);
  }
  
  void checkDistances(){
    if(distance(600,500,posX,posY)>2000)mapExtras.remove(this);
  }
  void draw(){
    posX=posX+speedX;
    posY=posY+speedY;
    angle+=TWO_PI/120 /2;
    turnImg(bombfassI,posX,posY,size*2,size*2,angle);
  }
  void getHit(){
    mapExtras.remove(this);
    float pellets = 16;
    for(int i=0;i<pellets;i++){
      float speedX = 3*cos(TWO_PI/pellets*i);
      float speedY = 3*sin(TWO_PI/pellets*i);
      Bullet b = new Bullet(posX + 14*speedX,posY + 14*speedY, speedX, speedY, 16);
      b.playerB=false;
    }
  }
}

class TowerField{
  float posX;
  float posY;
  float size;
  boolean nextShot;
  
  TowerField(float posX,float posY){
    size = 40;
    this.posX=posX;
    this.posY=posY;
    
    towers.add(this);
  }
  void draw(){
    image(towerBaseI,posX,posY,size*2,size*2);
    turnImg(towerBarrelI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,mouseX,mouseY));
    
    if(ship.nextAttack+0.5 >= 120/ship.attackspeed){
      if(true){
      nextShot=false;
      float distance = distance(posX,posY,mouseX,mouseY);
      float speedX =ship.bulletSpeed*(mouseX-posX)/distance;
      float speedY =ship.bulletSpeed*(mouseY-posY)/distance;
      Bullet b = new Bullet(posX,posY, speedX, speedY, 12);
      b.weak=true;
      }else nextShot=true;
    }
  }
}
