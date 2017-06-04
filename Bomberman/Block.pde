class Block {
  int type, xcor, ycor;
  ArrayList<PImage> blocks;

  Block (int type, int xcor, int ycor) {
    this.xcor = xcor;
    this.ycor = ycor;
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("wall.png"));
    blocks.add(loadImage("solid.png"));
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
    //int bottomY = player.ycor + player.resting.height;
    //int rightX = player.xcor + player.resting.width;
    //if (type != 0) {
    //  boolean leftFootX = player.xcor >= xcor && player.xcor <= xcor + current.width;
    //  boolean leftFootY = bottomY >= ycor && bottomY <= ycor + current.height;
    //  boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
    //  boolean rightFootY = bottomY >= ycor && bottomY <= ycor + current.height;
    //  if (leftFootX && leftFootY || rightFootX && rightFootY) {
    //    player.walk = false;
    //    if (leftFootX) {
    //      player.xcor++;
    //    } else if (leftFootY) {
          
    //    }
    //  }
    //}
  }
}