int level, clearCount;
int range;
Map map;
Player main;
Attacker attacker;
Fire fire;

void setup() {
  level = 4;
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
  textSize(24);
  fill(#851818);
  String s = "LEVEL: " + level;
  text(s, 20, 32);
  fill(#851818);
  String t = "RANGE: "+main.range;
  text(t, 300, 32);
  fill(#851818);
  String u = "BOMBS: "+main.numBombs;
  text(u, 580, 32);
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