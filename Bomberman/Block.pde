class Block {
  int type, xcor, ycor;
  ArrayList<PImage> blocks;

  Block (int type, int x, int y) {
    this.x = x;
    this.y = y;
    this.type = type;
<<<<<<< HEAD
    //3 = solid, 2 = wall, 1 = brick, 0 = grass
=======
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
>>>>>>> cc248e101ac895e9a4f40820386638a02cd4af6c
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("solid.png"));
    blocks.add(loadImage("wall.png"));
  }

  void display() {
    image(blocks.get(type), x, y);
  }

  void burst() {
    if (type == 1) {
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