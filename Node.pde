class Node extends Cell {
  ArrayList<Node> neighbours;
  boolean visited;
  PVector visitedBg;
  PVector index;

  EGroundType eGroundType;
  int cost;

  public Node(PVector position, PVector size) {
    super(position, size);

    SetupBorders();

    visited = false;
    bg = GetGroundColor(EGroundType.Stone);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, EGroundType groundType) {
    super(position, size);

    SetupBorders();
    visited = false;
    bg = GetGroundColor(EGroundType.Stone);
    visitedBg = new PVector(125, 125, 125);
  }

  public Node(PVector position, PVector size, PVector bg, PVector visitedClr) {
    super(position, size);
    this.bg = bg;
    this.visitedBg = visitedClr;

    SetupBorders();

    visited = false;

    visitedBg = new PVector(125, 125, 125);
  }

  public PVector GetGroundColor(EGroundType type) {
    switch(type) {
    case Dirt:
      cost = 3;
      return new PVector(139, 69, 19);
    case Stone:
      cost = 1;
      return new PVector(100, 100, 150);
    case Grass:
      cost = 2;
      return new PVector(0, 190, 0);
    case NonWalkable:
      cost = -1;
      return new PVector(20, 20, 20);
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
    neighbours.add(node);
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
    NonWalkable
}
