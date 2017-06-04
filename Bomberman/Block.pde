class Block {
  int type, x, y;
  ArrayList<PImage> blocks;
  //type 0 is grass, 1 is removable wall, 2 is unremovable wall

  Block (int type) {
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("solid.png"));
    blocks.add(loadImage("wall.png"));
  }

  void display(int x, int y) {
    image(blocks.get(type), x, y);
  }

  void burst(boolean canBurst) {
    if (canBurst) {
    }
  }

  //void check(Player player) {
  //  PImage current = blocks.get(type);
  //  int footY = player.y + player.resting.height;
  //  int leftfootX = player.x + player.resting.width;
  //  if (type != 0) {
  //    if (player.x <= x + current.width || player.y >= y - player.resting.height ||
  //      player.x >= x - player.resting.width || ) {
  //    }
  //  }
  //}
}