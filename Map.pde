public class SpatialMap{
  
 HashMap<String,ArrayList<Projectile>> sp=new HashMap<>();
  private int cellSize=0;
  
  SpatialMap(int cellSize){
   this.cellSize=cellSize; 
  }
  
  void exitCell(String Key,Projectile p){
    if(!sp.containsKey(Key)){
      //System.out.println("tried to remove blank Key");
      return;
    }
    //System.out.println("removing key: "+Key);
    /* Old Removing code for(int i=0;i<sp.get(Key).size();i++){
      if(sp.get(Key).get(i).id==p.id){
        sp.get(Key).remove(i);
      }
    }
    if(sp.get(Key).size()==0){
     sp.remove(Key); 
    }*/
   sp.get(Key).removeIf(i -> i.id == p.id);
  }
  
  void enterCell(String Key, Projectile p){
    /*if(!sp.containsKey(Key)){
      sp.put(Key,new ArrayList<Projectile>());
      //System.out.println("Created key");
    }
    sp.get(Key).add(p);*/
    sp.computeIfAbsent(Key, k -> new ArrayList<>()).add(p);
    //System.out.println("Put in key");
  }
  
  String getKey(PVector p){
    int[] returnArr=new int[2];
    returnArr[0]=(int)Math.floor(p.x/cellSize);
    returnArr[1]=(int)Math.floor(p.y/cellSize);
    return new String(returnArr[0]+","+returnArr[1]);
  }
  
  void checkNearby(Projectile p){
    //System.out.println("Checking nearby cells...");
    for(int i=-cellSize;i<=cellSize;i+=cellSize){
     for(int j=-cellSize;j<=cellSize;j+=cellSize){
       String testKey=getKey(new PVector(p.pos.x+i,p.pos.y+j));
       if(abs(j)!=abs(i)){
         //System.out.println("Checking cell at: "+testKey);
         //System.out.println(sp.containsKey(testKey));
         if(sp.containsKey(testKey)){
           //System.out.println(sp.containsKey(testKey));
          for(int k=0; k<sp.get(testKey).size();k++){
             collide(p,sp.get(testKey).get(k),0);
          }
         }
       }
       if(sp.containsKey(testKey)&&i==0&&j==0&&sp.get(getKey(p.pos)).size()>=2){
           //System.out.println("Checking own cell");
           for(int k=0; k<sp.get(testKey).size()-1;k++){
             if(!sp.get(testKey).get(k).pos.equals(p.pos)){
                collide(p,sp.get(testKey).get(k),0);
             }
          }
         }
     }
    }
  }
  
  void display(){
    noFill();
    stroke(0);
    for(int i=0;i<width;i+=cellSize){
      for(int j=0;j<height;j+=cellSize){
        rect(i,j,cellSize,cellSize);
      }
    }
    
  }
}
