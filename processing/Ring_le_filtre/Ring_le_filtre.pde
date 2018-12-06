import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
Musique maMusique;
AudioPlayer jingle;
boolean start = false;
void setup()
{
  //selectInput("Selection de la musique :", "fileSelected");
  frameRate(60);
  minim = new Minim(this);
  size(700, 600);
  noStroke();
  fill(255);
  background(0);
}

void fileSelected(File selection) {
  if (selection == null) {
    println("Mais sélectionne une musique abrutie");
  } else {
    jingle = minim.loadFile(selection.getAbsolutePath());
    maMusique = new Musique(jingle);
    println("musique selectionné " + selection.getAbsolutePath());
    start = true;
  }
}

void draw()
{
  filter(BLUR,2);
  fill(random(255),random(255),random(255));
  ellipse(random(width),random(height),40,40);
  if (start)
    maMusique.update();
}
