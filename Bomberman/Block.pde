class Block {
  int type, x, y;
  ArrayList<PImage> blocks;
  //type 0 is grass, 1 is removable wall, 2 is unremovable wall

  Block (int type) {
    this.type = type;
    //2 = wall, 1 = solid, 0 = grass
    blocks = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
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
}