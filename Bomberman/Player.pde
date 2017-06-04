class Player extends Creature {
  int numBombs;
  int sizeVer = 45, sizeHor = 50;
  float frame = 0.0;
  boolean walk = true;
  PImage resting;
  ArrayList<PImage> down, right, up, left, dead;

  Player() {
    xcor = 100;
    ycor = 100;
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
    if (keyPressed) {
      if (key == CODED) {
        if (keyCode == UP) {
          update(0);
        } else if (keyCode == RIGHT) {
          update(1);
        } else if (keyCode == DOWN) {
          update(2);
        } else if (keyCode == LEFT) {
          update(3);
        }
      }
    } else {
      frame = 0;
      //makes the character look wherever it was headed to when it stops
      image(resting, xcor, ycor+15);
    }
  }

  void update(int dir) {
    if (dir == 0) {
      if (walk) {
        ycor -= 2;
      }
      image(up.get((int)frame), xcor, ycor+15);
      resting = up.get(0);
    } else if (dir == 1) {
      if (walk) {
        xcor += 2;
      }
      image(right.get((int)frame), xcor, ycor+15);
      resting = right.get(0);
    } else if (dir == 2) {
      if (walk) {
        ycor += 2;
      }
      image(down.get((int)frame), xcor, ycor+15);
      resting = down.get(0);
    } else {
      if (walk) {
        xcor -= 2;
      }
      image(left.get((int)frame), xcor, ycor+15);
      resting = left.get(0);
    }
    //this slows the animation down
    frame += 0.175;
    if (frame >= 7) {
      frame = 0;
    }
  }

  //temporary checking walls but won't need this later


  void drop() {
    Bomb a = new Bomb(xcor, ycor, range);
  }
}