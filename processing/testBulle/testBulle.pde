
PFont f;
float t = 120;
int i = 0;
int a = 3;
int t1 = 60;
int transpa = 255;
float coef = 255/180;
void setup()
{
  size(700, 700);
  frameRate(60);
  background(255);
}

void draw()
{
  if (i == 30 || i == 59) a--;
  effacer();
  if (a > 0) {
    fill(0, 0, 0,50);
    stroke(0,0,0,50);
    ellipse(width/2, height/2, t1, t1);
    noFill();
    stroke(0,0,0);
    ellipse(width/2, height/2, t, t);
    f = createFont("Arial", 16, true); 
    textFont(f, 25); 
    textAlign(CENTER);
    fill(255, 255, 255);
    text(a, width/2, height/2+10);
    i = (i == 59)?0:i+1;
  }
  t = t - 0.7;
}

void effacer(){
  fill(255);
  noStroke();
  ellipse(width/2, height/2, t1*2, t1*2);
}
