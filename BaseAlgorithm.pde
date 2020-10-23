class Algorithm extends Grid {
  GameObjectList[] rows;
  ArrayList<ArrayList<Node>> nodes, paths;
  ArrayList<Node> solutionPath;

  Node startNote, currentNode, endNote;

  public Algorithm(PVector gridSize) {
    this.gridSize = gridSize;
    this.cellSize = (width/gridSize.x > height/gridSize.y) ? new PVector(height/gridSize.y, height/gridSize.y) : new PVector(width/gridSize.x, width/gridSize.x);
    id = "baseGrid";

    SetupNodes();
  }
  
  public Algorithm(PVector gridSize, PVector cellSize) {
      this.gridSize = gridSize;
      this.cellSize = cellSize;
      id = "baseGrid";
      
      SetupNodes();
  }
  
  public Algorithm(PVector gridSize, PVector cellSize, PVector startNodeIndex){
     this.gridSize = gridSize;
     this.cellSize = cellSize;
     id = "baseGrid";
     
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
  }

  void GenerateFinalPath(){
   
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
