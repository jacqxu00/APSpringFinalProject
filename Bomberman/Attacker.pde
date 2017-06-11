class Attacker extends Creature {
  int steps;
  int dir;
  int count = 0;
  int rand = 0;

  //MAKE SURE THAT ATTACKERS DON'T SPAWN RIGHT NEXT TO PLAYER
  Attacker(int xcor, int ycor) {
    super(xcor, ycor, "attacker");
    speed = 2;
  }

  //void move() {
  //  //temporarily random
  //  if (steps == 0) {
  //    dir = (int) random(4);
  //    steps = (int) random(5);
  //  }
  //  if (dir == 0) {
  //    move(0, 48);
  //  } else if (dir == 1) {
  //    move(0, -48);
  //  } else if (dir == 2) {
  //    move(48, 0);
  //  } else {
  //    move(-48, 0);
  //  }
  //  steps--;
  
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