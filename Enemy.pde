class Enemy{
  float posX, posY;
  float speedX, speedY;
  float speed;
  float size;
  float angle;
  float hp;
  int strength=1;
  boolean shield = false;
  
  Enemy(){
    hp=1;
    float r=random(4400);
    if(r<1200){
      posX=r;
      posY=-100;
    }else if(r<2400){
      posX=r-1200;
      posY=1100;
    }else if(r<3400){
      posX=-100;
      posY=r-2400;
    }else if(r<4400){
      posX=1300;
      posY=r-3400;
    }
    if(random(100)<3*(difficulty-4)){
      hp=hp+1;
      shield=true;
    }
    enemies.add(this);
  }
  
  void getHit(float dmg){
    hp -= dmg;
    if(shield)shield=false;
    else{ if(size>100){
        size-=5;
      }else{
        size-=10;
      }
    }
    if(hp<1){
      enemies.remove(this);
      score+=5*scoreMulti;
    }
  }
  
  void draw(){
  }
  
  void checkDistances(){
    if(distance(ship.posX,ship.posY,posX,posY)<(size+ship.size)/2)inGame=false;
  }
}

class redShip extends Enemy{
  
  redShip(){
    super();
    speed = 1.6;
    size=26;
    while(random(100)>1000/difficulty){
      if(size<100)size+=10;
      else size+=5;
      hp=hp+1;
      strength++;
    }
  }
  
  void draw(){
    float distance = distance(posX,posY,ship.posX,ship.posY);
    speedX = speed*(ship.posX-posX)/distance;
    speedY = speed*(ship.posY-posY)/distance;
    posX = posX+speedX;
    posY = posY+speedY;
    
    turnImg(redShipI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,ship.posX, ship.posY));
    if(shield) turnImg(enemShieldI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,ship.posX, ship.posY));
  }
}

class blueShip extends Enemy{
  float nextShot;
  
  blueShip(){
    super();
    speed = 0.8;
    size=26;
    while(random(100)>1000/difficulty){
      if(size<100)size+=10;
      else size+=5;
      hp=hp+1;
      strength++;
    }
    nextShot=60.0/strength + 30;
  }
  
  void draw(){

    float distance = distance(posX,posY,ship.posX,ship.posY);
    speedX = speed*(ship.posX-posX)/distance;
    speedY = speed*(ship.posY-posY)/distance;
    posX = posX+speedX;
    posY = posY+speedY;
    turnImg(blueShipI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,ship.posX, ship.posY));
    if(shield) turnImg(enemShieldI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,ship.posX, ship.posY));
    
    if(nextShot<=0){
      
      float bSpeedX =4*(ship.posX-posX)/distance;
      float bSpeedY =4*(ship.posY-posY)/distance;
      Bullet b = new Bullet(posX,posY, bSpeedX, bSpeedY, 13);
      b.playerB = false;
      b.enemyB = true;
      b.size+= 3 * strength;
      nextShot=240.0 / strength;
    }else nextShot--;
  }
}
