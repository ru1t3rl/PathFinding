class Algorithm extends Grid {
  GameObjectList[] rows;
  ArrayList<ArrayList<Node>> nodes;
  ArrayList<Node> path;

  boolean started = false, finished;

  Node startNode, currentNode, endNode, selectedNode;

  public Algorithm(PVector gridSize) {
    this.gridSize = gridSize;
    this.cellSize = (width/gridSize.x > height/gridSize.y) ? new PVector(height/gridSize.y, height/gridSize.y) : new PVector(width/gridSize.x, width/gridSize.x);
    id = "baseGrid";

    finished = false;

    SetupNodes();
  }

  public Algorithm(PVector gridSize, PVector cellSize) {
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "baseGrid";

    finished = false;

    SetupNodes();
  }

  public Algorithm(PVector gridSize, PVector cellSize, PVector startNodeIndex) {
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "baseGrid";

    finished = false;

    SetupNodes();
    currentNode = nodes.get((int)startNodeIndex.y).get((int)startNodeIndex.x);
  }

  void SetupNodes() {
    nodes = new ArrayList<ArrayList<Node>>();
    rows = new GameObjectList[(int)gridSize.y];

    for (int iRow = 0; iRow < this.gridSize.y; iRow++) {
      nodes.add(new ArrayList<Node>());
      this.Add(rows[iRow] = new GameObjectList());

      for (int iCol = 0; iCol < this.gridSize.x; iCol++) {
        nodes.get(iRow).add(new Node(new PVector(iCol * cellSize.x, iRow * cellSize.y), cellSize));
        nodes.get(iRow).get(iCol).SetIndex(iRow, iCol);

        rows[iRow].Add(nodes.get(iRow).get(iCol));
      }
    }

    for (int iRow = 0; iRow < this.gridSize.y; iRow++) {
      for (int iCol = 0; iCol < this.gridSize.x; iCol++) {
        if (iRow > 0) {
          // Upper Middle
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol));

          // Upper Left
          if (iCol > 0)
            nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol - 1));

          // Upper Right
          if (iCol < this.gridSize.x - 1)
            nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol + 1));
        }

        if (iRow < this.gridSize.y - 1) {
          // Bottom Middle
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol));

          // Bottom left
          if (iCol > 0)
            nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol - 1));

          // Bottom Right
          if (iCol < this.gridSize.x - 1)
            nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol + 1));
        }

        // Left Middle
        if (iCol > 0)
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow).get(iCol - 1));

        // Right Middle
        if (iCol < this.gridSize.x - 1)
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow).get(iCol + 1));
      }
    }
  }

  void setSelected(Node node) {
    if (selectedNode != null)
      selectedNode.selected = false;

    selectedNode = node;
    if (node != null)
      selectedNode.selected = true;
  }

  void Start(PVector index) {
    currentNode = nodes.get((int)index.x).get((int)index.y);
    path.add(currentNode);
    started = true;
  }

  void Start() {
    currentNode = startNode;
    path = new ArrayList<Node>();
    path.add(currentNode);
    started = true;
  }

  PImage exportMap() {
    PImage temp = createImage(nodes.size(), nodes.get(0).size(), ARGB);

    int iRow = 0, iCol = 0, dimension = nodes.size() * nodes.get(0).size();
    for (int iPixel = 0; iPixel < dimension; iPixel++) {
      if (iCol >= nodes.get(0).size()) {
        iCol = 0;
        iRow++;
      }

      temp.pixels[iPixel] = color((int)nodes.get(iRow).get(iCol).bg.x, (int)nodes.get(iRow).get(iCol).bg.y, (int)nodes.get(iRow).get(iCol).bg.z);

      iCol++;
    }

    return temp;
  }

  public void loadMap(PImage map) {
    int iRow = 0, iCol = 0, dimension = nodes.size() * nodes.get(0).size();

    color stone = color((int)stoneColor.x, (int)stoneColor.y, (int)stoneColor.z),
      water = color((int)waterColor.x, (int)waterColor.y, (int)waterColor.z),
      dirt = color((int)dirtColor.x, (int)dirtColor.y, (int)dirtColor.z),
      grass = color((int)grassColor.x, (int)grassColor.y, (int)grassColor.z),
      finish = color((int)finishColor.x, (int)finishColor.y, (int)finishColor.z),
      start = color((int)startColor.x, (int)startColor.y, (int)startColor.z),
      nonWalkable = color((int)nonWalkableColor.x, (int)nonWalkableColor.y, (int)nonWalkableColor.z);

    for (int iPixel = 0; iPixel < dimension; iPixel++) {
      if (iCol >= nodes.get(0).size()) {
        iCol = 0;
        iRow++;
      }

      if (map.pixels[iPixel] == stone)
        nodes.get(iRow).get(iCol).setType(EGroundType.Stone);
      else if (map.pixels[iPixel] == water)
        nodes.get(iRow).get(iCol).setType(EGroundType.Water);
      else if (map.pixels[iPixel] == dirt)
        nodes.get(iRow).get(iCol).setType(EGroundType.Dirt);
      else if (map.pixels[iPixel] == grass)
        nodes.get(iRow).get(iCol).setType(EGroundType.Grass);
      else if (map.pixels[iPixel] == nonWalkable)
        nodes.get(iRow).get(iCol).setType(EGroundType.NonWalkable);
      else if (map.pixels[iPixel] == finish) {
        nodes.get(iRow).get(iCol).setType(EGroundType.Finish);
        endNode = nodes.get(iRow).get(iCol);
      } else if (map.pixels[iPixel] == start) {
        nodes.get(iRow).get(iCol).setType(EGroundType.Start);
        startNode = nodes.get(iRow).get(iCol);
      }

      iCol++;
    }
  }

  protected ArrayList<Node> getNeigbours(Node node) {
    ArrayList<Node> neighbours = new ArrayList<Node>();

    // Left neighbour
    if (node.index.x - 1>= 0 && node.index.x < gridSize.x - 1)
      neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x - 1));

    // Right neighbour
    if (node.index.x + 1 < gridSize.x)
      neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x + 1));

    // Upper neighbour
    if (node.index.y - 1 >= 0)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x));

    // Lower Neighbour
    if (node.index.y + 1 < gridSize.y)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x));

    // Left Upper Neighbour
    if (node.index.x - 1 > 0 && node.index.y - 1 > 0)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x - 1));

    // Right Upper Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y - 1> 0)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x + 1));

    // Left Lower Neighbour
    if (node.index.x - 1 > 0 && node.index.y + 1 < gridSize.y)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x - 1));

    // Right Lower Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y + 1 < gridSize.y)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x + 1));

    return neighbours;
  }

  protected ArrayList<Node> getUnvisitedNeighbours(Node node) {
    ArrayList<Node> neighbours = new ArrayList<Node>();

    // Left neighbour
    if (node.index.x - 1>= 0 && node.index.x < gridSize.x - 1 && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x - 1));

    // Right neighbour
    if (node.index.x + 1 < gridSize.x && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x + 1));

    // Upper neighbour
    if (node.index.y - 1 >= 0 && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x));

    // Lower Neighbour
    if (node.index.y + 1 < gridSize.y && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x));

    // Left Upper Neighbour
    if (node.index.x - 1 > 0 && node.index.y - 1 > 0 && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x - 1));

    // Right Upper Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y - 1> 0 && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x + 1));

    // Left Lower Neighbour
    if (node.index.x - 1 > 0 && node.index.y + 1 < gridSize.y && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x - 1));

    // Right Lower Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y + 1 < gridSize.y && !node.IsVisited() && node.eGroundType != EGroundType.NonWalkable)
      neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x + 1));

    return neighbours;
  }
}
