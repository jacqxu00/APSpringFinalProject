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

  void check(Creature creature) {
    PImage current = blocks.get(type);
    float bottomY = creature.ycor + creature.resting.height;
    float rightX = creature.xcor + creature.resting.width;
    if (type != 0) {
      boolean leftFootX = creature.xcor >= xcor && creature.xcor <= xcor + current.width;
      boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + creature.resting.height * .3;
      boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
      if (leftFootX && footY || rightFootX && footY) {
        creature.walk = false;
        if (bottomY >= ycor && bottomY <= ycor + 20 && (leftFootX || rightFootX)) {
          creature.ycor--;
          wasInside = true;
        } if (creature.xcor <= xcor + current.width && creature.xcor >= xcor + current.width - 20 && footY) {
          creature.xcor++;
          wasInside = true;
        } if (bottomY - creature.resting.height * .3 <= ycor + current.height && bottomY - creature.resting.height * .3 >= ycor + current.height - 20 && (leftFootX || rightFootX)) {
          creature.ycor++;
          wasInside = true;
        } if (rightX >= xcor && rightX <= xcor + 20 && footY){
          creature.xcor--;
          wasInside = true;
        }
      } else if (wasInside) {
        creature.walk = true;
        wasInside = false;
      }
    }
  }
}