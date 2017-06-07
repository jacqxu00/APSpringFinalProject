class Attacker extends Creature {
<<<<<<< HEAD
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
=======
int count = 0;
int rand = 0;
  
  //MAKE SURE THAT ATTAACKERS DON'T SPAWN RIGHT NEXT TO PLAYER
  Attacker(int xcor, int ycor) {
    super(xcor, ycor, "attacker");
  }
  
  void move() {
    //slower random rate? 
    rand = (int) random(4);
    update(rand);
>>>>>>> b428a9e01aa3bffbb33156a9ad0c7f6ea725380a
  }
}