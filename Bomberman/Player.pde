class Player extends Creature {
  int numBombs;
  int x = width/2, y = height/2, sizeVer = 45, sizeHor = 50;
  float frame = 0.0;
  boolean walk = true;
  PImage resting;
  ArrayList<PImage> down, right, up, left, dead;

  Player() {
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
      image(resting, x, y);
    }
  }

  void update(int dir) {
    if (dir == 0) {
      if (walk) {
        y -= 2;
      }
      image(up.get((int)frame), x, y);
      resting = up.get(0);
    } else if (dir == 1) {
      if (walk) {
        x += 2;
      }
      image(right.get((int)frame), x, y);
      resting = right.get(0);
    } else if (dir == 2) {
      if (walk) {
        y += 2;
      }
      image(down.get((int)frame), x, y);
      resting = down.get(0);
    } else {
      if (walk) {
        x -= 2;
      }
      image(left.get((int)frame), x, y);
      resting = left.get(0);
    }
    //this slows the animation down
    frame += 0.175;
    if (frame >= 7) {
      frame = 0;
    }
  }

  //temporary checking walls but won't need this later
  void checkWalls() {
    if (x <= 45 || y <= 0 || x >= width - 90 || y >= height - 45 - resting.height) {
      walk = false;
      //need to change the coordinate in order for it to get out of this boolean cycle
      if (x <= 45) {
        x++;
      }
      if (y <= 0) {
        y++;
      }
      if (x >= width - 90) {
        x--;
      }
      if (y >= height - 45 - resting.height) {
        y--;
      }
    } else {
      walk = true;
    }
  }


  void drop() {
    Bomb a = new Bomb(xcor, ycor, range);
  }
}