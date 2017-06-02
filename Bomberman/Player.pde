class Player extends Creature {
  int numBombs;

  void move() {
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP) {
          move(0, -50);
        } else if (keyCode == DOWN) {
          move(0, 50);
        } else if (keyCode == LEFT) {
          move(-50, 0);
        } else if (keyCode == RIGHT) {
          move(0, 50);
        }
      }
      if (key == 'b' || key == 'B') {
        drop();
      }
    }
  }

  void drop() {
    Bomb a = new Bomb(xcor, ycor, range);
  }
}