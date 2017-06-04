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
    int bottomY = player.ycor + player.resting.height;
    int rightX = player.xcor + player.resting.width;
    if (type != 0) {
      boolean leftFootX = player.xcor >= xcor && player.xcor <= xcor + current.width;
      boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + player.resting.height * .3;
      boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
      if (leftFootX && footY || rightFootX && footY) {
        player.walk = false;
        if (leftFootX) {
          player.xcor++;
          wasInside = true;
        } if (rightFootX) {
          player.xcor--;
          wasInside = true;
        } if (bottomY <= ycor + current.height && bottomY >= ycor + current.height/2) {
          player.ycor++;
          wasInside = true;
        } if (bottomY >= ycor && bottomY <= ycor + current.height/2){
          player.ycor--;
          wasInside = true;
        }
      } else if (wasInside) {
        player.walk = true;
        wasInside = false;
      }
    }
  }
}