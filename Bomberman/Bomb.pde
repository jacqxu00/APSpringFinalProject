class Bomb {
  float time = 2;
  int range;
  int xcor,ycor;
  
  Bomb (int xcor, int ycor, int range) {
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
  }

  void explode() {
    //figure out how to wait timing
    //figure out how to progress
    for (int i = 0; i < range; i++) {
      //make flame
      /*move(0, 50);
      move(-50, 0);
      move(50, 0);
      move(-50, 0);*/
      //wrong but temp
    }
  }
}