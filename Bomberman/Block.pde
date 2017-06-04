class Block {
  int type, xcor, ycor;
  ArrayList<PImage> blocks;

  Block (int type, int x, int y) {
    this.xcor = x;
    this.ycor = y;
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("solid.png"));
    blocks.add(loadImage("wall.png"));
  }

  void display() {
    image(blocks.get(type), xcor, ycor);
  }

  void burst() {
    if (type == 1) {
    }
  }

  void check(Player player) {
    //PImage current = blocks.get(type);
    //int bottomY = player.y + player.resting.height;
    //int rightX = player.x + player.resting.width;
    //if (type != 0) {
    //  if ((bottomY >= y && bottomY <= y + current.height || 
    //    player.y >= y && player.y <= y + current.height) &&
    //    (rightX >= x && rightX <= x + current.width ||
    //    player.x >= x || player.x <= x + current.width)) {
    //    player.walk = false;
    //  }
    //}
  }
}