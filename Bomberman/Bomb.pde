class Bomb {
  Fire center;
  Fire[][] fire;
  long time;
  int range;
  int xcor, ycor;
  float frame = 0.0;
  ArrayList<PImage> bomb = new ArrayList<PImage>();

  Bomb (int xcor, int ycor, int range, ArrayList<PImage[][]> fires) {
    time = millis();
    //System.out.println(time);
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
    for (int i = 0; i < 3; i++) {
      PImage current = loadImage("bomb/bomb" + i + ".png");
      bomb.add(current);
    }
    fire = new Fire[4][range];
  }

  void explodeFire() {
    display();
    long newTime = millis();
    //System.out.println(newTime);
    if (newTime - time >= 2000) {
      //System.out.println("boom");
      center = new Fire(xcor, ycor, 3);
      for (int i = 1; i <= range; i++) {
        int type = 0;
        if (i == range) {
          type = 1;
        }
        fire[0][i-1] = new Fire(xcor+50*i, ycor, type); //right
        fire[1][i-1] = new Fire(xcor-50*i, ycor, type); //left
        fire[2][i-1] = new Fire(xcor, ycor+50*i, type); //down
        fire[3][i-1] = new Fire(xcor, ycor-50*i, type); //up
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