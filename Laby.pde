class Laby {
  Case[][] table ;
  int tailleX, tailleY;
  PVector current ;
  float w ;
  ArrayList<PVector> pile = new ArrayList<PVector>();
  int aFaire;
  public Laby(int _w) {
    w = _w;
    tailleX = floor(width/w);
    tailleY = floor(height/w);
    aFaire = tailleX*tailleY;
    table=new Case[tailleX][tailleY];
    current = new PVector(int(random(tailleX)), int(random(tailleY)));
    for (int j=0; j<tailleY; j++) 
      for (int i=0; i<tailleX; i++) 
        table[i][j]=new Case(i, j);
    visite(current);
  }
  public Case cell(float i, float j) {
    return table[int(i)][int(j)];
  }
  public void visite(PVector c) {
    table[int(c.x)][int(c.y)].vue=1;
    aFaire--;
  }
  public void trace() {
    for (int j=0; j<tailleY; j++) 
      for (int i=0; i<tailleX; i++) {
        float x = i*w;
        float y = j*w;
        fill((i==current.x && j==current.y)?#F04090:(cell(i, j).vue==1?#A0A000:#FFFFFF));
        noStroke();
        rect(x, y, w, w);
        fill(0);
        if (cell(i, j).murs[0]) rect(x, y, w, 2);
        if (cell(i, j).murs[2]) rect(x, y+w-2, w, 2);
        if (cell(i, j).murs[1]) rect(x+w-2, y, 2, w);
        if (cell(i, j).murs[3]) rect(x, y, 2, w);
      }
  }
  public int fait(float x, float y) {
    if (x<0 || x>=tailleX || y<0 ||y>=tailleY) return 1; 
    else return cell(x, y).vue;
  }
  public boolean go() {
    if (aFaire==0) {
      current.set(-1,-1);
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
      cell(current.x, current.y).ouvre(d);
      current.set(x, y);
      cell(current.x, current.y).ouvre((d+2)%4);
      visite(current);
    }
    return true;
  }
}