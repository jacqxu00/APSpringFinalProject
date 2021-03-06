class Player extends Creature {
  int numBombs;
  float jumpFrame = 0.0;
  ArrayList<Bomb> bombs;
  ArrayList<PImage[][]> fires;
  ArrayList<PImage> jump;
  int range;

  Player(int xcor, int ycor) {
    super(xcor, ycor, "player", map);
    jump = new ArrayList<PImage>();
    for (int i = 0; i < 4; i++) {
      jump.add(loadImage("player/jump" + i + ".png"));
    }
    numBombs = 1;
    bombs = new ArrayList<Bomb>();
    fires = new ArrayList<PImage[][]>();
    loadFires();
    range = 1;
  }

  void move() {
    if (alive) {
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
        boolean state = false;
        boolean pstate = false;
        state = keyPressed;
        if (state != pstate) {
          drop();
          pstate = state;
        }
      } else if (keyPressed && key == 'r') {
        xcor = 50;
        ycor = 50;
      } else {
        frame = 0;
        //makes the character look wherever it was headed to when it stops
        image(resting, xcor, ycor);
      }
    }
  }

  void drop() {
    if (bombs.size() < numBombs) {
      bombs.add(new Bomb((xcor+24)/48 * 48, (ycor+70)/48 * 48, range, fires, map));
    }
  }

  void update(int dir) {
    if (alive) {
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

  void die() {
    alive = false;
    walk = false;
    if (count < 4) {
      image(dead.get((int)count), xcor, ycor);
    }
    count += 0.15;
  }

  void loadFires() {
    PImage[][] fireCenter = new PImage[4][3];
    for (int i = 0; i < 4; i++) {
      fireCenter[i][0] = loadImage("bomb/firecenter" + i + "0.png");
    }
    PImage[][] fireRight = new PImage[4][2];
    PImage[][] fireLeft = new PImage[4][2];
    PImage[][] fireUp = new PImage[4][2];
    PImage[][] fireDown = new PImage[4][2];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        for (int h = 0; h < 2; h++) {
          if (i == 0) {
            fireRight[j][h] = loadImage("bomb/fireright" + j + h + ".png");
          } else if (i == 1) {
            fireLeft[j][h] = loadImage("bomb/fireleft" + j + h + ".png");
          } else if (i == 2) {
            fireUp[j][h] = loadImage("bomb/fireup" + j + h + ".png");
          } else {
            fireDown[j][h] = loadImage("bomb/firedown" + j + h + ".png");
          }
        }
      }
    }
    fires.add(fireCenter);
    fires.add(fireRight);
    fires.add(fireLeft);
    fires.add(fireUp);
    fires.add(fireDown);
  }

  void jump() {
    alive = false;
    walk = false;
    image(jump.get((int)jumpFrame), xcor, ycor);
    jumpFrame += 0.175;
    if (jumpFrame >= 4) {
      jumpFrame = 0;
    }
  }
}