 static int population=0;
class Projectile{
  //Units
  
  //position factor:pixels per meter
  final static int ppm=10;
  //time factor: frames per second
  final float fps= frameRate;
  
  //Projectile Vectors
  PVector pos=new PVector(0,0);
  PVector vel=new PVector(0,0);
  PVector accel=new PVector(0,0/fps);
  
  //Projectile Properties
  int diam=0;
  float mass=10;
  color col;

  int id;
  
  Projectile(float x,float y,float v,float a, int d, float m, color c){
    pos.set(x*ppm,y*ppm);
    a=a*PI/180;
    vel.set(v*ppm/fps*cos(a),v*ppm/fps*sin(a));
    diam=d*ppm;
    mass=m;
    col=c;
    id=population;
    population++;
  }
  
  PVector move(){
    PVector lastPos=new PVector(pos.x,pos.y);
    vel.add(accel);
    pos.add(vel);
    return lastPos;
    //System.out.println(pos+"\t"+vel);
  }
  
  void moveBack(float distIntersected,boolean horiz){
   if(horiz){
    pos.add(new PVector(distIntersected,0)); 
   }else{
    pos.add(new PVector(0,distIntersected)); 
   }
  }
  
  void moveBack(Projectile other,float angle){
   float distIntersected=other.diam/2+this.diam/2-floor(this.pos.dist(other.pos));
   //System.out.println(distIntersected);
   PVector correctionVector=new PVector(distIntersected*cos(angle),distIntersected*sin(angle));
   pos.sub(correctionVector);
  }
  
  void display(){
   fill(col);
   noStroke();
   if(selectedIndex==id){
    /*stroke(255); 
    float a=atan2(vel.y,vel.x);
    rectMode(2);
    rect(pos.x+diam/2*cos(a),pos.y+diam/2*sin(a),2,2);
    rectMode(0);*/
   }
   circle(pos.x,pos.y,diam);
  }
  
  String toString(){
    return "Projectile at ("+pos.x+", "+pos.y+") moving at ";
  }
}

class Charge extends Projectile{
  float charge;
  Charge(float x, float y, float v, float a, int d, float m, float q){
    super(x,y,v,a,d,m,0);
    color c=0;
    if(q<0){
      c=#308bf8;
    }
    if(q>0){
      c=#f83030;
    }
    charge=q;
    super.col=c;
  }
}
