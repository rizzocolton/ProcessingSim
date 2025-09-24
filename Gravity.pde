static class Gravity{
  final static float G=6;
 static int updateAccels(Projectile p1, Projectile p2){
   float angle=atan2(p2.pos.y-p1.pos.y,p2.pos.x-p1.pos.x);
   PVector a1=p1.accel;
   PVector a2=p2.accel;
   float sep=p1.pos.dist(p2.pos);
   a1.set((G*p2.mass)/(sep*sep)*cos(angle),(G*p2.mass)/(sep*sep)*sin(angle));
   a2.set((G*p1.mass)/(sep*sep)*cos(angle+PI),(G*p1.mass)/(sep*sep)*sin(angle+PI));
   return 0;
 }
}
