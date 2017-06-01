Block[][] grid;
int level;
int range;
Attacker[] attackers;
Bomb[] bombs;
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
  for (int i = 0; i < attackers.length; i++) {
    if (attackers[i].xcor == main.xcor && attackers[i].ycor == main.ycor) {
      noLoop();
      gameOver();
    }
    /*(bombFire == main) {
      noLoop();
      gameOver();
    }
    else if (bombFire == attacker) {
      attacker = null;
    }
    */
  }
}

void drawCreatures() {
  for (int i = 0; i < attackers.length; i++) {
    //draw attacker based on coors
  }
  for (int i = 0; i < bombs.length; i++) {
    //draw attacker based on coors
  }
  //draw mainplayer
}

void gameOver() {
  
}