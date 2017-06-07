int level;
int range;
Map map;
Player main;
Attacker attacker;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  map = new Map(level);
  main = new Player(50, 50);

  //temp
  attacker = new Attacker(100, 100);
}

void draw() {
  map.display();
  main.move();
  //temp
  attacker.move();
  map.check(main);
  //temp
  map.check(attacker);
}

void gameOver() {
}