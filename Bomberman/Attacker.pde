class Attacker extends Creature {
  
  //MAKE SURE THAT ATTAACKERS DON'T SPAWN RIGHT NEXT TO PLAYER
  
  void move() {
    //temporarily random
    int dir = (int) random(4);
    if (dir == 0) {
      move(0, 50);
    } else if (dir == 1) {
      move(0, -50);
    } else if (dir == 2) {
      move(50, 0);
    } else {
      move(-50, 0);
    }
  }
}