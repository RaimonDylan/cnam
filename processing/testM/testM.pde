import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
Musique maMusique;
AudioPlayer jingle;
AudioPlayer jingle2;
ArrayList<Bulle> mesBulles;
float pop = random(30,100);
float cpt = 0;
void setup()
{
  frameRate(60);
  minim = new Minim(this);
  size(700, 600);
  jingle = minim.loadFile("ori.mp3");
  jingle2 = minim.loadFile("ori.mp3");
  maMusique = new Musique(jingle, jingle2);
  mesBulles = new ArrayList<Bulle>();
  mesBulles.add(new Bulle(width/2, height/2, 60, 3));
}

void draw()
{
  background(0);
  maMusique.update();
  if(cpt > pop){
    mesBulles.add(new Bulle(random(50,550), random(50,550), 60, 3));
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
