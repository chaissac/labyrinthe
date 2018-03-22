class Laby3 extends Laby { //méthode Randomized Kruskal's algorithm : https://en.wikipedia.org/wiki/Maze_generation_algorithm
  int[] cells ;
  int[] wall ;
  ArrayList<Integer> walls = new ArrayList<Integer>() ;
  int tailleX, tailleY, taille;
  PVector current ;
  float w ;
  public Laby3(int _w) {
    print("Génération Layrinthe version 3 ... ");
    w = _w;
    tailleX = floor((width-10)/w);
    tailleY = floor((height-10)/w);
    taille = tailleX*tailleY;
    cells = new int[taille];
    wall = new int[2*taille];
    int index = 0;
    for (int j=0; j<tailleY; j++) 
      for (int i=0; i<tailleX; i++) {
        cells[index]=index+1;
        if (i>0) {
          wall[index*2]=index;
          walls.add(index*2);
        }
        if (j>0) {
          wall[index*2+1]=index;
          walls.add(index*2+1);
        }
        index++;
      }
  }
  public void trace() {
    noStroke();
    textAlign(CENTER, CENTER);
    textSize(w/3);
    for (int y=0; y<tailleY; y++) 
      for (int x=0; x<tailleX; x++) {
        fill(cells[x+y*tailleY]==1?#F080C0:#606060);
        rect(x*w+4, y*w+4, w, w);
        fill(#F080C0);
        text(cells[x+y*tailleY], x*w+4+w/2, y*w+4+w/2);
      }
      fill(0);
    for (int i=0; i<2*taille; i++) 
      if (wall[i]!=0) 
        rect((wall[i]%tailleX)*w+4, floor(wall[i]/tailleX)*w+4, 2+(i%2)*(w-2), w+(i%2)*(2-w));
    noFill();
    stroke(0);
    strokeWeight(2);
    rect(4, 4, tailleX*w, tailleY*w);
  }
  public boolean go() {
    int total=taille;
    int n = floor(random(walls.size()));
    int i = walls.get(n);
    int a = cells[wall[i]];
    int b = (i%2==0)?cells[wall[i]-1]:cells[wall[i]-tailleX];
    if (a!=b) {
      for (int j=0; j<taille; j++) {
        if (cells[j]==max(a, b)) cells[j]=min(a, b);
        if (cells[j]==1) total--;
      }
      wall[i]=0;
    }
    walls.remove(n);
    return total!=0;
  }
}