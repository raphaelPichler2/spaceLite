boolean firstFrameClick=true;
Boolean[] keys= new Boolean[14];
Table table;

boolean inGame = false;
boolean shop;
int gameMode = 0;
float score;
float scoreMulti=0;
float highscore;
float money=0;
boolean moneyGot;
float gamesPlayed;

Ship ship;
ArrayList<Astroid> astroids = new ArrayList<Astroid>();
ArrayList<Enemy> enemies = new ArrayList<Enemy>();
ArrayList<Bullet> bullets = new ArrayList<Bullet>();
ArrayList<MapExtras> mapExtras = new ArrayList<MapExtras>();
ArrayList<MineB> mines = new ArrayList<MineB>();
ArrayList<TowerField> towers = new ArrayList<TowerField>();
ArrayList<Item> items = new ArrayList<Item>();
float difficulty;

void setup(){
  size(1200,1000,P2D);
  smooth(8);
  rectMode(CENTER);
  textAlign(CENTER, CENTER);
  frameRate(120);
  imageMode(CENTER);
  loadImg();
  table= loadTable("new.csv","header,csv");
  loadGameState();
  
  for(int i=0;i<keys.length;i++){
    keys[i]=false;
  }
}

void draw(){
  background(0);
  
  
  if(!inGame){
    if(random(120/2)<1){ Astroid a = new Astroid(); }
    for(int i=0;i<astroids.size();i++){
      astroids.get(i).draw();
    }
    for(int i=0;i<astroids.size();i++){
      astroids.get(i).checkDistances(i);
    }
    for(int i=0;i<bullets.size();i++){
      bullets.get(i).draw();
    }
    for(int i=0;i<bullets.size();i++){
      bullets.get(i).checkDistances(i);
    }
    if(!shop){
      if(score>highscore)highscore=score;
      if(!moneyGot){
        moneyGot=true;
        money += (int)(score/10);
        saveData();
      }
      image(coverI,600,200,600,600);
      textC("money: "+(int)money,100, 25, 20, 255);
      textC("+ "+(int)(score/10),100, 50, 20, 255);
      textC("score: "+(int)score,100, 75, 20, 255);
      textC("highscore: "+(int)highscore,100, 100, 20, 255);
      fill(20);
      rect(600, 450, 400, 100);
      textC("normal game",600, 450, 30, 255);
      if(hardMode>0){
        if(hard)fill(20);
        else fill(0);
        rect(860, 450, 100, 100);
        textC("hard",860, 450, 30, 255);
        if(buttonPressed(860, 450, 100, 100))hard=!hard;
      }
      if(buttonPressed(600, 450, 400, 100))startGame(0);
      fill(20);
      rect(600, 600, 400, 100);
      textC("astroid mayham",600, 600, 30, 255);
      if(buttonPressed(600, 600, 400, 100))startGame(1);
      fill(20);
      rect(600, 750, 400, 100);
      textC("shop",600, 750, 30, 255);
      if(buttonPressed(600, 750, 400, 100))shop=true;
    }else{
      shop();
      
    }
  }else{
  //
  //  Ingame
  //
    score += scoreMulti/120;
    textC("score: "+(int)score,80, 25, 24, 255);
    textC("      x "+scoreMulti,80, 46, 18, 255);
    
    for(int i=0;i<mines.size();i++){
      mines.get(i).draw();
    }
    for(int i=0;i<mines.size();i++){
      mines.get(i).checkDistances(i);
    }
    for(int i=0;i<towers.size();i++){
      towers.get(i).draw();
    }
    ship.draw();
    for(int i=0;i<astroids.size();i++){
      astroids.get(i).draw();
    }
    for(int i=0;i<astroids.size();i++){
      astroids.get(i).checkDistances(i);
    }
    for(int i=0;i<bullets.size();i++){
      bullets.get(i).draw();
    }
    for(int i=0;i<bullets.size();i++){
      bullets.get(i).checkDistances(i);
    }
    for(int i=0;i<enemies.size();i++){
      enemies.get(i).draw();
    }
    for(int i=0;i<enemies.size();i++){
      enemies.get(i).checkDistances();
    }
    for(int i=0;i<mapExtras.size();i++){
      mapExtras.get(i).draw();
    }
    for(int i=0;i<mapExtras.size();i++){
      mapExtras.get(i).checkDistances();
    }
    for(int i=0;i<items.size();i++){
      items.get(i).draw();
    }
    for(int i=0;i<items.size();i++){
      items.get(i).checkDistances();
    }
    
    //spawns
    if(gameMode==0){
      if(random(120/2)<1){ Astroid a = new Astroid(); }
      if(random(120/difficulty * 30)<1){ redShip r = new redShip(); }
      if(random(120/difficulty * 60)<1){ blueShip r = new blueShip(); }
      if(random(120*20)<1){ BombenFass r = new BombenFass(); }
      if(random((10+5+difficulty)*120) < 1+0.02*bonusItems){ newItem();}
      if(random(120 * 3)<1) difficulty+=0.1;
    }
    if(gameMode==1){
      if(random(120/difficulty)<1){ Astroid a = new Astroid(); }
      if(random(120 * 3)<1) difficulty+=0.1;
    }
  }
  
  if (!keyPressed && !mousePressed)firstFrameClick=true;  
  if (keyPressed || mousePressed)firstFrameClick=false;
}

void startGame(int mode){
  inGame=true;
  ship=new Ship();
  astroids.clear();
  enemies.clear();
  bullets.clear();
  mapExtras.clear();
  mines.clear();
  towers.clear();
  items.clear();
  difficulty=2;
  gameMode=mode;
  score=0;
  moneyGot=false;
  gamesPlayed++;
  scoreMulti=1+0.02*bonusScore;
  if(hard){
    difficulty+=4;
    scoreMulti+=0.5;
  }
  for(int i=0;i<startItem;i++){
    newItem();
  }
}
