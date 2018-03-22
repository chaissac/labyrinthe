// Générateur de Labyrinthe
Laby dedale;
int iterations;
void setup() {
  size(700, 700);
  frameRate(300);
  init(3, 30); // (methode, cell Size)
}
void draw() {
  background(127);
  if (!dedale.go()) {
    println("Terminé en "+iterations+" itérations");
    noLoop();
  } else iterations++;
  dedale.trace();
}
void init(int l, int wdth) {
  iterations = 0;
  switch (l) {
  case 1 : 
    dedale = new Laby1(wdth);
    break;
  case 2 : 
    dedale = new Laby2(wdth); 
    break;  
  case 3 : 
    dedale = new Laby3(wdth);
    break;
  }
}