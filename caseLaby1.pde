class caseLaby1 {
  //                 0:T   1:R   2:B   3:L
  boolean[] murs = {true, true, true, true};
  int vue = 0;
  int i, j ;
  public caseLaby1(int _i, int _j) {
    i = _i;
    j = _j;
  }
  public void visite() {
    vue = 1;
  }
  public void ouvre(int i) {
    murs[i]=false;
  }
}