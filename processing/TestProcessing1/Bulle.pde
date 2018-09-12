class Bulle { 
  int posX;
  int posY;
  int t1;
  int t2;
  int t;
  Bulle (int posX, int posY, int t1, int t2) {  
    this.posX = posX;
    this.posY = posY;
    this.t1 = t1; 
    this.t2 = t2;
    this.t = t*2;
  } 
  void addBulle() {  
    fill(0, 0, 0);
    ellipse(posX, posY,t1, t2);
    noFill();
    ellipse(posX, posY, t, t);
    f = createFont("Arial", 16, true); 
    textFont(f, 25); 
    textAlign(CENTER);
    fill(255, 255, 255);
    text(a, posX, posY+10);
  }
  
   void update() {  
    t = t-1;
    fill(0, 0, 0);
    ellipse(posX, posY,t1, t2);
    noFill();
    ellipse(posX, posY, t, t);
    f = createFont("Arial", 16, true); 
    textFont(f, 25); 
    textAlign(CENTER);
    fill(255, 255, 255);
    text(a, posX, posY+10);
  }
} 
