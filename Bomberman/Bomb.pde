class Bomb {
  Fire center;
  Fire[][] fire;
  int time = 0;
  int range;
  int xcor, ycor;
  float frame = 0.0;
  ArrayList<PImage> bomb = new ArrayList<PImage>();

  Bomb (int xcor, int ycor, int range) {
    time = millis();
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
    for (int i = 0; i < 3; i++) {
      PImage current = loadImage("bomb/bomb" + i + ".png");
      bomb.add(current);
    }
    fire = new Fire[4][range];
    explodeFire();
  }

  void explodeFire() {
    if (time >= 2000) {
      //figure out how to progress
      center = new Fire(xcor, ycor, false);
      for (int i = 1; i <= range; i++) {
        boolean end = false;
        if (i == range) {
          end = true;
        }
        fire[0][i-1] = new Fire(xcor+50*i, ycor, end); //right
        fire[1][i-1] = new Fire(xcor-50*i, ycor, end); //left
        fire[2][i-1] = new Fire(xcor, ycor+50*i, end); //down
        fire[3][i-1] = new Fire(xcor, ycor-50*i, end); //up
      }
    }
  }
  
  void display() {
    image(bomb.get((int)frame), xcor, ycor);
    frame += 0.1;
    if (frame >= 3) {
      frame = 0;
    }
  }
}