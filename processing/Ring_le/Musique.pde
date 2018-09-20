import ddf.minim.analysis.*;
import ddf.minim.*;

class Musique {



  Minim minim;
  AudioPlayer jingle;
  //AudioPlayer jingle2;
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
  float gain = 100;
int tbase = 512;
  float[] myBuffer;
  float DECAY_RATE = 2;
  float spectrumScale = 2;
  float STROKE_MAX = 3;
  float STROKE_MIN = 1;
  float strokeMultiplier = 1;
  float audioThresh = .5;
float R=125;
  float centerR=125;
  float a=PI/2;
  float a1=PI;
  float a2=3*PI/2;
  float pathR=125;
  float pathG=125;
  float G=125;
  float centerG=125;
  float pathB=125;
  float B=125;
  float centerB=125;

  Musique(AudioPlayer j) {
    jingle = j;
    //jingle2 = j2;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    myBuffer = new float[jingle.bufferSize()];
    fft.logAverages( 22, 3);
    jingle.play(0);
  }
  void update() {
    for (int i = 0; i < jingle.bufferSize(); ++i) {
      myBuffer[i] = jingle.left.get(i);
    }
    // find trigger point as largest +ve slope in first 1/4 of buffer
  int offset = 0;
  float maxdx = 0;
  for(int i = 0; i < myBuffer.length/4; ++i)
  {
      float dx = myBuffer[i+1] - myBuffer[i]; 
      if (dx > maxdx) {
        offset = i;
        maxdx = dx;
      }
  }
  // plot out that waveform
  int mylen = min(tbase, myBuffer.length-offset);
  for(int i = 0; i < mylen -1; i = i + 1)
  {
    float x1 = map(i, 0, tbase, 0, width);
    float x2 = map(i+1, 0, tbase, 0, width);
    stroke(pathR,pathG,pathB);
    line(x1, 100 - myBuffer[i+offset]*gain, x2, 100 - myBuffer[i+1+offset]*gain);
    pathR=centerR+R*sin(a);
    a=a+.01;
    pathG=centerG+G*sin(a1);
    a1=a1+.01;
    pathB=centerB+B*sin(a2);
    a2=a2+.01;
  }
    float moy = 0;
    f = createFont("Arial", 16, true); 
    textFont(f, 12); 
    fill(255);
    text("musique premier plan : "+(int)jingle.position()/1000, 500, 30);
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
        circles[i] = amplitude*(height)*0.4;
      } else { // Otherwise, decay slowly
        circles[i] = max(0, min(height, circles[i]-0.01));
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
      stroke(map(amplitude, 0, 1, 0, 255), 0, map(amplitude, 0, 1, 0, 102), amplitude*255);
      strokeWeight(map(amplitude, 0, 1, STROKE_MIN, STROKE_MAX));
      //    strokeWeight((float)(xr-xl)*strokeMultiplier);

      // Draw an ellipse for this frequency
      fill(map(amplitude, 0, 1, 0, 255), 0, map(amplitude, 0, 1, 0, 102),150);
      ellipse(height/2+60, width/2-40, circles[i], circles[i]);
    }
    println();
    for (int i = 0; i < fft.specSize(); i++)
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

      ellipse(20+(i*10), height-150, 7, fft.getBand(i) * 5);
    }

    if (moy/10 > 50 && jingle.position() - pick > 500 ) {

      //mesBulles.add(new Bulle(random(50, 550), random(50, 550), 60, 3));
      //pick = jingle.position();
    }
    //if (cpt > pop) {
    //mesBulles.add(new Bulle(random(50, 550), random(50, 550), 60, 3));
    //cpt=0;
    //pop = random(30, 100);
    //}
    //for (int i = mesBulles.size()-1; i >= 0; i--) { 
    //  Bulle maBulle = mesBulles.get(i);
    // maBulle.update();
    //  if (maBulle.finished()) {
    //    mesBulles.remove(i);
    //  }
    //}
    cpt++;
  }
}
