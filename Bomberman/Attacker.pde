class Attacker extends Creature {
  int steps;
  int dir;
  int count = 0;
  int rand = 0;

  //MAKE SURE THAT ATTACKERS DON'T SPAWN RIGHT NEXT TO PLAYER
  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker");
    speed = 2;
  }
  
  void move() {
    //control movement rate later
    // PETER make sure the feet are not bouncing up and down
    // PETER and that the attackers are spawned so the feet are lower on the green block
    if (count == 0) {
    rand = (int) random(4);
    }
    update(rand); //PETER regarding above (feet are lower) change rand to 1 and youll see what i mean
    count++;
    if (count >= 48) {
      count = 0;
    }
  }
}