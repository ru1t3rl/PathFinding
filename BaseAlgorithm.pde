class Algorithm extends Grid {
  GameObjectList[] rows;
  ArrayList<ArrayList<Node>> nodes;
  ArrayList<Node> path = new ArrayList<Node>();
  ArrayList<Node> openSet, closedSet;
  Algorithms algorithm = null;

  boolean started = false, finished;

  Node startNode, currentNode, endNode, selectedNode;

  public Algorithm() {
    super();
  }

  public Algorithm(PVector gridSize) {
    this.gridSize = gridSize;
    this.cellSize = (width/gridSize.x > height/gridSize.y) ? new PVector(height/gridSize.y, height/gridSize.y) : new PVector(width/gridSize.x, width/gridSize.x);
    id = "baseGrid";

    finished = false;

    setupNodes();
  }

  public Algorithm(PVector gridSize, PVector cellSize) {
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "baseGrid";

    finished = false;

    setupNodes();
  }

  public Algorithm(PVector gridSize, PVector cellSize, PVector startNodeIndex) {
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "baseGrid";

    finished = false;

    setupNodes();
    currentNode = nodes.get((int)startNodeIndex.y).get((int)startNodeIndex.x);
  }

  public void start(){
     started = true;
     currentNode = startNode;
     openSet = new ArrayList<Node>();
     closedSet = new ArrayList<Node>();
     openSet.add(currentNode);
  }

  public void update() {
    super.update();

    if (started && !finished)
      search();
  }

  public void draw() {    
    if (!enabled)
      return;

    for (int iNode = 0; iNode < path.size(); iNode++) {
      //path.get(iNode).bg = new PVector(0, 255, 255);
      Node n = path.get(iNode);

      strokeWeight(2);
      stroke(0);
      if (n.previous != null)
        line(n.getGlobalPosition().x + cellSize.x/2, n.getGlobalPosition().y + cellSize.y/2, n.previous.getGlobalPosition().x + cellSize.x/2, n.previous.getGlobalPosition().y + cellSize.y/2);
    }
    
    super.draw();
  }

  protected void search() {
  }

  public void clear() {
    started = false;
    path.clear();
    finished = false;
    resetNode();
  }

  private void resetNode() {
    for (int iRow = 0; iRow < nodes.size(); iRow++) {
      for (int iCol = 0; iCol < nodes.get(iRow).size(); iCol++) {
        nodes.get(iRow).get(iCol).f = 0;
        nodes.get(iRow).get(iCol).h = 0;
        nodes.get(iRow).get(iCol).g = 0;
      }
    }
  }

  public void placeRandomWalls(float change) {
    while (change > 100) {
      change /= 10;
    }

    for (int iRow = 0; iRow < gridSize.y; iRow++) {
      for (int iCol = 0; iCol < gridSize.x; iCol++) {
        if (random(100f) <= change) {
          nodes.get(iRow).get(iCol).setType(EGroundType.NonWalkable);
        }
      }
    }
  }

  void setupNodes() {
    setupNodes(true);
  }


  protected void reconstructPath(Node endNode) {
    Node temp = endNode;

    path = new ArrayList<Node>();
    path.add(temp);

    while (temp.previous != null) {
      path.add(temp.previous);
      temp = temp.previous;
    }
  }

  void setupNodes(boolean allowDiagonal) {
    nodes = new ArrayList<ArrayList<Node>>();
    rows = new GameObjectList[(int)gridSize.y];

    for (int iRow = 0; iRow < this.gridSize.y; iRow++) {
      nodes.add(new ArrayList<Node>());
      this.add(rows[iRow] = new GameObjectList());

      for (int iCol = 0; iCol < this.gridSize.x; iCol++) {
        nodes.get(iRow).add(new Node(new PVector(iCol * cellSize.x, iRow * cellSize.y), cellSize));
        nodes.get(iRow).get(iCol).setIndex(iRow, iCol);

        rows[iRow].add(nodes.get(iRow).get(iCol));
      }
    }

    for (int iRow = 0; iRow < this.gridSize.y; iRow++) {
      for (int iCol = 0; iCol < this.gridSize.x; iCol++) {
        if (iRow > 0) {
          // Upper Middle
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol));

          if (allowDiagonal) {
            // Upper Left
            if (iCol > 0)
              nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol - 1));

            // Upper Right
            if (iCol < this.gridSize.x - 1)
              nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow - 1).get(iCol + 1));
          }
        }

        if (iRow < this.gridSize.y - 1) {
          // Bottom Middle
          nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol));

          if (allowDiagonal) {
            // Bottom left
            if (iCol > 0)
              nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol - 1));

            // Bottom Right
            if (iCol < this.gridSize.x - 1)
              nodes.get(iRow).get(iCol).neighbors.add(nodes.get(iRow + 1).get(iCol + 1));
          }
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

  void start(PVector index) {
    currentNode = nodes.get((int)index.x).get((int)index.y);
    path.add(currentNode);
    started = true;
  }

  protected void setGrid(ArrayList<ArrayList<Node>> grid) {
    nodes = grid;
    rows = new GameObjectList[grid.size()];

    for (int iRow = 0; iRow < grid.size(); iRow++) {
      this.add(rows[iRow] = new GameObjectList());
      for (int iCol = 0; iCol < grid.get(iRow).size(); iCol++) {
        rows[iRow].add(nodes.get(iRow).get(iCol));
      }
    }
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
}

public enum Algorithms {
  Dijkstra,
    aStar,
    BFS
}
