class Bomb {
  ArrayList<Fire> fire = new ArrayList<Fire>();
  float time = 2;
  int range;
  int xcor, ycor;

  Bomb (int xcor, int ycor, int range) {
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
  }

  void explode() {
    //figure out how to wait timing
    //figure out how to progress
    fire.add(new Fire(xcor, ycor, false));
    for (int i = 1; i <= range; i++) {
      boolean moment = false;
      if (i == range) {
        moment = true;
      }
      fire.add(new Fire(xcor+50*i, ycor+50*i, moment));
      fire.add(new Fire(xcor+50*i, ycor-50*i, moment));
      fire.add(new Fire(xcor-50*i, ycor+50*i, moment));
      fire.add(new Fire(xcor-50*i, ycor-50*i, moment));
    }
    for (Fire a : fire) {
      a.burst();
    }
  }
}