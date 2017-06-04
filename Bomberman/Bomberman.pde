int level;
int range;
Map map;
Player main;

void setup() {
  level = 1;
  range = 1;
  size(720, 624);
  map = new Map(level);
  System.out.println(map.grasses());
  //figure out how to make it so that it doesn't get stuck in a 2/1 spot
  int iPlayer = (int) random(map.grasses.size());
  main = new Player(map.grasses.get(iPlayer).xcor, map.grasses.get(iPlayer).ycor);
  System.out.println(main.xcor/48+","+main.ycor/48);
}

void draw() {
  map.display();
  main.move();
  map.check(main);
}

void gameOver() {
}