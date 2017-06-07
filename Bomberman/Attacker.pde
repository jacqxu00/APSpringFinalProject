class Attacker extends Creature {
  int steps;
  int dir;
  
  //MAKE SURE THAT ATTACKERS DON'T SPAWN RIGHT NEXT TO PLAYER
  
  void move() {
    //temporarily random
    if (steps == 0) {
      dir = (int) random(4);
      steps = (int) random(5);
    }
    if (dir == 0) {
      move(0, 48);
    } else if (dir == 1) {
      move(0, -48);
    } else if (dir == 2) {
      move(48, 0);
    } else {
      move(-48, 0);
    }
    steps--;
  }
}