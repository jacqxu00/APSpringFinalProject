class Bomb {
  Fire center;
  Fire[][] fire;
  boolean wasInside = false;
  long time;
  int range;
  int xcor, ycor;
  float frame = 0.0;
  ArrayList<PImage> bomb;
  ArrayList<PImage[][]> fires;

  Bomb (int xcor, int ycor, int range, ArrayList<PImage[][]> fires) {
    time = millis();
    //System.out.println(time);
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
    this.fires = fires;
    bomb = new ArrayList<PImage>();
    for (int i = 0; i < 3; i++) {
      PImage current = loadImage("bomb/bomb" + i + ".png");
      bomb.add(current);
    }
    fire = new Fire[4][range];
  }

  //JACKIES
  void explodeFire() {
    display();
    long newTime = millis();
    //System.out.println(newTime);
    if (newTime - time >= 2000) {
      //System.out.println("boom");
      //center = new Fire(xcor, ycor, 3);
      for (int i = 1; i <= range; i++) {
        int type = 0;
        if (i == range) {
          type = 1;
          //}
          //fire[0][i-1] = new Fire(xcor+50*i, ycor, type); //right
          //fire[1][i-1] = new Fire(xcor-50*i, ycor, type); //left
          //fire[2][i-1] = new Fire(xcor, ycor+50*i, type); //down
          //fire[3][i-1] = new Fire(xcor, ycor-50*i, type); //up
        }
      }
    }
  }

  void display() {
    image(bomb.get((int)frame), xcor, ycor);
    frame += 0.1;
    if (frame >= 3) {
      frame = 0;
    }
  }

  void check(Attacker attacker) {
    PImage current = bomb.get((int)frame);
    println(attacker.ycor);
    println(attacker .resting.height);
    float bottomY = attacker.ycor + attacker.resting.height;
    float rightX = attacker.xcor + attacker.resting.width;
    boolean leftFootX = attacker.xcor >= xcor && attacker.xcor <= xcor + current.width;
    boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + attacker.resting.height * .3;
    boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
    if (leftFootX && footY || rightFootX && footY) {
      attacker.walk = false;
      if (bottomY >= ycor && bottomY <= ycor + 20 && (leftFootX || rightFootX)) {
        attacker.ycor--;
        wasInside = true;
      } 
      if (attacker.xcor <= xcor + current.width && attacker.xcor >= xcor + current.width - 20 && footY) {
        attacker.xcor++;
        wasInside = true;
      } 
      if (bottomY - attacker.resting.height * .3 <= ycor + current.height && bottomY - attacker.resting.height * .3 >= ycor + current.height - 20 && (leftFootX || rightFootX)) {
        attacker.ycor++;
        wasInside = true;
      } 
      if (rightX >= xcor && rightX <= xcor + 20 && footY) {
        attacker.xcor--;
        wasInside = true;
      }
    } else if (wasInside) {
      attacker.walk = true;
      wasInside = false;
    }
  }
}