class Fire {
  int xcor, ycor, strength, dir;
  int type;
  int moment = 1;
  ArrayList<PImage> fire;

  Fire (int xcor, int ycor, int type) {
    //type: 0 = end, 1 = standard, 2 = block explode, 3 = center
    this.xcor = xcor;
    this.ycor = ycor;
    this.type = type;
    fire = new ArrayList<PImage>();
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