class PlayingState extends GameObjectList {
  Grid grid;
  
  public PlayingState() {
    this.Add(grid = new Grid(new PVector(10,10)));
  }

  public void Update() {
    super.Update();
  }
}
