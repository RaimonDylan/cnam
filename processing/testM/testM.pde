import ddf.minim.analysis.*;
import ddf.minim.*;


Minim minim;
Musique maMusique;
AudioPlayer jingle;
AudioPlayer jingle2;
Background bg;

void setup()
{
  frameRate(60);
  minim = new Minim(this);
  size(700, 600);
  jingle = minim.loadFile("ori.mp3");
  jingle2 = minim.loadFile("ori.mp3");
  maMusique = new Musique(jingle, jingle2);
  bg = new Background();
}

void draw()
{
  bg.update();
  maMusique.update();
  
}
