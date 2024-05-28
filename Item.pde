void newItem(){
  float r = random(100);
  if(r < 70){
    int s = (int)random(6);
    switch(s){
    case 0:
      ASUp a = new ASUp();
      break;
    case 1:
      SprinkleShots ss = new SprinkleShots();
      break;
    case 2:
      Backshot bs = new Backshot();
      break;
    case 3:
      Crit crt = new Crit();
      break;
    case 4:
      if(score>100){Twenty tw = new Twenty();
      }else{newItem();}
      break;
    case 5:
      Mine mi = new Mine();
      break;
    }
    
  }else if(r < 91){
    int s = (int)random(5);
    switch(s){
    case 0:
      BSUp b = new BSUp();
      break;
    case 1:
      MoreSprinkleShots ms = new MoreSprinkleShots();
      break;
    case 2:
      Moon mo = new Moon();
      break;
    case 3:
      Tower t = new Tower();
      break;
    case 4:
      ScoreMulti sm = new ScoreMulti();
      break;
    }  
    
  }else{
    int s = (int)random(4);
    switch(s){
    case 0:
      ShotsUp su = new ShotsUp();
      break;
    case 1:
      Explosive e = new Explosive();
      break;
    case 2:
      Sun sn = new Sun();
      break;
    case 3:
      Dmg dmg = new Dmg();
      break;
    }
  }
}

class Item{
  float posX, posY;
  float speedX, speedY;
  float size;
  PImage img;
  
  void draw(){
    posX+=speedX;
    posY+=speedY;
    image(img,posX,posY,1.6*size,1.6*size);
  }
  void checkDistances(){
    if(distance(ship.posX,ship.posY,posX,posY)<(size+ship.size)/2)trigger();
  }
  void trigger(){
  }
  void calcSpeed(){
    float rX = random(-300,300);
    float rY = random(-250,250);
    float dist = distance(600+rX,500-rY, posX,posY);
    speedX=1.2*(600+rX-posX)/dist;
    speedY=1.2*(500-rY-posY)/dist;
  }
}

class ASUp extends Item{
  
  ASUp(){
    img=ASI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.attackspeed *= 1.2;
  }
}
class BSUp extends Item{
  
  BSUp(){
    img=BSI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.bulletSize += 3;
  }
}

class ShotsUp extends Item{
  
  ShotsUp(){
    img=shotsUpI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.shots += 1;
  }
}

class SprinkleShots extends Item{
  
  SprinkleShots(){
    img=sprinkleShotsI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.sprinkleSpeed *= 1.2;
  }
}

class MoreSprinkleShots extends Item{
  
  MoreSprinkleShots(){
    img=moreSprinkleShotsI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.sprinkleSpeed *= 1.1;
    ship.sprinkleShots += 4;
  }
}

class Backshot extends Item{
  
  Backshot(){
    img=backshotI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.backshotProb += 0.25;
    if(ship.backshotProb>1)ship.attackspeed *= 1.2;
  }
}

class Explosive extends Item{
  
  Explosive(){
    img=explosiveI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.explosive += 1;
  }
}

class Moon extends Item{
  
  Moon(){
    img=moonI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.moons += 1;
  }
}

class Sun extends Item{
  
  Sun(){
    img=sunI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    SunB s = new SunB();
    //ship.sprinkleSpeed *= 1.1;
    //ship.sprinkleShots+=4;
  }
}

class Dmg extends Item{
  
  Dmg(){
    img=dmgI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.dmg += 1;
  }
}

class Crit extends Item{
  
  Crit(){
    img=critI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    ship.critProb += 0.1;
    if(ship.critProb>1)ship.attackspeed *= 1.2;
  }
}

class Twenty extends Item{
  
  Twenty(){
    img=twentyI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    score+=50*scoreMulti;
  }
}

class Mine extends Item{
  
  Mine(){
    img=mineI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    MineB m= new MineB(posX,posY);
  }
}

class Tower extends Item{
  
  Tower(){
    img=towerI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    TowerField t= new TowerField(posX,posY);
  }
}
class ScoreMulti extends Item{
  
  ScoreMulti(){
    img=scoreMultiI;
    size=60;
    float r=random(4400);
    posX=getPosX(r,size);
    posY=getPosY(r,size);
    calcSpeed();
    items.add(this);
  }
  
  void trigger(){
    items.remove(this);
    scoreMulti += 0.1;
  }
}
