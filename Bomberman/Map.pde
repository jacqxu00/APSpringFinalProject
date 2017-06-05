class Map {
  Block[][] grid;
  int level;
  Portal portal;
  ArrayList<Attacker> attackers;
  ArrayList<Bomb> bombs;
  ArrayList<Block> bricks;

  Map(int level) {
    bricks = new ArrayList<Block>();
    grid = new Block[15][13];
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
        if (r == 0 || c == 0 || r == 14 || c == 12) {
          //wall
          grid[r][c] = new Block(2, r*48, c*48);
        } else if (r%2==0 && c%2==0) {
          //solid
          grid[r][c] = new Block(3, r*48, c*48);
        } else {
          //grass
          grid[r][c] = new Block(0, r*48, c*48);
        }
        //if (grid[r][c].type == 0) {
        //  //brick
        //  int percentage = 45 + level;
        //  if (percentage > 90) {
        //    percentage = 90;
        //  }
        //  int test = (int) random(100);
        //  if (test <= percentage && !(r <=2 && c <= 2)) {
        //    Block newBlock = new Block(1, r*48, c*48);
        //    grid[r][c] = newBlock;
        //    bricks.add(newBlock);
        //  }
        //}
      }
    }
    //int iPortal = (int) random(bricks.size());
    //portal = new Portal(bricks.get(iPortal).xcor, bricks.get(iPortal).ycor);
  }
  
  void display() {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].display();
      }
    }
  }

  void check(Player player) {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].check(player);
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
  /*void drawCreatures() {
   for (int i = 0; i < attackers.size(); i++) {
   //draw attacker based on coors
   }
   for (int i = 0; i < bombs.size(); i++) {
   //draw attacker based on coors
   }
   //draw mainplayer
   }
   */
}