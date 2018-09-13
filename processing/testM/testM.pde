
import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioPlayer jingle;
AudioPlayer jingle2;
FFT fft;
PFont f;
boolean start = true;
float pick = 0;
void setup()
{
  size(480, 320);
  minim = new Minim(this);
  jingle = minim.loadFile("ori.mp3");
  jingle2 = minim.loadFile("ori.mp3");
  fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
  jingle.mute();
  jingle.play(0);
}

void draw()
{
  background(0);
  
  f = createFont("Arial", 16, true); 
  textFont(f, 12); 
  fill(255);
  text("musique premier plan : "+(int)jingle2.position()/1000, 300, 30);
  text("musique arrière plan : "+(int)jingle.position()/1000, 300, 50);
  if (jingle.position() > 3000 && start) {
    start = false;
    jingle2.play(0);
  }
  println(pick);
  stroke(255, 255, 255, 50);

  fft.forward(jingle.mix);
  for (int i = 0; i < fft.specSize(); i++)
  {
    float c = fft.getBand(i) * 16;
    if (fft.getBand(i) > 50 && jingle.position() - pick > 500 ) {
      ellipse(200, 100, 40, 40);
      pick = jingle.position();
    }
    fill(c, 0, c, 50);
    ellipse(i, 200, 7, fft.getBand(i) * 5);
  }
}
