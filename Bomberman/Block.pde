class Block {
  int type;
  //type 0 is grass, 1 is removable wall, 2 is unremovable wall

  Block (int type) {
    this.type = type;
  }

  void burst(boolean canBurst) {
    if (canBurst) {
    }
  }
}