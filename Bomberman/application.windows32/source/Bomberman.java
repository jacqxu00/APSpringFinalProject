import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Bomberman extends PApplet {

int level, clearCount;
int range;
Map map;
Player main;
Attacker attacker;
Fire fire;

public void setup() {
  level = 1;
  range = 1;
  
  main = new Player(50, 50);
  map = new Map(level);
  fire = new Fire(width/2, height/2, 3, 1, main.fires);
  clearCount = 0;
}

public void draw() {
  map.display();
  map.changes(main);
  if (!map.gameOver) {
    main.move();
    map.check(main);
    for (Attacker attacker : map.attackers) {
      attacker.move(map);
      map.check(attacker);
      for (Bomb bomb : main.bombs) {
        bomb.check(attacker);
      }
    }
    checkClear();
  }
}

public void checkClear() {
  if (map.checkClear(main)) {
    if (clearCount < 110) {
      main.jump();
      clearCount++;
    } else {
      clearCount = 0;
      level++;
      main = new Player(50, 50);
      map = new Map(level);
    }
  }
}
class Attacker extends Creature {
  int dir;
  ArrayList<Integer> moves;
  int count = 0;
  Block[][] grid;
  boolean deadEnd, move;

  Attacker(int xcor, int ycor) {
    super(xcor, ycor + 5, "attacker", map);
    move = true;
    deadEnd = false;
    moves = new ArrayList<Integer>();
    speed = 1;
  }

  public boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  public void move(Map map) {
    if (move) {
      grid = map.grid;
      if (dir == 0 && grid[(xcor+24)/48][(ycor+74-48)/48].type != 0 || dir == 1 && grid[(xcor+6+48)/48][(ycor+70)/48].type != 0 ||
        dir == 2 && grid[(xcor+24)/48][(ycor+32+48)/48].type != 0 || dir == 3 && grid[(xcor+42-48)/48][(ycor+70)/48].type != 0) {
        dir = (int) random(4);
      }
      for (Bomb b : main.bombs) { //not working
        if (dir == 0 && (xcor+24)/48 == b.xcor && (ycor+70-48)/48 == b.ycor || dir == 1 && (xcor+24+48)/48 == b.xcor && (ycor+70)/48 == b.ycor ||
          dir == 2 && (xcor+24)/48 == b.xcor && (ycor+70+48)/48 == b.ycor || dir == 3 && (xcor+24-48)/48 == b.xcor && (ycor+70)/48 == b.ycor) {
          dir = (int) random(4);
        }
      }
      update(dir);
    }
  }
}
class Block {
  boolean wasInside = false;
  float frame = 0.0f;
  int type, xcor, ycor;
  ArrayList<PImage> blocks;
  ArrayList<PImage> burst;

  Block (int type, int xcor, int ycor) {
    this.xcor = xcor;
    this.ycor = ycor;
    this.type = type;
    //0 = grass, 1 = brick, 2 = wall, 3 = solid
    blocks = new ArrayList<PImage>();
    burst = new ArrayList<PImage>();
    blocks.add(loadImage("grass.png"));
    blocks.add(loadImage("brick.png"));
    blocks.add(loadImage("wall.png"));
    blocks.add(loadImage("solid.png"));
    for (int i = 0; i < 5; i++) {
      burst.add(loadImage("break" + i + ".png"));
    }
  }

  public void display() {
    image(blocks.get(type), xcor, ycor);
  }

  public void burst() {
    image(burst.get((int)frame), xcor, ycor);
    //this slows the animation down
    frame += 0.175f;
    if (frame >= 4) {
      type = 0;
    }
  }

  public void check(Creature creature) {
    PImage current = blocks.get(type);
    float bottomY = creature.ycor + creature.resting.height;
    float rightX = creature.xcor + creature.resting.width;
    if (type != 0) {
      boolean leftFootX = creature.xcor >= xcor && creature.xcor <= xcor + current.width;
      boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + creature.resting.height * .3f;
      boolean rightFootX = rightX >= xcor && rightX <= xcor + current.width;
      if (leftFootX && footY || rightFootX && footY) {
        creature.walk = false;
        if (bottomY >= ycor && bottomY <= ycor + 20 && (leftFootX || rightFootX)) {
          creature.ycor--;
          wasInside = true;
        } 
        if (creature.xcor <= xcor + current.width && creature.xcor >= xcor + current.width - 20 && footY) {
          creature.xcor++;
          wasInside = true;
        } 
        if (bottomY - creature.resting.height * .3f <= ycor + current.height && bottomY - creature.resting.height * .3f >= ycor + current.height - 20 && (leftFootX || rightFootX)) {
          creature.ycor++;
          wasInside = true;
        } 
        if (rightX >= xcor && rightX <= xcor + 20 && footY) {
          creature.xcor--;
          wasInside = true;
        }
      } else if (wasInside) {
        creature.walk = true;
        wasInside = false;
      }
    }
  }
}
class Bomb {
  Fire center;
  Fire[][] fire;
  boolean wasInside = false;
  long time;
  int range;
  int count = 0;
  int xcor, ycor;
  float frame = 0.0f;
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

  public void explode() {
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
      if (up && checkCor(xcor/48, (ycor-48*i)/48) && (grid[xcor/48][(ycor-48*i)/48].type == 3 ||  grid[xcor/48][(ycor-48*i)/48].type == 2)) {
        up = false;
      } else if (up && checkCor(xcor/48,(ycor-48*i)/48) && (grid[xcor/48][(ycor-48*i)/48].type == 1)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 3, 4, fires);
        LofFire.add(fire[2][i-1]);
        up = false;
      } else if (up && checkCor(xcor/48,(ycor-48*i)/48) && !(end)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 1, 3, fires);
        LofFire.add(fire[2][i-1]);
      } else if (up && checkCor(xcor/48,(ycor-48*i)/48)) {
        fire[2][i-1] = new Fire(xcor, ycor-48*i, 2, 3, fires);
        LofFire.add(fire[2][i-1]);
      } 
      if (down && checkCor(xcor/48, (ycor+48*i)/48) && (grid[xcor/48][(ycor+48*i)/48].type == 3 ||  grid[xcor/48][(ycor+48*i)/48].type == 2)) {
        down = false;
      } else if (down && checkCor(xcor/48, (ycor+48*i)/48) && (grid[xcor/48][(ycor+48*i)/48].type == 1)) {
        fire[3][i-1] = new Fire(xcor, ycor+48*i, 3, 4, fires);
        LofFire.add(fire[3][i-1]);
        down = false;
      } else if (down && checkCor(xcor/48, (ycor+48*i)/48) && !(end)) {
        fire[3][i-1] = new Fire(xcor, ycor+48*i, 1, 4, fires);
        LofFire.add(fire[3][i-1]);
      } else if (down && checkCor(xcor/48, (ycor+48*i)/48)) {
        fire[3][i-1] = new Fire(xcor, ycor+48*i, 2, 4, fires);
        LofFire.add(fire[3][i-1]);
      }
      if (right && checkCor((xcor+48*i)/48, ycor/48) && (grid[(xcor+48*i)/48][ycor/48].type == 3 ||  grid[(xcor+48*i)/48][ycor/48].type == 2)) {
        right = false;
      } else if (right && checkCor((xcor+48*i)/48, ycor/48) && (grid[(xcor+48*i)/48][ycor/48].type == 1)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 3, 1, fires); //right
        LofFire.add(fire[0][i-1]);
        right = false;
      } else if (right && checkCor((xcor+48*i)/48, ycor/48) && !(end)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 1, 1, fires);
        LofFire.add(fire[0][i-1]);
      } else if (right && checkCor((xcor+48*i)/48, ycor/48)) {
        fire[0][i-1] = new Fire(xcor+48*i, ycor, 2, 1, fires);
        LofFire.add(fire[0][i-1]);
      }
      if (left && checkCor((xcor-48*i)/48, ycor/48) && (grid[(xcor-48*i)/48][ycor/48].type == 3 ||  grid[(xcor-48*i)/48][ycor/48].type == 2)) {
        left = false;
      } else if (left && checkCor((xcor-48*i)/48, ycor/48) && (grid[(xcor-48*i)/48][ycor/48].type == 1)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 3, 2, fires); //left
        LofFire.add(fire[1][i-1]);
        left = false;
      } else if (left  && checkCor((xcor-48*i)/48, ycor/48) && !(end)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 1, 2, fires);
        LofFire.add(fire[1][i-1]);
      } else if (left && checkCor((xcor-48*i)/48, ycor/48)) {
        fire[1][i-1] = new Fire(xcor-48*i, ycor, 2, 2, fires);
        LofFire.add(fire[1][i-1]);
      }
    }
  }

  public boolean checkCor(int x, int y) {
    return x >= 0 && x <= 16 && y >= 0 && y <= 12;
  }

  public void display() {
    image(bomb.get((int)frame), xcor, ycor);
    frame += 0.1f;
    if (frame >= 3) {
      frame = 0;
      count++;
    }
    if (count == 3) {
      explode();
      count++;
    }
    for (Fire fire : LofFire) {
      fire.display();
    }
  }

  public void check(Attacker attacker) {
    PImage current = bomb.get((int)frame);
    float bottomY = attacker.ycor + attacker.resting.height;
    float rightX = attacker.xcor + attacker.resting.width;
    boolean leftFootX = attacker.xcor >= xcor && attacker.xcor <= xcor + current.width;
    boolean footY = bottomY >= ycor && bottomY <= ycor + current.height + attacker.resting.height * .3f;
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
      if (bottomY - attacker.resting.height * .3f <= ycor + current.height && bottomY - attacker.resting.height * .3f >= ycor + current.height - 20 && (leftFootX || rightFootX)) {
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
abstract class Creature {
  int xcor, ycor, speed;
  float frame = 0.0f, count = 0.0f;
  boolean walk = true;
  boolean alive;
  PImage resting;
  ArrayList<PImage> down, right, up, left, dead;
  Block[][] grid;

  public Creature(int xcor, int ycor, String type, Map map) {
    alive = true;
    this.xcor = xcor;
    this.ycor = ycor;
    speed = 3;
    down = new ArrayList<PImage>();
    right = new ArrayList<PImage>();
    up = new ArrayList<PImage>();
    left = new ArrayList<PImage>();
    dead = new ArrayList<PImage>();

    //adding all sprites to its respective arraylists
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/down" + i + ".png");
      down.add(current);
    }
    resting = down.get(0);
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/right" + i + ".png");
      right.add(current);
    }
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/up" + i + ".png");
      up.add(current);
    }
    for (int i = 0; i < 8; i++) {
      PImage current = loadImage(type + "/left" + i + ".png");
      left.add(current);
    }
    for (int i = 0; i < 5; i++) {
      PImage current = loadImage(type + "/dead" + i + ".png");
      dead.add(current);
    }
  }

  public void update(int dir) {
    if (alive) {
      if (dir == 0) {
        if (walk) {
          ycor -= speed;
        }
        image(up.get((int)frame), xcor, ycor);
        resting = up.get(0);
      } else if (dir == 1) {
        if (walk) {
          xcor += speed;
        }
        image(right.get((int)frame), xcor, ycor);
        resting = right.get(0);
      } else if (dir == 2) {
        if (walk) {
          ycor += speed;
        }
        image(down.get((int)frame), xcor, ycor);
        resting = down.get(0);
      } else {
        if (walk) {
          xcor -= speed;
        }
        image(left.get((int)frame), xcor, ycor);
        resting = left.get(0);
      }
      //this slows the animation down
      frame += 0.175f;
      if (frame >= 7) {
        frame = 0;
      }
    } else {
      if (count < 4) {
        image(dead.get((int)count), xcor, ycor);
      }
      count += 0.15f;
    }
  }

  public void die() {
    alive = false;
    walk = false;
  }
}
class Fire {
  int xcor, ycor, strength, dir;
  int type;
  float frame = 0.0f;
  ArrayList<PImage[][]> fires;
  ArrayList<PImage> mine;

  Fire (int xcor, int ycor, int type, int dir, ArrayList<PImage[][]> fires) {
    //type: 0 = center, 1 = standard, 2 = end, 3 = block explode
    this.xcor = xcor;
    this.ycor = ycor;
    this.type = type;
    this.fires = fires;
    
    mine = new ArrayList<PImage>();
    if (type == 3) {
      for (int i = 0; i < 5; i++) {
        mine.add(loadImage("break" + i + ".png"));
      }
    } else if (type == 0) {
      for (int i = 0; i < 4; i++) {
        mine.add(fires.get(dir)[i][type]);
      }
    } else {
      for (int i = 0; i < 4; i++) {
        mine.add(fires.get(dir)[i][type - 1]);
      }
    }
  }

  public void display() {
    image(mine.get((int)frame), xcor, ycor);
    if (frame < 3.5f) {
      frame += 0.2f; 
    }
  }
}


class Map {
  boolean gameOver = false;
  Block[][] grid;
  int level, bombCount = 0, aDeathCount = 0, pDeathCount = 0;
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

  public void display() {
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
    fill(0);
    String s = "LEVEL: " + level;
    text(s, 0, 30);
  }


  public void check(Creature creature) {
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

  public boolean checkAttack(int rPlay, int cPlay, int rAttack, int cAttack) {
    return (Math.abs(rPlay-rAttack) <= 30  && Math.abs(cPlay-cAttack) <= 30);
  }

  public String bricks() {
    String ans = "";
    for (Block a : bricks) {
      ans+= "("+a.xcor/48+","+a.ycor/48+")";
    }
    return ans;
  }

  public void changes(Player p) {
    Iterator<Attacker> h = attackers.iterator();
    while (h.hasNext()) {
      Attacker a = h.next();
      if (checkAttack(p.xcor + 24, p.ycor + 40, a.xcor+24, a.ycor + 40)) {
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
            pDeathCount++;
            if (pDeathCount > 21) {
              gameOver();
            }
          }
          Iterator<Attacker> j = attackers.iterator();
          while (j.hasNext()) {
            Attacker a = j.next();
            if (checkAttack(a.xcor+24, a.ycor + 40, f.xcor, f.ycor)) {
              a.die();
              aDeathCount++;
              if (aDeathCount > 21) {
                j.remove();
                aDeathCount = 0;
              }
            }
          }
        }
        bombCount++;
        if (bombCount > 113) {
          i.remove();
          bombCount = 0;
        }
      }
    }
  }

  public boolean checkCor(int y, int x) {
    return y >= 0 && y <= 12 && x >= 0 && x <= 16;
  }

  public boolean checkClear(Player p) {
    return attackers.size() == 0 && (p.xcor+24)/48 == portal.xcor/48 && (p.ycor+70)/48 == portal.ycor/48;
  }

  public void gameOver() {
    gameOver = true;
    noLoop();
    clear();
    PImage current = loadImage("gameover.jpg");
    image(current, 0, 0);
    textSize(24);
    fill(0xffFF0066);
    String s = "LEVEL: " + level;
    text(s, 320, 280);
  }
}
class Player extends Creature {
  int numBombs;
  float jumpFrame = 0.0f;
  ArrayList<Bomb> bombs;
  ArrayList<PImage[][]> fires;
  ArrayList<PImage> jump;

  Player(int xcor, int ycor) {
    super(xcor, ycor, "player", map);
    jump = new ArrayList<PImage>();
    for (int i = 0; i < 4; i++) {
      jump.add(loadImage("player/jump" + i + ".png"));
    }
    numBombs = 5;
    bombs = new ArrayList<Bomb>();
    fires = new ArrayList<PImage[][]>();
    loadFires();
  }

  public void move() {
    if (alive) {
      if (keyPressed && key == CODED && (keyCode == UP || keyCode == DOWN || keyCode == LEFT || keyCode == RIGHT)) {
        if (keyCode == UP) {
          update(0);
        } else if (keyCode == RIGHT) {
          update(1);
        } else if (keyCode == DOWN) {
          update(2);
        } else {
          update(3);
        }
      } else if (keyPressed && key == ' ') {
        drop();
      } else if (keyPressed && key == 'r') {
        xcor = 50;
        ycor = 50;
      } else {
        frame = 0;
        //makes the character look wherever it was headed to when it stops
        image(resting, xcor, ycor);
      }
    }
  }

  public void drop() {
    if (bombs.size() < numBombs) {
      bombs.add(new Bomb((xcor+24)/48 * 48, (ycor+70)/48 * 48, 2, fires, map));
    }
  }

  public void update(int dir) {
    if (alive) {
      if (dir == 0) {
        if (walk) {
          ycor -= speed;
        }
        image(up.get((int)frame), xcor, ycor);
        resting = up.get(0);
      } else if (dir == 1) {
        if (walk) {
          xcor += speed;
        }
        image(right.get((int)frame), xcor, ycor);
        resting = right.get(0);
      } else if (dir == 2) {
        if (walk) {
          ycor += speed;
        }
        image(down.get((int)frame), xcor, ycor);
        resting = down.get(0);
      } else {
        if (walk) {
          xcor -= speed;
        }
        image(left.get((int)frame), xcor, ycor);
        resting = left.get(0);
      }
      //this slows the animation down
      frame += 0.175f;
      if (frame >= 7) {
        frame = 0;
      }
    }
  }

  public void die() {
    alive = false;
    walk = false;
    if (count < 4) {
      image(dead.get((int)count), xcor, ycor);
    }
    count += 0.15f;
  }

  public void loadFires() {
    PImage[][] fireCenter = new PImage[4][3];
    for (int i = 0; i < 4; i++) {
      fireCenter[i][0] = loadImage("bomb/firecenter" + i + "0.png");
    }
    PImage[][] fireRight = new PImage[4][2];
    PImage[][] fireLeft = new PImage[4][2];
    PImage[][] fireUp = new PImage[4][2];
    PImage[][] fireDown = new PImage[4][2];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        for (int h = 0; h < 2; h++) {
          if (i == 0) {
            fireRight[j][h] = loadImage("bomb/fireright" + j + h + ".png");
          } else if (i == 1) {
            fireLeft[j][h] = loadImage("bomb/fireleft" + j + h + ".png");
          } else if (i == 2) {
            fireUp[j][h] = loadImage("bomb/fireup" + j + h + ".png");
          } else {
            fireDown[j][h] = loadImage("bomb/firedown" + j + h + ".png");
          }
        }
      }
    }
    fires.add(fireCenter);
    fires.add(fireRight);
    fires.add(fireLeft);
    fires.add(fireUp);
    fires.add(fireDown);
  }

  public void jump() {
    alive = false;
    walk = false;
    image(jump.get((int)jumpFrame),xcor, ycor);
    jumpFrame += 0.175f;
    if (jumpFrame >= 4) {
      jumpFrame = 0;
    }
  }
}
class Portal {
  int xcor, ycor;

  Portal(int xcor, int ycor) {
    this.xcor = xcor;
    this.ycor = ycor;
  }

}
  public void settings() {  size(720, 624); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "--present", "--window-color=#666666", "--stop-color=#cccccc", "Bomberman" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
