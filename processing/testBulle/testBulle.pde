ArrayList<Bulle> mesBulles;
float pop = random(30,100);
float cpt = 0;
void setup()
{
  size(700, 700);
  frameRate(60);
  background(255);
  mesBulles = new ArrayList<Bulle>();
  mesBulles.add(new Bulle(width/2, height/2, 60, 3));
}

void draw()
{
  background(255);
  if(cpt > pop){
    mesBulles.add(new Bulle(random(50,650), random(50,650), 60, 3));
    cpt=0;
    pop = random(30,100);
  }
  for (int i = mesBulles.size()-1; i >= 0; i--) { 
    Bulle maBulle = mesBulles.get(i);
    maBulle.update();
    if (maBulle.finished()) {
      mesBulles.remove(i);
    }
  }
  cpt++;
}

void mousePressed() {
  for (int i = mesBulles.size()-1; i >= 0; i--) { 
    Bulle maBulle = mesBulles.get(i);
    if (maBulle.isHit(mouseX,mouseY)) {
      mesBulles.remove(i);
    }
  }
}
