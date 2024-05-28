class Bullet{
  float posX, posY;
  float speedX, speedY;
  float dmg;
  float size;
  boolean playerB;
  boolean enemyB;
  int explosive;
  boolean weak;
  boolean crit;
  
  Bullet(float posX,float posY, float speedX,float speedY,float size){
    this.posX = posX;
    this.posY = posY;
    this.speedX = speedX;
    this.speedY = speedY;
    this.size = size;
    playerB=true;
    enemyB = false;
    dmg=1;
    bullets.add(this);
  }
  
  void draw(){
    posX=posX+speedX;
    posY=posY+speedY;
    if(!playerB)fill(#FF6A24);
    else{
      fill(#4EB4B7);
      if(weak)fill(#4EB4B7);
    }
    color c = #4EB4B7;
    ellipse(posX,posY,size,size);
    if(dmg>1.5){
      fill(0);
      ellipse(posX,posY,size/2,size/2);
    }
  }
  
  void checkDistances(int index){
    
    if(ship != null && !playerB && distance(ship.posX,ship.posY,posX,posY)<(size+ship.size)/2.0)inGame=false;
    for(int i=0;i<astroids.size();i++){
      if(distance(astroids.get(i).posX,astroids.get(i).posY,posX,posY)<(astroids.get(i).size+size)/2.0){
        float aHp=astroids.get(i).size/15-1;
        astroids.get(i).getHit(this);
        dmg -= aHp;
        break;
      }
    }
    for(int i=0;i<mapExtras.size();i++){
      if(distance(mapExtras.get(i).posX,mapExtras.get(i).posY,posX,posY)<(mapExtras.get(i).size+size)/2.0){
        mapExtras.get(i).getHit();
        dmg=0;
        break;
      }
    }
    if(!enemyB){
      for(int i=0;i<enemies.size();i++){
        if(distance(enemies.get(i).posX,enemies.get(i).posY,posX,posY)<(enemies.get(i).size+size)/2.0){
          float eHp=enemies.get(i).hp;
          enemies.get(i).getHit(dmg);
          dmg -= eHp;
          break;
        }
      }
    }
    for(int i=index+1;i<bullets.size();i++){
      if(distance(bullets.get(i).posX,bullets.get(i).posY,posX,posY)<(bullets.get(i).size+size)/2.0 && !(playerB && bullets.get(i).playerB)){
        float bHp=bullets.get(i).dmg;
        bullets.get(i).dmg -= dmg;
        dmg -= bHp;
        break;
      }
    }
    if(posX>1200 || posX<0 || posY>1000 || posY<0){
      if(explosive<=0) bullets.remove(this);
      else{
        explosive--;
        if(posX>1200 || posX<0)speedX*=-1;
        else speedY*=-1;
      }
    }
    if(dmg<1)bullets.remove(this);
  }
}

class MoonB extends Bullet{
  float angle;
  float distance;
  float speed;
  
  MoonB(){
    super(ship.posX,ship.posY-40, 0,0,16);
    angle=0;
    distance=40;
    speed=random(4,12);
    if(random(100)<50)speed*=-1;
  }
  
  void draw(){
    angle += TWO_PI/120/speed;
    angle = angle%TWO_PI;
    distance += ship.moons*1.5/120/4;
    posX=ship.posX+distance*cos(angle);
    posY=ship.posY+distance*sin(angle);
    if(!playerB)fill(#FF6A24);
    else{
      fill(#4EB4B7);
      if(weak)fill(#4EB4B7);
    }
    ellipse(posX,posY,size,size);
    speedX = -4*(ship.posX-posX)/distance;
    speedY = -4*(ship.posY-posY)/distance;
  }
}

class SunB extends Bullet{
  float angle;
  float distance;
  float speed;
  float nextSprinkle;
  
  SunB(){
    super(ship.posX,ship.posY-260, 0,0,40);
    angle=0;
    distance=260;
    speed=random(3,6);
    if(random(100)<50)speed*=-1;
    nextSprinkle = ship.nextSprinkle;
  }
  
  void draw(){
    angle += TWO_PI/120/speed;
    angle = angle%TWO_PI;
    posX=ship.posX+distance*cos(angle);
    posY=ship.posY+distance*sin(angle);
    if(!playerB)fill(#FF6A24);
    else{
      fill(#4EB4B7);
      if(weak)fill(#4EB4B7);
    }
    ellipse(posX,posY,size,size);
    
    speedX = -6*(ship.posX-posX)/distance;
    speedY = -6*(ship.posY-posY)/distance;
    
    if(false){
      nextSprinkle=120/ship.sprinkleSpeed;
      for(int i=0;i<ship.sprinkleShots;i++){
        float speedX = 3*cos(TWO_PI/ship.sprinkleShots*(i+0.5));
        float speedY = 3*sin(TWO_PI/ship.sprinkleShots*(i+0.5));
        Bullet b = new Bullet(posX,posY, speedX, speedY, 14);
        b.weak=true;
      }
    }else nextSprinkle--;
  }
  
  void checkDistances(int index){
    
    if(!playerB && distance(ship.posX,ship.posY,posX,posY)<(size+ship.size)/2.0)inGame=false;
    for(int i=0;i<astroids.size();i++){
      if(distance(astroids.get(i).posX,astroids.get(i).posY,posX,posY)<(astroids.get(i).size+size)/2.0){
        float aHp=astroids.get(i).size/15-1;
        astroids.get(i).getHit(this);
        dmg -= aHp;
        break;
      }
    }
    for(int i=0;i<mapExtras.size();i++){
      if(distance(mapExtras.get(i).posX,mapExtras.get(i).posY,posX,posY)<(mapExtras.get(i).size+size)/2.0){
        mapExtras.get(i).getHit();
        dmg=0;
        break;
      }
    }
    if(!enemyB){
      for(int i=0;i<enemies.size();i++){
        if(distance(enemies.get(i).posX,enemies.get(i).posY,posX,posY)<(enemies.get(i).size+size)/2.0){
          float eHp=enemies.get(i).hp;
          enemies.get(i).getHit(dmg);
          dmg -= eHp;
          break;
        }
      }
    }
    for(int i=index+1;i<bullets.size();i++){
      if(distance(bullets.get(i).posX,bullets.get(i).posY,posX,posY)<(bullets.get(i).size+size)/2.0 && !(playerB && bullets.get(i).playerB)){
        float bHp=bullets.get(i).dmg;
        bullets.get(i).dmg -= dmg;
        dmg -= bHp;
        break;
      }
    }
    if(dmg<1)dmg=1;
  }
}

class MineB extends Bullet{
  
  MineB(float posX, float posY){
    super(posX,posY, 0,0,40);
    bullets.remove(this);
    mines.add(this);
  }

  void draw(){
    image(mineFieldI,posX,posY,size*2,size*2);
  }
  
  void checkDistances(int index){
    
    if(!enemyB){
      for(int i=0;i<enemies.size();i++){
        if(distance(enemies.get(i).posX,enemies.get(i).posY,posX,posY)<(enemies.get(i).size+size)/2.0){
          float eHp=enemies.get(i).hp;
          enemies.get(i).getHit(dmg);
          dmg -= eHp;
          break;
        }
      }
    }
    
    if(dmg<1){
      mines.remove(this);
      float sprinkleShots=16;
      for(int i=0;i<sprinkleShots;i++){
          float speedX = 3*cos(TWO_PI/sprinkleShots*(i+0.5));
          float speedY = 3*sin(TWO_PI/sprinkleShots*(i+0.5));
          Bullet b = new Bullet(posX,posY, speedX, speedY, 16);
          b.weak=true;
          b.dmg=4;
        }
    }
  }
}
