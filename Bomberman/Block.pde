class Block {
  boolean wasInside = false;
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
    PImage current = blocks.get(type);
    float bottomY = player.ycor + player.resting.height;
    float rightX = player.xcor + player.resting.width;
    if (type != 0) {
      boolean leftFootX = player.xcor >= xcor && player.xcor <= xcor + current.width;
      boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + player.resting.height * .3;
      boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
      if (leftFootX && footY || rightFootX && footY) {
        player.walk = false;
        if (bottomY >= ycor && bottomY <= ycor + 20 && (leftFootX || rightFootX)) {
          player.ycor--;
          wasInside = true;
        } if (player.xcor <= xcor + current.width && player.xcor >= xcor + current.width - 20 && footY) {
          player.xcor++;
          wasInside = true;
        } if (bottomY - player.resting.height * .3 <= ycor + current.height && bottomY - player.resting.height * .3 >= ycor + current.height - 20 && (leftFootX || rightFootX)) {
          player.ycor++;
          wasInside = true;
        } if (rightX >= xcor && rightX <= xcor + 20 && footY){
          player.xcor--;
          wasInside = true;
        }
      } else if (wasInside) {
        player.walk = true;
        wasInside = false;
      }
    }
  }
}