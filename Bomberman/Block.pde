class Block {
  int type, xcor, ycor;
  ArrayList<PImage> blocks;

  Block (int type) {
    this.type = type;
    //3 = solid, 2 = wall, 1 = brick, 0 = grass
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("solid.png"));
    blocks.add(loadImage("wall.png"));
  }
  
  void display(int x, int y) {
    image(blocks.get(type), x, y);
  }

  void burst() {
    if (type == 1) {
    }
  }
}