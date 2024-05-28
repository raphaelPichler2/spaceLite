
int bonusAttackSpeed=0;
int bonusItems=0;
int bonusScore=0;
int startItem=0;
int mystery=0;
int hardMode=0;
boolean hard=false;

void shop(){
  textC("money: "+(int)money,600, 25, 30, 255);
  int price=0;
  
  price=(20+10*bonusAttackSpeed);
  if(shopButton("attackspeed+2%  |  "+ price +"$ (+"+2*bonusAttackSpeed+"%)",220,100,price)){
    bonusAttackSpeed ++;
    saveData();
  }
  
  price=(30+15*bonusItems);
  if(shopButton("itemdrops+2%  |  "+ price +"$ (+"+2*bonusItems+"%)",220,150,price)){
    bonusItems ++;
    saveData();
  }
  
  price=(50+25*bonusScore);
  if(shopButton("score+2%  |  "+ price +"$ (+"+2*bonusScore+"%)",220,200,price)){
    bonusScore ++;
    saveData();
  }
  
  price=(500-500*hardMode);
  if(shopButton("unlock hardmode |  "+ price +"$ ",220,250,price) && hardMode==0){
    hardMode ++;
    saveData();
  }
  
  price=(1000+2000*startItem);
  if(shopButton("startitem+1  |  "+ price +"$ (+"+startItem+")",220,300,price)){
    startItem ++;
    saveData();
  }
  
  price=(9999-mystery*9999);
  if(shopButton("?????????  |  "+ price +"$ ",220,350,price) && mystery==0){
    mystery ++;
    saveData();
  }
  
  fill(20);
  rect(1100, 900, 400, 100);
  textC("exit",1050, 900, 30, 255);
  if(buttonPressed(1100, 900, 400, 100))shop=false;
}

boolean shopButton(String name, float posX,float posY,float price){
  
  fill(20);
  if(money >= price) rect(posX, posY, 400, 40);
  textC(name,posX, posY, 20, 255);
  if(buttonPressed(posX, posY, 400, 50) && money >= price){
    money-=price;
    return true;
  }
  return false;
}
