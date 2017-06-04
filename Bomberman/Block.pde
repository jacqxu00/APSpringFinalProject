class Block {
  int type, x, y;
  ArrayList<PImage> blocks;
  //type 0 is grass, 1 is removable wall, 2 is unremovable wall

  Block (int type, int x, int y) {
    this.x = x;
    this.y = y;
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("solid.png"));
    blocks.add(loadImage("wall.png"));
  }

  void display() {
    image(blocks.get(type), x, y);
  }

  void burst(boolean canBurst) {
    if (canBurst) {
    }
  }

  //void check(Player player) {
  //  PImage current = blocks.get(type);
  //  int bottomY = player.y + player.resting.height;
  //  int rightX = player.x + player.resting.width;
  //  if (type != 0) {
  //    if ((bottomY >= y && bottomY <= y + current.height || 
  //    player.y >= y && player.y <= y + current.height) &&
  //    (rightX >= x && rightX <= x + current.width ||
  //    player.x >= x || player.x <= x + current.width)) {
  //      player.walk = false;
  //    }
  //  }
  //}
}