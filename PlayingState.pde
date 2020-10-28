class PlayingState extends GameObjectList {
  AlgorithmManager algo;
  NodeMenu menu;

  public PlayingState() {
    this.add(algo = new AlgorithmManager(new PVector(45, 45), new PVector(20, 20)));    
    algo.position.x += 300;
    
    this.add(menu = new NodeMenu(new PVector(900, 0)));
  }

  public void update() {
    super.update();
  }

  public void draw() {
    super.draw();
  }
}
