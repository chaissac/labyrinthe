// Générateur de Labyrinthe, méthode Recursive Backtracker : https://en.wikipedia.org/wiki/Maze_generation_algorithm
Laby dedale;

void setup() {
  size(800, 600);
  dedale = new Laby(40); // taille d'une cellule
}
void draw() {
  background(0);
  dedale.trace();   
  if (!dedale.go()) {
    println("Terminé");
    noLoop();
  }
}