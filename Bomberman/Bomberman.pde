Block[][] grid;
int level;
int range;
ArrayList<Attacker> attackers;
ArrayList<Bomb> bombs;
Player main;

void setup() {
  size(850, 650);
  background(255);
  grid = new Block[17][13];
}

void draw() {
  drawMap();
  drawCreatures();
}

void drawMap() {
  int x = 0 ;
  for (int i = 1; i <= grid.length; i++) {
    x = i * width / 17;
    line(x, 0, x, height);
  }
  for (int i = 1; i <= grid.length; i++) {
    x = i * width / 17;
    line(0, x, width, x);
  }
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
}

void drawCreatures() {
  for (int i = 0; i < attackers.size(); i++) {
    //draw attacker based on coors
  }
  for (int i = 0; i < bombs.size(); i++) {
    //draw attacker based on coors
  }
  //draw mainplayer
}

void gameOver() {
}