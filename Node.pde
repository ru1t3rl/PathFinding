class Node extends Cell {
  ArrayList<Node> neighbors = new ArrayList<Node>();
  boolean visited;
  PVector visitedBg;
  PVector index;

  float f = 0,
    g = 0,
    h = 0;

  EGroundType eGroundType;
  float cost;

  Node previous = null;

  public Node(PVector position, PVector size) {
    super(position, size);

    setupBorders();

    visited = false;
    eGroundType = EGroundType.Stone;
    bg = getGroundColor(eGroundType);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, EGroundType groundType) {
    super(position, size);

    setupBorders();
    visited = false;
    eGroundType = groundType;
    bg = getGroundColor(eGroundType);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, PVector bg, PVector visitedClr) {
    super(position, size);
    this.bg = bg;
    this.visitedBg = visitedClr;

    setupBorders();

    visited = false;

    eGroundType = EGroundType.Stone;
    visitedBg = visitedClr;
  }

  void update() {
    super.update();
    if (!manager.playingState.algo.base.started) {
      if (inputHelper.IsMouseDown() || inputHelper.IsMousePressed()) {
        if (mouseX > getGlobalPosition().x && mouseX < getGlobalPosition().x + size.x && mouseY > getGlobalPosition().y && mouseY < getGlobalPosition().y + size.y) {
          if (manager.playingState.algo.base.selectedNode != this && manager.playingState.menu.selectedType == null)
            manager.playingState.algo.base.setSelected(this);
          else if (manager.playingState.menu.selectedType != null) {
            eGroundType = manager.playingState.menu.selectedType;

            if (eGroundType == EGroundType.Finish)
            {
              if (manager.playingState.algo.base.endNode != null && manager.playingState.algo.base.endNode != this)
                manager.playingState.algo.base.endNode.eGroundType = EGroundType.Stone;
              manager.playingState.algo.base.endNode = this;
            }
            if (eGroundType == EGroundType.Start) {
              if (manager.playingState.algo.base.startNode != null && manager.playingState.algo.base.startNode != this)
                manager.playingState.algo.base.startNode.eGroundType = EGroundType.Stone;
              manager.playingState.algo.base.startNode = this;
            }
          } else
            manager.playingState.algo.base.setSelected(null);
        }
      }
    }
    bg = getGroundColor(eGroundType);
  }

  public void setType(EGroundType type) {
    eGroundType = type;
  }

  public PVector getGroundColor(EGroundType type) {
    switch(type) {
    case Dirt:
      cost = dirtCost;
      return dirtColor;
    case Stone:
      cost = stoneCost;
      return stoneColor;
    case Grass:
      cost = grassCost;
      return grassColor;
    case Water:
      cost = waterCost;
      return waterColor;
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

  public void setIndex(PVector index) {
    this.index = index;
  }

  public void setIndex(int iRow, int iCol) {
    this.index = new PVector(iCol, iRow);
  }

  public void visit() {
    visited = true;
  }

  public boolean isVisited() {
    return visited;
  }

  public void addNeighbour(Node node) {
    neighbors.add(node);
  }

  protected void setupBorders() {
    // Top Border
    this.add(new Border(Position.Top, new PVector(0, 0), new PVector(size.x, 0), this));

    // Left Border
    this.add(new Border(Position.Left, new PVector(0, 0), new PVector(0, size.x), this));

    // Right Border
    this.add(new Border(Position.Right, new PVector(size.x, 0), new PVector(size.x, size.y), this));

    // Bottom Border
    this.add(new Border(Position.Bottom, new PVector(0, size.y), new PVector(size.x, size.y), this));
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
    Water,
    NonWalkable,
    Start,
    Finish
}
