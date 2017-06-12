class Fire {
  int xcor, ycor, strength, dir;
  boolean end;
  int moment = 1;

  Fire (int xcor, int ycor, boolean end) {
    //dir = 0 = center, 1 = right, 2 = left, 3 = up, 4 = down
    this.xcor = xcor;
    this.ycor = ycor;
    this.end = end;
  }

  void burst() {
    if (moment == 1) {
      //display
    } else if (moment == 2) {
      //display
    } else if (moment == 3) {
      //display
    }
  }
}