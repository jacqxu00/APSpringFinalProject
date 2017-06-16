class Attacker extends Creature {
  int dir;
  ArrayList<Integer> moves;
  int count = 0;
  Block[][] grid;
  boolean deadEnd, move;

  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker", map);
    move = true;
    deadEnd = false;
    moves = new ArrayList<Integer>();
    speed = 1;
  }

  boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  void move(Map map) {
    if (move) {
      grid = map.grid;
      if (dir == 0 && grid[(xcor+24)/48][(ycor+74-48)/48].type != 0 || dir == 1 && grid[(xcor+6+48)/48][(ycor+70)/48].type != 0 ||
        dir == 2 && grid[(xcor+24)/48][(ycor+32+48)/48].type != 0 || dir == 3 && grid[(xcor+42-48)/48][(ycor+70)/48].type != 0) {
        dir = (int) random(4);
      }
      for (Bomb b : main.bombs) { //not working
        if (dir == 0 && (xcor+24)/48 == b.xcor && (ycor+74-48)/48 == b.ycor || dir == 1 && (xcor+6+48)/48 == b.xcor && (ycor+70)/48 == b.ycor ||
          dir == 2 && (xcor+24)/48 == b.xcor && (ycor+32+48)/48 == b.ycor || dir == 3 && (xcor+42-48)/48 == b.xcor && (ycor+70)/48 == b.ycor) {
          dir = (int) random(4);
        }
      }
      update(dir);
    }
  }
}