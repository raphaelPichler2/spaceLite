PImage coverI;
PImage shipI;
PImage shipTriebI;
PImage komet1I;
PImage bombfassI;
PImage ASI;
PImage mineI;
PImage mineFieldI;
PImage twentyI;
PImage backshotI;
PImage sprinkleShotsI;
PImage critI;
PImage BSI;
PImage moreSprinkleShotsI;
PImage moonI;
PImage scoreMultiI;
PImage towerI;
PImage towerBaseI;
PImage towerBarrelI;
PImage shotsUpI;
PImage explosiveI;
PImage sunI;
PImage dmgI;

PImage redShipI;
PImage blueShipI;
PImage enemShieldI;

void loadImg(){
  coverI=loadImage("cover.png");
  shipI=loadImage("ship.png");
  shipTriebI=loadImage("shipTrieb.png");
  komet1I=loadImage("komet1.png");
  bombfassI=loadImage("bombfass.png");
  ASI=loadImage("AS.png");
  mineI=loadImage("Mine.png");
  mineFieldI=loadImage("MineField.png");
  twentyI=loadImage("twenty.png");
  sprinkleShotsI=loadImage("SprinkleShots.png");
  critI=loadImage("Crit.png");
  backshotI=loadImage("Backshot.png");
  BSI=loadImage("BS.png");
  scoreMultiI=loadImage("ScoreMulti.png");
  moreSprinkleShotsI=loadImage("MoreSprinkleShots.png");
  moonI=loadImage("Moon.png");
  towerI=loadImage("Tower.png");
  towerBaseI=loadImage("TowerBase.png");
  towerBarrelI=loadImage("TowerBarrel.png");
  shotsUpI=loadImage("ShotsUp.png");
  explosiveI=loadImage("Explosive.png");
  sunI=loadImage("Sun.png");
  dmgI=loadImage("Dmg.png");
  
  redShipI=loadImage("redShip.png");
  blueShipI=loadImage("blueShip.png");
  enemShieldI=loadImage("EnemShield.png");
}

void loadGameState(){
  
  money=table.getInt(0,"value");
  highscore=table.getInt(1,"value");
  gamesPlayed=table.getInt(2,"value");
  
  bonusAttackSpeed=table.getInt(3,"value");
  bonusItems=table.getInt(4,"value");
  bonusScore=table.getInt(5,"value");
  startItem=table.getInt(6,"value");
  mystery=table.getInt(7,"value");
  hardMode=table.getInt(8,"value");
}

void saveData(){
  
  table.getRow(0).setFloat("value",money);
  table.getRow(1).setFloat("value",highscore);
  table.getRow(2).setFloat("value",gamesPlayed);
  
  table.getRow(3).setInt("value",bonusAttackSpeed);
  table.getRow(4).setInt("value",bonusItems);
  table.getRow(5).setInt("value",bonusScore);
  table.getRow(6).setInt("value",startItem);
  table.getRow(7).setInt("value",mystery);
  table.getRow(8).setInt("value",hardMode);
  
  saveTable(table, "data/new.csv");
}
