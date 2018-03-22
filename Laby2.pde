class Laby2 extends Laby { //méthode Recursive Backtracker : https://en.wikipedia.org/wiki/Maze_generation_algorithm
  boolean[][] mursV, mursH, cases;
  int tailleX, tailleY;
  PVector current ;
  float w ;
  ArrayList<PVector> pile = new ArrayList<PVector>();
  int aFaire;
  public Laby2(int _w) {
    print("Génération Layrinthe version 2 (variante de 1)... ");
    w = _w;
    tailleX = floor((width-10)/w);
    tailleY = floor((height-10)/w);
    aFaire = tailleX*tailleY;
    cases=new boolean[tailleX][tailleY];
    mursV=new boolean[tailleX+1][tailleY];
    mursH=new boolean[tailleX][tailleY+1];
    current = new PVector(int(random(tailleX)), int(random(tailleY)));
    for (int j=0; j<=tailleY; j++) 
      for (int i=0; i<=tailleX; i++) 
        mursV[i][min(tailleY-1, j)]=mursH[min(tailleX-1, i)][j]=true;
    visite(current);
  }
  void visite(PVector c) {
    cases[int(c.x)][int(c.y)]=true;
    aFaire--;
  }
  public void trace() {
    for (int j=0; j<=tailleY; j++) 
      for (int i=0; i<=tailleX; i++) {
        float x = i*w+5;
        float y = j*w+5;
        noStroke();
        if (j<tailleY && i<tailleX) {
          fill((i==current.x && j==current.y)?#F04090:(cases[i][j]?#00A0A0:#FFFFFF));
          rect(x, y, w, w);
        }
        fill(0);
        if (j<tailleY) if (mursV[i][j]) rect(x, y, 2, w);
        if (i<tailleX) if (mursH[i][j]) rect(x, y, w, 2);
      }
  }
  int fait(float x, float y) {
    if (x<0 || x>=tailleX || y<0 ||y>=tailleY) return 1; 
    else return cases[int(x)][int(y)]?1:0;
  }
  void ouvre(float x, float y, int d) {
    // 0:T   1:R   2:B   3:L
    if (d==0) mursH[int(x)][int(y)]=false;
    if (d==2) mursH[int(x)][int(y+1)]=false;
    if (d==1) mursV[int(x+1)][int(y)]=false; 
    if (d==3) mursV[int(x)][int(y)]=false;
  }
  public boolean go() {
    if (aFaire==0) {
      current.set(-1, -1);
      trace();
      return false;
    }
    int nb = fait(current.x, current.y-1)+fait(current.x+1, current.y)+fait(current.x, current.y+1)+fait(current.x-1, current.y);
    if (nb==4) {
      if (pile.size()>0) {      
        current = pile.get(pile.size()-1);
        pile.remove(pile.size()-1);
      } else {
        return false;
      }
    } else {
      int x, y, d;
      do {
        d=int(random(4));
        y=int(current.y)+(d-1)%2;
        x=int(current.x)+(2-d)%2;
      } while (fait(x, y)==1);
      if (nb<3) pile.add(current.copy());
      ouvre(current.x, current.y, d);
      current.set(x, y);
      visite(current);
    }
    return true;
  }
}