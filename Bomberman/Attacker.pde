class Attacker extends Creature {
  int dir;
  ArrayList<Integer> moves;
  int count = 0;
  int rand = 0;
  Block[][] grid;
  boolean deadEnd;


  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker", map);
    deadEnd = false;
    moves = new ArrayList<Integer>();
    speed = 1;
  }

  boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  void move(Map map) {
    //if (count == 0) {
    //  rand = (int) random(4);
    //}
    //update(rand);
    //count++;
    //if (count >= 48) {
    //  count = 0;
    //}
    grid = map.grid; //PETER something about the grid checking cors is wrong i think
    if (dir == 0 && grid[(ycor-48)/48][xcor/48].type != 0 || dir == 1 && grid[ycor/48][(xcor+48)/48].type != 0 ||
    dir == 2 && grid[(ycor+48)/48][xcor/48].type != 0 || dir == 3 && grid[ycor/48][(xcor-48)/48].type != 0) {
      rand = (int) random(4);
    }
    update(rand);
    //grid = map.grid;
    //// PETER make sure the feet are not bouncing up and down
    //if (dir == 0 && grid[(ycor-48)/48][xcor/48].type != 0 || dir == 1 && grid[ycor/48][(xcor+48)/48].type != 0 ||
    //  dir == 2 && grid[(ycor+48)/48][xcor/48].type != 0 || dir == 3 && grid[ycor/48][(xcor-48)/48].type != 0) {
    //  deadEnd = true;
    //}
    //if (deadEnd) {
    //  if (grid[(ycor-48)/48][xcor/48].type == 0) {
    //    moves.add(0);
    //  }
    //  if (grid[ycor/48][(xcor+48)/48].type == 0) {
    //    moves.add(1);
    //  }
    //  if (grid[(ycor+48)/48][xcor/48].type == 0) {
    //    moves.add(2);
    //  }
    //  if (grid[ycor/48][(xcor-48)/48].type == 0) {
    //    moves.add(3);
    //  }
    //  rand = (int) random(moves.size());
    //  update(moves.get(rand));
    //  moves.clear();
    //}
  }
}