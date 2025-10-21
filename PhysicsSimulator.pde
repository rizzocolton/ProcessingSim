//Mode Selection
String mode="Ball Pit";
int pop=4;
int selectedIndex=0;


//creation of hashmap
int cellSize=200;
SpatialMap sp=new SpatialMap(cellSize);

//Projectiles for Specified mode loaded in
Projectile[] pList=determineMode(mode,pop);
Charge[] cList=createCharges();
Charge c1=cList[0];
Charge c2=cList[1];
Projectile p1=pList[0];
Projectile p2=pList[1];

//toggle for gravity and simulation switch
boolean g=false;
boolean active=false;


void setup(){
 size(1000,1000);
 frameRate(100);
 noLoop();
 if(!mode.equals("Electricity")){
   for(int i=0;i<pList.length;i++){
    sp.enterCell(sp.getKey(pList[i].pos),pList[i]);
   }
 }
}

void draw(){
  background(100);
  if(mode.equals("Electricity")){
    c1.move();
    c2.move();
    collide(c1,c2,0);
    Electricity.updateAccels(c1,c2);
    c1.display();
    c2.display();
  }else{
    sp.display();
    for(int i=0;i<pList.length;i++){
      //System.out.println("Object#"+i);
      //System.out.println("Object id: "+pList[i].id);
      String lastKey=sp.getKey(pList[i].move());
      String currentKey=sp.getKey(pList[i].pos);
      //System.out.println(lastKey);
      //System.out.println(currentKey);
      if(!currentKey.equals(lastKey)){
        sp.exitCell(lastKey,pList[i]);
        sp.enterCell(currentKey,pList[i]);
        //System.out.println();
      }
      sp.checkNearby(pList[i]);
      if(mode.equals("Collision")||mode.equals("Ball Pit")){
        checkBounds(pList[i]);
      }
     if(mode.equals("Gravity")){
       Gravity.updateAccels(p1,p2);
       Gravity.updateAccels(p1,pList[2]);
      }
      
      pList[i].display();
      //System.out.println();
    }
  }
  if (frameCount % 60 == 0) {  // Print once every 60 frames
    //System.out.println(frameRate);
  }
}
void keyPressed(){
 switch(key){
   case 'g':
      g=!g;
      float g=0;
      if(this.g){
        g=9.8;
      }
      for(int i=0;i<pList.length;i++){
       pList[i].accel.set(0,g/frameRate); 
      }
      break;
   case ' ':
     active=!active;
     if(active){
       loop();
     }else{
       noLoop();
     }
     break;
   case '<':
     if(selectedIndex==0){
      selectedIndex=pList.length-1; 
      break;
     }
     selectedIndex--;
     break;
   case '>':
     if(selectedIndex==pList.length-1){
       selectedIndex=0;
       break;
     }
     selectedIndex++;
   case 'q':
     pList[selectedIndex].vel.rotate(-5*PI/180);
     break;
   case 'e':
     pList[selectedIndex].vel.rotate(5*PI/180);
     break;
   case 'w':
     float pastVel=pList[selectedIndex].vel.mag();
     if(pastVel==0){
       pList[selectedIndex].vel.set(1,0);
       break;
     }
     System.out.println(pList[selectedIndex].vel);
     pList[selectedIndex].vel.setMag(pastVel+1);
     System.out.println("increased");
     System.out.println(pList[selectedIndex].vel);
     break;
   case 's':
     pList[selectedIndex].vel.setMag(pList[selectedIndex].vel.mag()-1);
     break;
 } 
}

Projectile[] determineMode(String mode,int pop){
  Projectile[] pList=new Projectile[pop];
  switch(mode){
  case "Collision":
    pList[0]=(new Projectile(width/2-20,height/2+2,15,12,10,20,#f83030));
    pList[1]=(new Projectile(width/2+20,height/2+2,20,180,5,10,#308bf8));
    break;
  case "Gravity":
    pList[0]=(new Projectile(width/2,height/2,0,0,20,4E3,#308bf8));
    pList[1]=(new Projectile(width/2-30,height/2,55,90,2,4,#f83030));
    pList[2]=(new Projectile(width/2-30,height/2,55,90,2,4,#f83030));
    break;
  case "Ball Pit":
    for(int i=0;i<pop;i++){
     color c= color(random(0,255),random(0,255),random(0,255));
     pList[i]=new Projectile(random(10,width-10),random(10,height-10),random(0,40),random(0,360),(int)random(1,cellSize/2/Projectile.ppm),10,c);
   }
     break;
  } 
  return pList;
}

Charge[] createCharges(){
  Charge[] cList=new Charge[2];
  cList[0]=(new Charge(width/2,height/2,0,0,1,10,10));
  cList[1]=(new Charge(width/2,height/2+10,0,0,1,10,10));
  return cList;
}
