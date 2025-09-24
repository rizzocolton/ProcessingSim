void collide(Projectile p1, Projectile p2, int depth){
  if(p1.id==p2.id){
   return; 
  }
  //System.out.println(p1.id);
  boolean intersecting=ceil(p1.pos.dist(p2.pos))<p1.diam/2+p2.diam/2;
  float angle=atan2(p2.pos.y-p1.pos.y,p2.pos.x-p1.pos.x);
  if(intersecting){
    System.out.println("Velocity of 1 before: "+p1.vel.x*frameRate/Projectile.ppm+","+p1.vel.y*frameRate/Projectile.ppm+" Velocity of 2 before: "+p2.vel.x*frameRate/Projectile.ppm+","+p2.vel.y*frameRate/Projectile.ppm);
    p1.moveBack(p2,angle);
    //System.out.println("Tried moving back");
    if(intersecting){
     //System.out.println("Still Intersecting");
     collide(p1,p2,depth+1); 
    }
    PVector v1i=(p1.vel.rotate(-angle));
    PVector v2i=(p2.vel.rotate(-angle));
    PVector v1f=new PVector(((p1.mass*v1i.x)-(p2.mass*v1i.x)+(2*p2.mass*v2i.x))/(p1.mass+p2.mass),v1i.y);
    PVector v2f=new PVector(v1i.x+v1f.x-v2i.x,v2i.y);
    p1.vel=v1f.rotate(angle);
    p2.vel=v2f.rotate(angle);
    System.out.println("Velocity of 1 after: "+p1.vel.x*frameRate/Projectile.ppm+","+p1.vel.y*frameRate/Projectile.ppm+" Velocity of 2 after: "+p2.vel.x*frameRate/Projectile.ppm+","+p2.vel.y*frameRate/Projectile.ppm);
  }
}

void checkBounds(Projectile p){
  if(p.pos.x+p.diam/2>width||p.pos.x-p.diam/2<0){
    if(p.pos.x-p.diam/2<0){
      p.moveBack(-p.pos.x+p.diam/2,true);
    }else{
      p.moveBack(-p.pos.x-p.diam/2+width,true);
    }
    p.vel.x*=-1;
  }
  if(p.pos.y+p.diam/2>height||p.pos.y-p.diam/2<0){
    if(p.pos.y-p.diam/2<0){
      p.moveBack(-p.pos.y+p.diam/2,false);
    }else{
      p.moveBack(-p.pos.y-p.diam/2+height,false);
    }
    p.vel.y*=-1;
  }
}
