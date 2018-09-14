import fisica.*;
FWorld world;
ArrayList<FCircle> polys;
FCompound m;

void setup(){
  size(400,400);
  Fisica.init(this);
  world = new FWorld();
  world.setEdges();
  m = new FCompound();
  world.setEdgesFriction(0);
  world.setEdgesRestitution(1);
  world.setGravity(0,0);
  //world.setEdgesFriction(0);
  //world.setEdgesRestitution(1);
  //world.remove(world.top);
  //world.remove(world.left);
  polys = new ArrayList<FCircle>();
  FBox m1 = new FBox(50, 5);
  FBox m2 = new FBox(50, 5);
  FBox m3 = new FBox(5, 50);
  FBox m4 = new FBox(5, 50);
  m1.setPosition(0,25);
  m1.setFill(0);
  m2.setPosition(0,-25);
  m2.setFill(0);
  m3.setPosition(-25,0);
  m3.setFill(0);
  m4.setPosition(25,0);
  m4.setFill(0);
  
  m.addBody(m1);
  m.addBody(m2);
  m.addBody(m3);
  m.addBody(m4);
  m.setPosition(width/2,height/2);
  m.setRotation(PI/4);
  m.setAngularVelocity(PI/4);
  world.add(m);
}

void draw(){
  background(255,255,255,200);
  world.step();
  world.draw();
  m.addTorque(6*PI);
  for(FCircle c: polys){
    c.setFill(random(0,255),random(0,255),random(0,255),random(50,255));
  }
}
void mousePressed(){
  FCircle c = new FCircle(5);
   c.setFill(random(0,255),random(0,255),random(0,255),random(50,255));
  c.setPosition(mouseX,mouseY);
  c.setBullet(true);
  c.setDamping(0);
  c.setRestitution(1);
  c.setFriction(0);
  polys.add(c);
  world.add(c);
  
}
