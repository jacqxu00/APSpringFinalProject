class Attacker extends Creature {
  int dir;
  int count = 0;
  int rand = 0;
  
  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker");
    speed = 2;
  }
  
  void move() {
    // PETER make sure the feet are not bouncing up and down
    if (count == 0) {
    rand = (int) random(4);
    }
    update(rand);
    count++;
    if (count >= 48) {
      count = 0;
    }
  }
}