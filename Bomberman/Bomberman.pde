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
  //drawCreatures();
}

void drawMap() {
  int x = 0 ;
  for (int i = 1; i < grid.length; i++) {
    x = i * width / 17;
    line(x, 0, x, height);
  }
  for (int i = 1; i < grid.length; i++) {
    x = i * height / 13;
    line(0, x, width, x);
  }
 for (int r = 0; r < grid.length; r++) {
   for (int c = 0; c < grid[0].length; c++) {
     if (r==0 || c==0 || r == 12 || c == 16 || (r%2==0 && c%2==0)) {
       grid[r][c] = new Block(2);
     }
     else {
       grid[r][c] = new Block(0);
     }
     if (grid[r][c].type == 0) {
       int percentage = 45 + level;
       if (percentage > 90) {
         percentage = 90;
       }
       int test = (int) random(100);
       if (test <= percentage) {
         grid[r][c] = new Block(1);
       }
     }
   }
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