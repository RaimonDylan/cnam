import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
Musique maMusique;
AudioPlayer jingle;

void setup()
{
  frameRate(60);
  minim = new Minim(this);
  size(700, 600);
  //jingle = minim.loadFile("ori.mp3");
  jingle = minim.loadFile("lake.wav");
  maMusique = new Musique(jingle);
}

void draw()
{
  background(0);
  maMusique.update();
}
