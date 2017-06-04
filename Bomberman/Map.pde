class Map {
  Block[][] grid;
  int level;

  Map(int level) {
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
        //  int percentage = 45 + level;
        //  if (percentage > 90) {
        //    percentage = 90;
        //  }
        //  int test = (int) random(100);
        //  if (test <= percentage) {
        //    grid[r][c] = new Block(1);
        //  }
        //}
      }
    }
  }

  void display() {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].display();
      }
    }
  }
  
  void check(Player player) {
    checkWalls(player);
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].check(player);
      }
    }
  }
  
  void checkWalls(Player player) {
    int x = player.x;
    int y = player.y;
    if (x <= 45 || y <= 0 || x >= width - 90 || y >= height - 45 - player.resting.height) {
      player.walk = false;
      //need to change the coordinate in order for it to get out of this boolean cycle
      if (x <= 45) {
        player.x++;
      }
      if (y <= 0) {
        player.y++;
      }
      if (x >= width - 90) {
        player.x--;
      }
      if (y >= height - 45 - player.resting.height) {
        player.y--;
      }
    } else {
      player.walk = true;
    }
  }
}