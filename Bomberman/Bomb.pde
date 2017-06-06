class Bomb {
  Fire center;
  Fire[][] fire;
  int time = 0;
  int range;
  int xcor, ycor;

  Bomb (int xcor, int ycor, int range) {
    time = millis();
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
    fire = new Fire[4][range];
    explodeFire();
  }

  void explodeFire() {
    if (time >= 2) {
      //figure out how to progress
      center = new Fire(xcor, ycor, false);
      for (int i = 1; i <= range; i++) {
        boolean moment = false;
        if (i == range) {
          moment = true;
        }
        fire[0][i-1] = new Fire(xcor+50*i, ycor+50*i, moment);
        fire[1][i-1] = new Fire(xcor+50*i, ycor-50*i, moment);
        fire[2][i-1] = new Fire(xcor-50*i, ycor+50*i, moment);
        fire[3][i-1] = new Fire(xcor-50*i, ycor-50*i, moment);
      }
    }
  }
}