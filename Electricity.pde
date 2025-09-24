static class Electricity{
  final static float k=9;
 static int updateAccels(Charge p1, Charge p2){
   float angle=atan2(p2.pos.y-p1.pos.y,p2.pos.x-p1.pos.x);
   PVector a1=p1.accel;
   PVector a2=p2.accel;
   float sep=p1.pos.dist(p2.pos);
   float c1=-k*p1.charge*((p2.charge)/(sep*sep*p1.mass));
   float c2=-k*p2.charge*((p1.charge)/(sep*sep*p2.mass));
   a1.set(c1*cos(angle),c1*sin(angle));
   a2.set(c2*cos(angle+PI),c2*sin(angle+PI));
   return 0;
 }
}
