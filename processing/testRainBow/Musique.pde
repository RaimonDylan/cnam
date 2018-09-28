import ddf.minim.analysis.*;
import ddf.minim.*;
// https://github.com/samuellapointe/ProcessingCubes/blob/master/cubes.pde
class Musique {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  PFont f;
  boolean start = true;
  ArrayList<Goutte> mesGouttes;
  float pop = random(30, 100);
  float[] circles = new float[29];
  float gain = 100;
  int tbase = 512;
  float[] myBuffer;
  float DECAY_RATE = 2;
  float spectrumScale = 2;
  float STROKE_MAX = 3;
  float STROKE_MIN = 1;
  float strokeMultiplier = 1;
  float audioThresh = .5;
  Color myColorEllipse;
  Color myColorTest;
  Color myColor;
  float moy;
  float pick = 0;

  Musique(AudioPlayer j) {
    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
    myColor =  new Color();
    myColorEllipse =  new Color();
    myColorTest =  new Color();
    moy = 0;
  }
  void update() {
    f = createFont("Arial", 16, true); 
    textFont(f, 12); 
    fill(255);
    text("musique premier plan : "+(int)jingle.position()/1000, 500, 30);
    stroke(255, 255, 255, 50);

    fft.forward(jingle.mix);
    for (int i = 0; i < fft.specSize(); i++)
    {
      moy += fft.getBand(i);
      float[] colors = myColorEllipse.getColors();
      if(i%2 == 0)
        colors = myColorEllipse.update(.1);
      fill(colors[0],colors[1],colors[2], 100);
      ellipse(20+(i*10), height-150, 7, fft.getBand(i) * 5);
    }
    if (moy/10 > 50 && jingle.position() - pick > 500 ) {

      mesGouttes.add(new Goutte(random(50, 550), random(50, 550), 60, 3));
      pick = jingle.position();
    }
     for (int i = mesGouttes.size()-1; i >= 0; i--) { 
      Goutte maGoutte = mesGouttes.get(i);
      maGoutte.update();
      if (maGoutte.finished()) {
        mesGouttes.remove(i);
      }
    }
  }
}
