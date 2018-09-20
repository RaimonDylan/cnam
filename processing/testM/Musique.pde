import ddf.minim.analysis.*;
import ddf.minim.*;

class Musique {



  Minim minim;
  AudioPlayer jingle;
  AudioPlayer jingle2;
  FFT fft;
  PFont f;
  boolean start = true;
  float pick = 0;
  int timer = 1;
  float r = 0;
  float g = 0;
  float b = 0;
  ArrayList<Bulle> mesBulles;
  float pop = random(30, 100);
  float cpt = 0;
  float[] circles = new float[29];
  float DECAY_RATE = 2;
  float spectrumScale = 2;
  float STROKE_MAX = 5;
  float STROKE_MIN = 2;
  float strokeMultiplier = 1;
  float audioThresh = .9;


  Musique(AudioPlayer j, AudioPlayer j2) {
    jingle = j;
    jingle2 = j2;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    fft.logAverages( 22, 3);
    jingle.mute();
    jingle.play(0);
    mesBulles = new ArrayList<Bulle>();
  }
  void update() {
    float moy = 0;
    f = createFont("Arial", 16, true); 
    textFont(f, 12); 
    fill(255);
    text("musique premier plan : "+(int)jingle2.position()/1000, 500, 30);
    text("musique arrière plan : "+(int)jingle.position()/1000, 500, 50);
    if (jingle.position() > 1800 && start) {
      start = false;
      jingle2.play(0);
    }
    stroke(255, 255, 255, 50);

    fft.forward(jingle.mix);
    r = 0;
    g = 0;
    b=0;
    for (int i = 0; i < 29; i++) {

      // What is the average height in relation to the screen height?
      float amplitude = fft.getAvg(i);

      // If we hit a threshhold, then set the circle radius to new value
      if (amplitude<audioThresh) {
        circles[i] = amplitude*(height/3);
      } else { // Otherwise, decay slowly
        circles[i] = max(0, min(height, circles[i]-4));
      }

      // What is the centerpoint of the this frequency band?
      float centerFrequency = fft.getAverageCenterFrequency(i);

      // What is the average width of this freqency?
      float averageWidth = fft.getAverageBandWidth(i);

      // Get the left and right bounds of the frequency
      float lowFreq = centerFrequency - averageWidth/2;
      float highFreq = centerFrequency + averageWidth/2;

      // Convert frequency widths to actual sizes
      int xl = (int)fft.freqToIndex(lowFreq);
      int xr = (int)fft.freqToIndex(highFreq);



      // Calculate the gray value for this circle
      //    stroke(amplitude*255);
      println(amplitude);
      stroke(map(amplitude, 0, 1, 0, 255), 0, 0, amplitude*255);
      strokeWeight(map(amplitude, 0, 1, STROKE_MIN, STROKE_MAX));
      //    strokeWeight((float)(xr-xl)*strokeMultiplier);

      // Draw an ellipse for this frequency
      fill(map(amplitude, 0, 1, 0, 255), 0, 0);
      ellipse(height/2+60, width/2-40, circles[i], circles[i]);
    }
    for (int i = 0; i < 30; i++)
    {
      moy += fft.getBand(i);
      if (i<5) {
        r+= fft.getBand(i);
      }
      if (i>=5 && i<10) {
        g+= fft.getBand(i)*2;
      }
      if (i>=10 && i<15) {
        b+= fft.getBand(i)*2;
      }
      float c = fft.getBand(i) * 16;

      fill(r, g, b, 100);

      ellipse(20+(i*10), height-150, 7, fft.getAvg(i) * 5);
    }

    if (moy/10 > 50 && jingle.position() - pick > 500 ) {

      mesBulles.add(new Bulle(random(50, 550), random(50, 550), 60, 3));
      pick = jingle.position();
    }
    //if (cpt > pop) {
    //mesBulles.add(new Bulle(random(50, 550), random(50, 550), 60, 3));
    //cpt=0;
    //pop = random(30, 100);
    //}
    for (int i = mesBulles.size()-1; i >= 0; i--) { 
      Bulle maBulle = mesBulles.get(i);
      maBulle.update();
      if (maBulle.finished()) {
        mesBulles.remove(i);
      }
    }
    cpt++;
  }
}