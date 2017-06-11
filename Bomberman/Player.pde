class Player extends Creature {
  int numBombs;
  ArrayList<Bomb> bombs;


  Player(int xcor, int ycor) {
    super(xcor, ycor, "player");
    numBombs = 1;
    bombs = new ArrayList<Bomb>();
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

   void drop() {
    if (bombs.size() < numBombs) {
      bombs.add(new Bomb(xcor/48 * 48, (ycor+48)/48 * 48, range));
    }
  }

  void update(int dir) {
    if (dir == 0) {
      if (walk) {
        ycor -= speed;
      }
      image(up.get((int)frame), xcor, ycor);
      resting = up.get(0);
    } else if (dir == 1) {
      if (walk) {
        xcor += speed;
      }
      image(right.get((int)frame), xcor, ycor);
      resting = right.get(0);
    } else if (dir == 2) {
      if (walk) {
        ycor += speed;
      }
      image(down.get((int)frame), xcor, ycor);
      resting = down.get(0);
    } else {
      if (walk) {
        xcor -= speed;
      }
      image(left.get((int)frame), xcor, ycor);
      resting = left.get(0);
    }
    //this slows the animation down
    frame += 0.175;
    if (frame >= 7) {
      frame = 0;
    }
  }
}