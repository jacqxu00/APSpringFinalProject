class Player extends Creature {
  int numBombs;
  int sizeVer = 45, sizeHor = 50, speed = 3;
  float frame = 0.0;
  boolean walk = true;
  PImage resting;
  ArrayList<PImage> down, right, up, left, dead;
  boolean motion;
  int range;

  Player(int xcor, int ycor, int range) {
    this.xcor = xcor;
    this.ycor = ycor;
    this.range = range;
    down = new ArrayList<PImage>();
    right = new ArrayList<PImage>();
    up = new ArrayList<PImage>();
    left = new ArrayList<PImage>();
    dead = new ArrayList<PImage>();

    //adding all sprites to its respective arraylists
    for (int i = 0; i < 7; i++) {
      PImage current = loadImage("down" + i + ".png");
      current.resize(sizeVer, 0);
      down.add(current);
    }
    resting = down.get(0);
    for (int i = 0; i < 7; i++) {
      PImage current = loadImage("right" + i + ".png");
      current.resize(sizeHor, 0);
      right.add(current);
    }
    for (int i = 0; i < 7; i++) {
      PImage current = loadImage("up" + i + ".png");
      current.resize(sizeVer, 0);
      up.add(current);
    }
    for (int i = 0; i < 7; i++) {
      PImage current = loadImage("left" + i + ".png");
      current.resize(sizeHor, 0);
      left.add(current);
    }
    for (int i = 0; i < 4; i++) {
      PImage current = loadImage("dead" + i + ".png");
      current.resize(sizeVer, 0);
      dead.add(current);
    }
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

  Bomb drop() {
    return new Bomb((xcor+resting.width/2)/48 * 48, (ycor+resting.height-5)/48 * 48, range);
  }
}