int level;
int range;
ArrayList<Attacker> attackers;
ArrayList<Bomb> bombs;
Player main;
PImage background;
Map map;

void setup() {
  size(720, 624);
  main = new Player();
  map = new Map(1);
}

void draw() {
  map.display();
  main.move();
  map.check(main);
}

void changes() {
  for (Attacker a : attackers) {
    if (a.xcor == main.xcor && a.ycor == main.ycor) {
      noLoop();
      gameOver();
    }
  }
  for (Bomb b : bombs) {
    ArrayList<Fire> LofFire = b.fire;
    for (Fire f : LofFire) {
      if (f.xcor == main.xcor && f.ycor == main.ycor) {
        noLoop();
        gameOver();
      }
      for (Attacker a : attackers) {
        if (f.xcor == a.xcor && f.ycor == a.ycor) {
          //die animation
          a = null;
        }
      }
    }
  }
  //moving changes
}
/*
void drawCreatures() {
 for (int i = 0; i < attackers.size(); i++) {
 //draw attacker based on coors
 }
 for (int i = 0; i < bombs.size(); i++) {
 //draw attacker based on coors
 }
 //draw mainplayer
 }
 */
void gameOver() {
}