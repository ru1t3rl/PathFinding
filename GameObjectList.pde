class GameObjectList extends GameObject {
  protected ArrayList<GameObject> children;

  public GameObjectList() {
    super();
    id = "GameObjectList";
    children = new ArrayList<GameObject>();
  }

  public GameObjectList(PVector position) {
    super(position);
    id="GameObjectList";
    children = new ArrayList<GameObject>();
  }

  public ArrayList<GameObject> Children() {
    return children;
  }

  public void add(GameObject obj) {
    obj.Parent = this;
    children.add(obj);
  }

  public void addRange(ArrayList<GameObject> objs) {
    for (int iGobj = 0; iGobj < objs.size(); iGobj++) {
      objs.get(iGobj).Parent = this;
      children.add(objs.get(iGobj));
    }
  }

  public void addRange(GameObject[] objs) {
    for (int iGobj = 0; iGobj < objs.length; iGobj++) {
      objs[iGobj].Parent = this;
      children.add(objs[iGobj]);
    }
  }

  public void update() {
    super.update();
    for (GameObject obj : children) {
      obj.update();
    }
  }

  public void draw() {
    super.draw();

    for (GameObject obj : children) {
      obj.draw();
    }
  }
}
