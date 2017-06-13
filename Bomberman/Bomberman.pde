int level;
int range;
Map map;
Player main;
Attacker attacker;
Fire fire;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  map = new Map(level);
  main = new Player(50, 50);
  fire = new Fire(width/2, height/2, 3, 1, main.fires);
}

void draw() {
  map.display(main);
  map.changes(main);

  main.move();
  map.check(main);
  for (Attacker attacker : map.attackers) {
    attacker.move(map);
    map.check(attacker);
    for (Bomb bomb : main.bombs) {
      bomb.check(attacker);
    }
  }
  checkClear();
}

void checkClear() {
  if (map.checkClear()) {
    level++;
    map = new Map(level);
  }
}