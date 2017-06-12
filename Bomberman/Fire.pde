class Fire {
  int xcor, ycor, strength, dir;
  int type;
  float frame = 0.0;
  ArrayList<PImage[][]> fires;
  ArrayList<PImage> mine;

  Fire (int xcor, int ycor, int type, int dir, ArrayList<PImage[][]> fires) {
    //type: 0 = center, 1 = standard, 2 = end, 3 = block explode
    this.xcor = xcor;
    this.ycor = ycor;
    this.type = type;
    this.fires = fires;
    mine = new ArrayList<PImage>();
    if (type == 3) {
      for (int i = 0; i < 5; i++) {
        mine.add(loadImage("bomb/break" + i + ".png"));
      }
    } else if (type == 0) {
      for (int i = 0; i < 4; i++) {
        mine.add(fires.get(dir)[i][type]);
      }
    } else {
      for (int i = 0; i < 4; i++) {
        mine.add(fires.get(dir)[i][type - 1]);
      }
    }
  }

  void display() {
    image(mine.get((int)frame), xcor, ycor);
    if (frame < 3.5) {
      frame += 0.5;
    }
  }
}