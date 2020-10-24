class Node extends Cell {
  ArrayList<Node> neighbors = new ArrayList<Node>();
  boolean visited;
  PVector visitedBg;
  PVector index;

  float f = 0,
    g = 0,
    h = 0;

  EGroundType eGroundType;
  int cost;

  Node previous = null;

  public Node(PVector position, PVector size) {
    super(position, size);

    SetupBorders();

    visited = false;
    eGroundType = EGroundType.Stone;
    bg = GetGroundColor(eGroundType);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, EGroundType groundType) {
    super(position, size);

    SetupBorders();
    visited = false;
    eGroundType = groundType;
    bg = GetGroundColor(eGroundType);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, PVector bg, PVector visitedClr) {
    super(position, size);
    this.bg = bg;
    this.visitedBg = visitedClr;

    SetupBorders();

    visited = false;

    eGroundType = EGroundType.Stone;
    visitedBg = visitedClr;
  }

  void Update() {
    if (!manager.playingState.algo.started) {
      if (inputHelper.IsMouseDown()) {
        if (mouseX > getGlobalPosition().x && mouseX < getGlobalPosition().x + size.x && mouseY > getGlobalPosition().y && mouseY < getGlobalPosition().y + size.y) {
          if (manager.playingState.algo.selectedNode != this && manager.playingState.menu.selectedType == null)
            manager.playingState.algo.setSelected(this);
          else if (manager.playingState.menu.selectedType != null) {
            eGroundType = manager.playingState.menu.selectedType;

            if (eGroundType == EGroundType.Finish)
            {
              if (manager.playingState.algo.endNode != null)
                manager.playingState.algo.endNode.eGroundType = EGroundType.Stone;
              manager.playingState.algo.endNode = this;
            }
            if (eGroundType == EGroundType.Start) {
              if (manager.playingState.algo.startNode != null)
                manager.playingState.algo.startNode.eGroundType = EGroundType.Stone;
              manager.playingState.algo.startNode = this;
            }
          } else
            manager.playingState.algo.setSelected(null);
        }
      }
    }
    bg = GetGroundColor(eGroundType);
  }

  public void setType(EGroundType type) {
    eGroundType = type;
  }

  public PVector GetGroundColor(EGroundType type) {
    switch(type) {
    case Dirt:
      cost = 3;
      return dirtColor;
    case Stone:
      cost = 1;
      return stoneColor;
    case Grass:
      cost = 2;
      return grassColor;
    case NonWalkable:
      cost = -1;
      return nonWalkableColor;
    case Finish:
      cost = 0;
      return finishColor;
    case Start:
      cost = 0;
      return startColor;
    default:
      println("This is not a valid/predefined groundtype");
      break;
    }

    return new PVector(0, 0, 0);
  }

  public void SetIndex(PVector index) {
    this.index = index;
  }

  public void SetIndex(int iRow, int iCol) {
    this.index = new PVector(iCol, iRow);
  }

  public void Visit() {
    visited = true;
  }

  public boolean IsVisited() {
    return visited;
  }

  public void AddNeighbour(Node node) {
    neighbors.add(node);
  }

  protected void SetupBorders() {
    // Top Border
    this.Add(new Border(Position.Top, new PVector(0, 0), new PVector(size.x, 0), this));

    // Left Border
    this.Add(new Border(Position.Left, new PVector(0, 0), new PVector(0, size.x), this));

    // Right Border
    this.Add(new Border(Position.Right, new PVector(size.x, 0), new PVector(size.x, size.y), this));

    // Bottom Border
    this.Add(new Border(Position.Bottom, new PVector(0, size.y), new PVector(size.x, size.y), this));
  }

  public void draw() {
    super.draw();

    if (visited)
      fill(visitedBg.x, visitedBg.y, visitedBg.z);
    else
      fill(bg.x, bg.y, bg.z);

    rect(getGlobalPosition().x, getGlobalPosition().y, size.x, size.y);
  }
}

public enum EGroundType {
  Dirt,
    Stone,
    Grass,
    NonWalkable,
    Start,
    Finish
}
