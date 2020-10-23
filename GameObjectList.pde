class GameObjectList extends GameObject {
  protected ArrayList<GameObject> children;

  public GameObjectList() {
    super();
    id = "GameObjectList";
    children = new ArrayList<GameObject>();
  }

  public ArrayList<GameObject> Children() {
    return children;
  }

  public void Add(GameObject obj) {    
    obj.Parent = this;
    children.add(obj);
  }

  public void Update() {
    super.Update();
    for (GameObject obj : children) {
      obj.Update();
    }
  }

  public void draw() {
    for (GameObject obj : children) {
      obj.draw();
    }
  }
}
