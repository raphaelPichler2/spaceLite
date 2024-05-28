class Ship{
  float posX, posY;
  float speedX, speedY;
  float baseSpeed, speed;
  float size;
  float attackspeed;
  float nextAttack;
  float bulletSize;
  float sprinkleSpeed=0.2;
  float nextSprinkle=0;
  float sprinkleShots=4;
  float shots=1;
  float critProb=0;
  float backshotProb=0;
  float explosive=0;
  float dmg=1;
  float shield=0;
  float bulletSpeed=6;
  float moons=0;
  float nextMoon;
  
  Ship(){
    posX=600;
    posY=500;
    size=26;
    speedX=0; speedY=0;
    speed=8/120.0;
    bulletSize=16;
    attackspeed=2 + 0.04*bonusAttackSpeed;
    nextAttack=120/attackspeed;
  }
  
  void draw(){
    if(keys[6]){
      float dist = distance(mouseX,mouseY, posX,posY);
      speedX = speedX + speed*(mouseX-posX)/dist;
      speedY = speedY + speed*(mouseY-posY)/dist;
      turnImg(shipTriebI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,mouseX,mouseY));
    }else{
      turnImg(shipI,posX,posY,size*2,size*2,HALF_PI+angle(posX, posY,mouseX,mouseY));
    }
    if(nextAttack<=0 && !keys[12]){//
      nextAttack=120/attackspeed;
      float dist = distance(mouseX,mouseY, posX,posY);
      float angle=angle(posX,posY,mouseX,mouseY);
      
      //backshot
      if(random(1)<backshotProb){
        Bullet b = new Bullet(posX,posY, -bulletSpeed*cos(angle), -bulletSpeed*sin(angle), bulletSize);
        b.explosive=(int)explosive;
        if(random(1)<critProb){
          b.dmg=2*dmg;
          b.size*=2;
          b.crit=true;
        }else{
          b.dmg=dmg;
        }
      }
      
      angle+=(shots-1)*TWO_PI/100;
      for(int i=0;i<shots;i++){
        Bullet b = new Bullet(posX,posY, bulletSpeed*cos(angle-i*TWO_PI/50), bulletSpeed*sin(angle-i*TWO_PI/50), bulletSize);
        b.explosive=(int)explosive;
        if(random(1)<critProb){
          b.dmg=2*dmg;
          b.size*=2;
          b.crit=true;
        }else{
          b.dmg=dmg;
        }
      }
    }else nextAttack--;
    
    if(sprinkleSpeed>0.2){
      if(nextSprinkle<=0){
        nextSprinkle=120/sprinkleSpeed;
        for(int i=0;i<sprinkleShots;i++){
          float speedX = 3*cos(TWO_PI/sprinkleShots*(i+0.5));
          float speedY = 3*sin(TWO_PI/sprinkleShots*(i+0.5));
          Bullet b = new Bullet(posX,posY, speedX, speedY, 12);
          b.weak=true;
        }
      }else{
        nextSprinkle--;
      }
    }
    if(moons>0){
      if(nextMoon<=0){
        nextMoon=120*35/moons;
        MoonB m = new MoonB();
      }else{
        nextMoon--;
      }
    }
    
    speedX=speedX*0.99;
    speedY=speedY*0.99;
    posX=posX+speedX;
    posY=posY+speedY;
    if(posX<0)posX=1200;
    if(posY<0)posY=1000;
    if(posX>1200)posX=0;
    if(posY>1000)posY=0;
  }
}
