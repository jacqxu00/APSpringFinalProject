class Map {
  Block[][] grid;
  int level;
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
    for (int r = 1; r < grid[0].length - 1; r++) {
      for (int c = 1; c < grid.length - 1; c++) {
        if (grid[c][r].type == 0 && r >= 4 && c >= 4) {
          int Atest = (int) random(100);
          if (Atest <= Apercentage) {
            attackers.add(new Attacker(c*48, r*48 - 48));
          }
        }
      }
    }
    int iPortal = (int) random(bricks.size());
    portal = new Portal(bricks.get(iPortal).xcor, bricks.get(iPortal).ycor);
  }

  void display(Player p) {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].display();
      }
    }
    if (grid[portal.xcor/48][portal.ycor/48].type == 0) {
      //PETER draw portal at the spot;
    }
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

  boolean checkDeath(int rCreat, int cCreat, int rBomb, int cBomb) {
    //double check where r c is for attacker make ame as player so in creature
    return rCreat/48 * 48 == rBomb && cCreat/48 * 48 == cBomb;
  }

  boolean checkAttack(int rPlay, int cPlay, int rAttack, int cAttack) {
    return (rPlay/48 * 48 == rAttack/48 * 48 && cPlay/48 * 48 == cAttack/48 * 48);
  }

  //String bricks() {
  //  String ans = "";
  //  for (Block a : bricks) {
  //    ans+= "("+a.xcor/48+","+a.ycor/48+")";
  //  }
  //  return ans;
  //}

  void changes(Player p) {
    for (Attacker a : attackers) {
      if (checkAttack(main.xcor, main.ycor + p.resting.height, a.xcor, a.ycor + p.resting.height)) {
        p.die();
        noLoop();
        gameOver();
      }
    }
    if (p.bombs.size() > 0) {
      for (Bomb b : p.bombs) {
        grid[b.ycor/48][b.xcor/48].type = 0;
        float curTime = System.currentTimeMillis(); //PETER trying to wait but idt this is working
        b.display();
        if (System.currentTimeMillis() - curTime >= 1000) { //PETER and here prob
          display(p);
        }
        for (Fire f : b.LofFire) {
            if (checkDeath(main.xcor, main.ycor + p.resting.height, f.xcor, f.ycor)) {
              noLoop();
              gameOver();
          }
          for (Attacker a : attackers) {
            if (checkDeath(a.xcor, a.ycor + p.resting.height, f.xcor, f.ycor)) {
              a.die();
              a = null;
            }
          }
        }
      }
    }
    //bombing a brick
  }

  boolean checkClear() {
    return attackers.size() == 0;
  }

  void gameOver() {
    clear();
    //change the screen to gameover
  }
}