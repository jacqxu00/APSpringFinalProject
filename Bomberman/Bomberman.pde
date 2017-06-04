Block[][] grid;
int level;
int range;
ArrayList<Attacker> attackers;
ArrayList<Bomb> bombs;
Player main;
PImage background;

void setup() {
  size(720, 612);
  background(255);
  main = new Player();
  
  //temp
  background = loadImage("field.png");
  
  grid = new Block[17][13];
}

void draw() {
  drawMap();
  main.move();
  main.checkWalls();
}

void drawMap() {
  int x = 0 ;
  
  //temp
  image(background, 0, 0);
  
  for (int r = 0; r < grid.length; r++) {
    for (int c = 0; c < grid[0].length; c++) {
      if (r==0 || c==0 || r == 12 || c == 16 || (r%2==0 && c%2==0)) {
        grid[r][c] = new Block(2);
      } else {
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