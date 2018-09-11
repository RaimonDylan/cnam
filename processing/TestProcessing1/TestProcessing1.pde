
PFont f;
int t = 120;
int i = 0;
int a = 4;
void setup()
{
  size(700,700);
  
}

void draw()
{
 if(i%60 == 0) a--;
  background(255);
  fill(0,0,0);
  ellipse(width/2, height/2, 60 , 60);
  noFill();
  ellipse(width/2, height/2, t , t);
  f = createFont("Arial", 16, true); 
  textFont(f, 25); 
  textAlign(CENTER);
   fill(255,255,255);
  text(a, width/2, height/2+10);
  i++;
  t = t - 1;
}
