import java.util.*;

class Map {
  boolean gameOver = false;
  Block[][] grid;
  int level, count = 0;
  Portal portal;
  ArrayList<Attacker> attackers;
  ArrayList<Block> bricks;
  ArrayList<Block> grasses;

  Map(int level) {
    this.level = level;
    bricks = new ArrayList<Block>();
    grasses = new ArrayList<Block>();
    attackers = new ArrayList<Attacker>();
    grid = new Block[15][13];
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[0].length; c++) {
        if (r == 0 || c == 0 || r == 14 || c == 12) {
          //wall
          grid[r][c] = new Block(2, r*48, c*48);
        } else if (r%2==0 && c%2==0) {
          //solid
          grid[r][c] = new Block(3, r*48, c*48);
        } else {
          //grass
          grid[r][c] = new Block(0, r*48, c*48);
        }
        if (grid[r][c].type == 0) {
          //brick
          int percentage = 15 + level;
          if (percentage > 40) {
            percentage = 40;
          }
          int test = (int) random(100);
          if (test <= percentage && !(r <=2 && c <= 2)) {
            Block newBlock = new Block(1, r*48, c*48);
            grid[r][c] = newBlock;
            bricks.add(newBlock);
          }
        }
        if (grid[r][c].type == 0) {
          grasses.add(grid[r][c]);
        }
      }
    }
    int Apercentage = 5 + level/2;
    if (Apercentage > 25) {
      Apercentage = 25;
    }
    int attackNum = 0;
    while (attackNum < 2) {
      for (int r = 1; r < grid[0].length - 1; r++) {
        for (int c = 1; c < grid.length - 1; c++) {
          if (grid[c][r].type == 0 && r >= 4 && c >= 4) {
            int Atest = (int) random(100);
            if (Atest <= Apercentage && attackNum < 5) {
              attackers.add(new Attacker(c*48, r*48 - 48));
              attackNum++;
            }
          }
        }
      }
      int iPortal = (int) random(bricks.size());
      portal = new Portal(bricks.get(iPortal).xcor, bricks.get(iPortal).ycor);
    }
  }

  void display(Player p) {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].display();
      }
    }
    if (grid[portal.xcor/48][portal.ycor/48].type == 0) {
      PImage img = loadImage("portal.png");
      image(img, portal.xcor, portal.ycor);
    }
    textSize(30);
    fill(#FFFFFF);
    String s = "LEVEL: " + level;
    text(s, 0, 0);
  }


  void check(Creature creature) {
    int row = (creature.ycor + creature.resting.height)/48;
    int col = (creature.xcor + creature.resting.width/2)/48;
    for (int i = -1; i < 2; i++) {
      for (int j = -1; j < 2; j++) {
        int r = row + i;
        int c = col + j;
        if (r > -1 && c > -1 && r < grid[0].length && c < grid.length) {
          grid[c][r].check(creature);
        } else {
          grid[col][row].check(creature);
        }
      }
    }
  }

  boolean checkAttack(int rPlay, int cPlay, int rAttack, int cAttack) {
    return (Math.abs(rPlay-rAttack) <= 30  && Math.abs(cPlay-cAttack) <= 30);
  }

  String bricks() {
    String ans = "";
    for (Block a : bricks) {
      ans+= "("+a.xcor/48+","+a.ycor/48+")";
    }
    return ans;
  }

  void changes(Player p) {
    Iterator<Attacker> h = attackers.iterator();
    while (h.hasNext()) {
      Attacker a = h.next();
      if (checkAttack(p.xcor+24, p.ycor + 40, a.xcor+24, a.ycor + 40)) {
        p.die();
        gameOver();
      }
    }
    if (p.bombs.size() > 0) {
      Iterator<Bomb> i = p.bombs.iterator();
      while (i.hasNext()) {
        Bomb b = i.next();
        b.display();
        for (Fire f : b.LofFire) {
          grid[f.xcor/48][f.ycor/48].type = 0;
          //System.out.print("("+f.xcor/48+", "+f.ycor/48+")");
          if (checkAttack(p.xcor+24, p.ycor+ 40, f.xcor+24, f.ycor+24)) {
            p.die();
            gameOver();
          }
          Iterator<Attacker> j = attackers.iterator();
          while (j.hasNext()) {
            Attacker a = j.next();
            if (checkAttack(a.xcor+24, a.ycor + 40, f.xcor, f.ycor)) {
              a.die();
              j.remove();
            }
          }
        }
        count++;
        if (count > 113) {
          i.remove();
          count = 0;
        }
      }
    }
  }

  boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  boolean checkClear(Player p) {
    return attackers.size() == 0 && (p.xcor+24)/48 == portal.xcor/48 && (p.ycor+70)/48 == portal.ycor/48;
  }

  void gameOver() {
    gameOver = true;
    noLoop();
    clear();
    PImage current = loadImage("gameover.jpg");
    image(current, 0, 0);
    textSize(24);
    fill(#FF0066);
    String s = "LEVEL: " + level;
    text(s, 320, 280);
  }
}