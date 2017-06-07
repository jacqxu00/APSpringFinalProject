int level;
int range;
Map map;
Player main;
Attacker attacker;
Bomb bomb;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  map = new Map(level);
  main = new Player(50, 50);

  //temp
  attacker = new Attacker(48*5, 48*7);
  bomb = new Bomb(48*7, 48*7, 1);
  
}

void draw() {
  map.display();
  bomb.display();

  //temp
  //this is for the "3d" aspect dealing with image overlaps
  if (main.ycor < attacker.ycor) {
    main.move();
    map.check(main);
    //attacker.move();
    //map.check(attacker);
  } else {
    //attacker.move();
    //map.check(attacker);
    main.move();
    map.check(main);
  }
}

  void gameOver() {
  }