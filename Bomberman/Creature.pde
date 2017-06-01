abstract class Creature {
  int xcor, ycor;

  void move(int x, int y) {
    //check that there is no wall there
    //figure out how to link cors to position and constructor?
    xcor += x;
    ycor += y;
  }

  //int move();
}