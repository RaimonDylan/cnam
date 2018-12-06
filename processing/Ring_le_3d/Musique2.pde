import ddf.minim.analysis.*;
import ddf.minim.*;

class Musique2 {

  Minim minim;
  AudioPlayer jingle;
  FFT fft;
  float specLow = 0.03; // 3%
  float specMid = 0.125;  // 12.5%
  float specHi = 0.20;   // 20%
  float scoreLow = 0;
  float scoreMid = 0;
  float scoreHi = 0;
  float oldScoreLow = scoreLow;
  float oldScoreMid = scoreMid;
  float oldScoreHi = scoreHi;
  float scoreDecreaseRate = 25;
  int nbCubes;
  Cube[] cubes;
  Musique2(AudioPlayer j) {
    
    jingle = j;
    fft = new FFT(jingle.bufferSize(), jingle.sampleRate());
    nbCubes = (int)(fft.specSize()*specHi);
    cubes = new Cube[nbCubes];
    for (int i = 0; i < nbCubes; i++) {
      cubes[i] = new Cube();
    }
    jingle.play(0);
  }

  void update() {
    fft.forward(jingle.mix);
    oldScoreLow = scoreLow;
    oldScoreMid = scoreMid;
    oldScoreHi = scoreHi;
    scoreLow = 0;
    scoreMid = 0;
    scoreHi = 0;
    for (int i = 0; i < fft.specSize()*specLow; i++)
      scoreLow += fft.getBand(i);
    for (int i = (int)(fft.specSize()*specLow); i < fft.specSize()*specMid; i++)
      scoreMid += fft.getBand(i);
    for (int i = (int)(fft.specSize()*specMid); i < fft.specSize()*specHi; i++)
      scoreHi += fft.getBand(i);
    if (oldScoreLow > scoreLow)
      scoreLow = oldScoreLow - scoreDecreaseRate;
    if (oldScoreMid > scoreMid)
      scoreMid = oldScoreMid - scoreDecreaseRate;
    if (oldScoreHi > scoreHi) 
      scoreHi = oldScoreHi - scoreDecreaseRate;
    float scoreGlobal = 0.66*scoreLow + 0.8*scoreMid + 1*scoreHi;
    background(scoreLow/100, scoreMid/100, scoreHi/100);
    
    for (int i = 0; i < nbCubes; i++)
    {
      float bandValue = fft.getBand(i);
      cubes[i].display(scoreLow, scoreMid, scoreHi, bandValue, scoreGlobal);
    }
  }
}
