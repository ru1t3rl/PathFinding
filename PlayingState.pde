class PlayingState extends GameObjectList {
  AStar algo;
  NodeMenu menu;

  public PlayingState() {
    this.Add(algo = new AStar(new PVector(45, 45), new PVector(20, 20)));
    algo.position.x += 300;
    
    this.Add(menu = new NodeMenu(new PVector(900, 0)));
  }

  public void Update() {
    super.Update();
  }

  public void draw() {
    super.draw();
  }
}
