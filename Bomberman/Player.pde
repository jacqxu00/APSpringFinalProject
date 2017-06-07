class Player extends Creature {
  int numBombs;

  Player(int xcor, int ycor) {
    super(xcor, ycor, "player");
  }

  void move() {
    if (keyPressed && key == CODED && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)) {
      if (keyCode == UP) {
        update(0);
      } else if (keyCode == RIGHT) {
        update(1);
      } else if (keyCode == DOWN) {
        update(2);
      } else {
        update(3);
      }
    } else if (keyPressed && key == ' ') {
      drop();
    } else {
      frame = 0;
      //makes the character look wherever it was headed to when it stops
      image(resting, xcor, ycor);
    }
  }

  Bomb drop() {
    return new Bomb(xcor/48 * 48, ycor/48 * 48, range);
  }
}