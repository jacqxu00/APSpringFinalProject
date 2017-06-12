  abstract class Creature {
  int xcor, ycor, speed;
  float frame = 0.0, count = 0.0;
  boolean walk = true;
  PImage resting;
  ArrayList<PImage> down, right, up, left, dead;
  Block[][] grid;
  
  public Creature(int xcor, int ycor, String type, Map map) {
    this.xcor = xcor;
    this.ycor = ycor;
    speed = 3;
    down = new ArrayList<PImage>();
    right = new ArrayList<PImage>();
    up = new ArrayList<PImage>();
    left = new ArrayList<PImage>();
    dead = new ArrayList<PImage>();

    //adding all sprites to its respective arraylists
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/down" + i + ".png");
      down.add(current);
    }
    resting = down.get(0);
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/right" + i + ".png");
      right.add(current);
    }
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/up" + i + ".png");
      up.add(current);
    }
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/left" + i + ".png");
      left.add(current);
    }
    for (int i = 0; i < 5; i++) {
      PImage current = loadImage(type + "/dead" + i + ".png");
      dead.add(current);
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
  
  void die() {
    if (count < 4) {
      image(dead.get((int)count), xcor, ycor);
    }
    count += 0.175;
  }
}