class Attacker extends Creature {
  int dir;
  ArrayList<Integer> moves;
  int count = 0;
  int rand = 0;
  Block[][] grid;

  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker", map);
    moves = new ArrayList<Integer>();
    moves.add(0);
    moves.add(1);
    moves.add(2);
    moves.add(3);
    speed = 1;
  }
  
  boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  void move(Map map) {
    grid = map.grid;
    // PETER make sure the feet are not bouncing up and down
    if (dir == 0) {
      if (grid[(ycor-48)/48][xcor/48].type != 0) {
        moves.remove(0);
        rand = (int) random(3);
        update(moves.get(rand));
        moves.add(0, 0);
      }
    } else if (dir == 1) {
      if (grid[ycor/48][(xcor+48)/48].type != 0) {
        moves.remove(1);
        rand = (int) random(3);
        update(moves.get(rand));
        moves.add(1, 1);
      }
    } else if (dir == 2) {
      if (grid[(ycor+48)/48][xcor/48].type != 0) {
        moves.remove(2);
        rand = (int) random(3);
        update(moves.get(rand));
        moves.add(2, 2);
      }
    } else if (dir == 3) {
      if (grid[ycor/48][(xcor-48)/48].type != 0) {
        moves.remove(3);
        rand = (int) random(3);
        update(moves.get(rand));
        moves.add(3, 3);
      }
    }
  }
}