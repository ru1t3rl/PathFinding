class PlayingState extends GameObjectList {
  Algorithm algo;
  
  public PlayingState() {
    this.Add(algo = new Algorithm(new PVector(50, 50), new PVector(width/50, width/50)));
  }

  public void Update() {
    super.Update();
  }
}
