import ddf.minim.analysis.*;
import ddf.minim.*;
Minim minim;
Musique maMusique;
AudioPlayer jingle;
AudioPlayer jingle2;
void setup()
{
  size(480, 320);
  jingle = minim.loadFile("ori.mp3");
  jingle2 = minim.loadFile("ori.mp3");
  maMusique = new Musique(jingle,jingle2);
}

void draw()
{
  background(0);
  maMusique.update();
}
