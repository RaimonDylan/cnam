
PFont f;
int t = 120;
int i = 0;
int a = 4;
void setup()
{
  size(700,700);
  frameRate(60);
}

void draw()
{
 if(i%60 == 0) a--;
  background(255);
  
  i++;
  
}
