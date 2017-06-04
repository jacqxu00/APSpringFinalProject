int level;
int range;
Map map;
Player main;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  map = new Map(level);
  main = new Player(1,1);
}

void draw() {
  map.display();
  main.move();
  map.check(main);
}

void gameOver() {
}