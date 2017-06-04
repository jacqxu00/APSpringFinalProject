class Block {
  int type, xcor, ycor;
  ArrayList<PImage> blocks;

  Block (int type, int x, int y) {
    this.x = x;
    this.y = y;
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("wall.png"));
    blocks.add(loadImage("solid.png"));
  }

  void display() {
    image(blocks.get(type), x, y);
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
    //  boolean leftFootX = player.x >= x && player.x <= x + current.width;
    //  boolean leftFootY = bottomY >= y && bottomY <= y + current.height;
    //  boolean rightFootX = rightX >= x && rightX <= x + current.width;
    //  boolean rightFootY = bottomY >= y && bottomY <= y + current.height;
    //  if (leftFootX && leftFootY || rightFootX && rightFootY) {
    //    player.walk = false;
    //    if (leftFootX) {
    //      player.x++;
    //    } else if (leftFootY) {
          
    //    }
    //  }
    //}
  }
}