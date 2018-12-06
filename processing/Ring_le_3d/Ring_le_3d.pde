import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
Musique2 maMusique;
AudioPlayer jingle;
boolean start = false;
void setup()
{
  selectInput("Selection de la musique :", "fileSelected");
  frameRate(60);
  minim = new Minim(this);
  size(1080, 720,P3D);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Mais sélectionne une musique abrutie");
  } else {
    jingle = minim.loadFile(selection.getAbsolutePath());
    maMusique = new Musique2(jingle);
    println("musique selectionné " + selection.getAbsolutePath());
    start = true;
  }
}

void draw()
{
  if (start)
    maMusique.update();
}
