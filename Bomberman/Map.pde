class Map {
  Block[][] grid;
  int level;

  Map(int level) {
    grid = new Block[15][13];
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
        if (r == 0 || c == 0 || r == 14 || c == 12) {
          //wall
          grid[r][c] = new Block(2);
        } else if (r%2==0 && c%2==0) {
          //solid
          grid[r][c] = new Block(1);
        } else {
          //grass
          grid[r][c] = new Block(0);
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
        grid[r][c].display(r*48, c*48);
      }
    }
  }
}