int level, clearCount;
int range;
Map map;
Player main;
Attacker attacker;
Fire fire;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  main = new Player(50, 50);
  map = new Map(level);
  fire = new Fire(width/2, height/2, 3, 1, main.fires);
  clearCount = 0;
}

void draw() {
  map.display();
  map.changes(main);
  if (!map.gameOver) {
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
}

void checkClear() {
  if (map.checkClear(main)) {
    if (clearCount < 110) {
      main.jump();
      clearCount++;
    } else {
      clearCount = 0;
      level++;
      main = new Player(50, 50);
      map = new Map(level);
    }
  }
}