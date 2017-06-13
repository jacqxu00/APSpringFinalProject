class Bomb {
  Fire center;
  Fire[][] fire;
  boolean wasInside = false;
  long time;
  int range;
  int count = 0;
  int xcor, ycor;
  float frame = 0.0;
  ArrayList<PImage> bomb;
  ArrayList<Fire> LofFire;
  ArrayList<PImage[][]> fires;
  Block[][] grid;

  Bomb(int xcor, int ycor, int range, ArrayList<PImage[][]> fires, Map map) {
    grid = map.grid;
    time = millis();
    //System.out.println(time);
    this.range = range;
    this.xcor = xcor;
    this.ycor = ycor;
    this.fires = fires;
    LofFire = new ArrayList<Fire>();
    bomb = new ArrayList<PImage>();
    for (int i = 0; i < 3; i++) {
      PImage current = loadImage("bomb/bomb" + i + ".png");
      bomb.add(current);
    }
    fire = new Fire[4][range];
  }

  void explode() {
    center = new Fire(xcor, ycor, 0, 0, fires);
    LofFire.add(center);
    boolean up = true;
    boolean right = true;
    boolean down = true;
    boolean left = true;
    boolean end = false;
    for (int i = 1; i <= range; i++) {
      if (i == range) {
        end = true;
      }
      if (up && checkCor((ycor-48*i)/48, xcor/48) && (grid[(ycor-48*i)/48][xcor/48].type == 3 ||  grid[(ycor-48*i)/48][xcor/48].type == 2)) {
        up = false;
      } else if (up && checkCor((ycor-48*i)/48, xcor/48) && (grid[(ycor-48*i)/48][xcor/48].type == 1)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 1, 4, fires);
        LofFire.add(fire[2][i-1]);
        up = false;
      } else if (up && checkCor((ycor-48*i)/48, xcor/48) && !(end)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 1, 3, fires);
        LofFire.add(fire[2][i-1]);
      } else if (up && checkCor((ycor-48*i)/48, xcor/48)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 2, 3, fires);
        LofFire.add(fire[2][i-1]);
      } 
      if (down && checkCor((ycor+48*i)/48, xcor/48) && (grid[(ycor+48*i)/48][xcor/48].type == 3 ||  grid[(ycor+48*i)/48][xcor/48].type == 2)) {
        down = false;
      } else if (down && checkCor((ycor+48*i)/48, xcor/48) && (grid[(ycor+48*i)/48][xcor/48].type == 3)) {
        fire[3][i-1] = new Fire(xcor, ycor-48*i, 1, 4, fires);
        LofFire.add(fire[3][i-1]);
        down = false;
      } else if (down && checkCor((ycor+48*i)/48, xcor/48) && !(end)) {
        fire[3][i-1] = new Fire(xcor, ycor+48*i, 1, 4, fires);
        LofFire.add(fire[3][i-1]);
      } else if (down && checkCor((ycor+48*i)/48, xcor/48)) {
        fire[3][i-1] = new Fire(xcor, ycor+48*i, 2, 4, fires);
        LofFire.add(fire[3][i-1]);
      }
      if (right && checkCor(ycor/48, (xcor+48*i)/48) && (grid[ycor/48][(xcor+48*i)/48].type == 3 ||  grid[(ycor)/48][(xcor+48*i)/48].type == 2)) {
        right = false;
        System.out.println(right);
      } else if (right && checkCor(ycor/48, (xcor+48*i)/48) && (grid[ycor/48][(xcor+48*i)/48].type == 1)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 1, 1, fires); //right
        LofFire.add(fire[0][i-1]);
        right = false;
      } else if (right && checkCor(ycor/48, (xcor+48*i)/48) && !(end)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 1, 1, fires);
        LofFire.add(fire[0][i-1]);
      } else if (right && checkCor(ycor/48, (xcor+48*i)/48)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 2, 1, fires);
        LofFire.add(fire[0][i-1]);
      }
      if (left && checkCor(ycor/48, (xcor-48*i)/48) && (grid[ycor/48][(xcor-48*i)/48].type == 3 ||  grid[ycor/48][(xcor-48*i)/48].type == 2)) {
        left = false;
      } else if (left && checkCor(ycor/48, (xcor-48*i)/48) && (grid[ycor/48][(xcor-48*i)/48].type == 1)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 1, 2, fires); //left
        LofFire.add(fire[1][i-1]);
        left = false;
      } else if (left  && checkCor(ycor/48, (xcor-48*i)/48) && !(end)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 1, 2, fires);
        LofFire.add(fire[1][i-1]);
      } else if (left && checkCor(ycor/48, (xcor-48*i)/48)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 2, 2, fires);
        LofFire.add(fire[1][i-1]);
      }
    }
  }

  boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  void display() {
    image(bomb.get((int)frame), xcor, ycor);
    frame += 0.1;
    if (frame >= 3) {
      frame = 0;
      count++;
    }
    if (count > 3 && count < 4.5) {
      explode();
    }
    for (Fire fire : LofFire) {
      fire.display();
    }
  }

  void check(Attacker attacker) {
    PImage current = bomb.get((int)frame);
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