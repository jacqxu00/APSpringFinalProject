class Attacker extends Creature {
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
  }
}