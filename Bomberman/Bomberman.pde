char[][] grid;
int level;
int range;

void setup() {
  size(850, 650);
  background(255);
  grid = new char[17][17];
}

void draw() {
  drawMap();
}

void drawMap() {
  int x = 0 ;
  for (int i = 1; i <= grid.length; i++) {
    x = i * width / 17;
    line(x,0,x,height);
  }
  for (int i = 1; i <= grid.length; i++) {
    x = i * width / 17;
    line(0,x,width,x);
  }
}