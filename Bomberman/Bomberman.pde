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
}

void draw() {
  map.display(main);
  map.changes(main);

  main.move();
  map.check(main);
  for (Attacker attacker : map.attackers) {
    attacker.move();
    map.check(attacker);
  }
  
  checkClear();
}

void gameOver() {
}

void checkClear() {
  if (map.checkClear()) {
    map = new Map(level + 10);
  }
}