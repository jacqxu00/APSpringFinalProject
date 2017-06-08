class Map {
  Block[][] grid;
  int level;
  Portal portal;
  ArrayList<Attacker> attackers;
  ArrayList<Bomb> bombs;
  ArrayList<Block> bricks;
  ArrayList<Fire> LofFire;

  Map(int level) {
    this.level = level;
    bricks = new ArrayList<Block>();
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
<<<<<<< HEAD
        //if (grid[r][c].type == 0) {
        //  //brick
        //  int percentage = 45 + level;
        //  if (percentage > 90) {
        //    percentage = 90;
        //  }
        //  int test = (int) random(100);
        //  if (test <= percentage && !(r <=2 && c <= 2)) {
        //    Block newBlock = new Block(1, r*48, c*48);
        //    grid[r][c] = newBlock;
        //    bricks.add(newBlock);
        //  }
        //}
      }
    }
    //int iPortal = (int) random(bricks.size());
    //portal = new Portal(bricks.get(iPortal).xcor, bricks.get(iPortal).ycor);
=======
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
      }
    }
    System.out.println(bricks());
    int iPortal = (int) random(bricks.size());
    portal = new Portal(bricks.get(iPortal).xcor, bricks.get(iPortal).ycor);
>>>>>>> jackie
  }

  void display() {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].display();
      }
    }
  }

  void check(Creature creature) {
    for (int r = 0; r < grid.length; r++) {
      for (int c = 0; c < grid[r].length; c++) {
        grid[r][c].check(creature);
      }
    }
  }

  boolean checkDeath(int rCreat, int cCreat, int rBomb, int cBomb) {
    //double check where r c is for attacker make ame as player so in creature
    return rCreat/48 * 48 == rBomb && cCreat/48 * 48 == cBomb;
  }

  boolean checkAttack(int rPlay, int cPlay, int rAttack, int cAttack) {
    //fix
    return Math.abs(rPlay - rAttack) <= 48 && Math.abs(cPlay - cAttack) <= 48;
  }

  String bricks() {
    String ans = "";
    for (Block a : bricks) {
      ans+= "("+a.xcor/48+","+a.ycor/48+")";
    }
    return ans;
  }

  void changes() {
    for (Attacker a : attackers) {
      if (checkAttack(main.xcor, main.ycor, a.xcor, a.ycor)) {
        noLoop();
        gameOver();
      }
    }
    for (Bomb b : bombs) {
      for (int r = 0; r < b.fire.length; r++) {
        for (int c = 0; c < b.fire[0].length; c++) {
          if (grid[r][c].type == 3 || grid[r][c].type == 2) {
            r++;
            c=0;
          } else {
            LofFire.add(b.fire[r][c]);
          }
        }
      }
      for (Fire f : LofFire) {
        if (checkDeath(main.xcor,main.ycor,f.xcor,f.ycor)) {
          noLoop();
          gameOver();
        }
        for (Attacker a : attackers) {
          if (checkDeath(a.xcor,a.ycor,f.xcor,f.ycor)) {
            //die animation
            a = null;
          }
        }
      }
    }
    //bombing a brick
  }

  void gameOver() {
  }
}