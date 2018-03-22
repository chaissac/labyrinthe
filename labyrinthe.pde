// Générateur de Labyrinthe
Laby dedale;
int iterations = 0;
void setup() {
  size(700, 700);
  frameRate(150);
  init(1);
}
void draw() {
  background(127);
  dedale.trace(); 
  if (!dedale.go()) {
    println("Terminé en "+iterations+" itérations");
    noLoop();
  } else iterations++;
}
void init(int l) {
  switch (l) {
  case 1 : 
    dedale = new Laby1(30); // taille d'une cellule
    break;
  case 2 : 
    dedale = new Laby2(30); // taille d'une cellule
    break;
  }
}