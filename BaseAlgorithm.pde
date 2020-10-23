class Algorithm extends Grid {
  GameObjectList[] rows;
  ArrayList<ArrayList<Node>> nodes;

  Node startNote, endNote;

  public Algorithm(PVector gridSize) {
    this.gridSize = gridSize;
    this.cellSize = (width/gridSize.x > height/gridSize.y) ? new PVector(height/gridSize.y, height/gridSize.y) : new PVector(width/gridSize.x, width/gridSize.x);
    id = "baseGrid";

    SetupNodes();
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
  }

  ArrayList<Node> GetNeigbours(Node node) {
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

  ArrayList<Node> GetUnvisitedNeighbour(Node node) {
    ArrayList<Node> neighbours = new ArrayList<Node>();

    // Left neighbour
    if (node.index.x - 1>= 0 && node.index.x < gridSize.x - 1 && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x - 1));

    // Right neighbour
    if (node.index.x + 1 < gridSize.x && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y).get((int)node.index.x + 1));

    // Upper neighbour
    if (node.index.y - 1 >= 0 && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x));

    // Lower Neighbour
    if (node.index.y + 1 < gridSize.y && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x));

    // Left Upper Neighbour
    if (node.index.x - 1 > 0 && node.index.y - 1 > 0 && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x - 1));

    // Right Upper Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y - 1> 0 && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y - 1).get((int)node.index.x + 1));

    // Left Lower Neighbour
    if (node.index.x - 1 > 0 && node.index.y + 1 < gridSize.y && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x - 1));

    // Right Lower Neighbour
    if (node.index.x + 1 < gridSize.x && node.index.y + 1 < gridSize.y && !node.IsVisited())
    neighbours.add(nodes.get((int)node.index.y + 1).get((int)node.index.x + 1));
    
    return neighbours;
  }
}
