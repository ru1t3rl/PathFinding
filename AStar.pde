class AStar extends Algorithm {
  ArrayList<Node> openNodes;
  ArrayList<Node> unvisitedN;

  public AStar(PVector gridSize) {
    super(gridSize);

    id="AStar";
    openNodes  = new ArrayList<Node>();
  }

  public AStar(PVector gridSize, PVector cellSize) {
    super(gridSize, cellSize);

    id="AStar";
    openNodes = new ArrayList<Node>();
  }

  public AStar(PVector gridSize, PVector cellSize, PVector startNodeIndex) {
    super(gridSize, cellSize, startNodeIndex);

    id="AStar";
    openNodes = new ArrayList<Node>();
    started = false;
  }

  void Start(PVector index) {
    currentNode = nodes.get((int)index.x).get((int)index.y);
    solutionPath.add(currentNode);
    started = true;
  }

  void Update() {
    super.Update();   

    
    
    if (currentNode == endNote | !started)
      return;
      
    unvisitedN = getUnvisitedNeighbours(currentNode);
    for (int iNode = 0; iNode < unvisitedN.size(); iNode++) {
      openNodes.add(unvisitedN.get(iNode));
      openNodes.get(openNodes.size() - 1).Parent = currentNode;
    }

    Node cheapestNode = null;
    // Checks All open nodes to get the shortes route to the finish
    for (int iNode = openNodes.size(); iNode-- > 0; ) {
      if (cheapestNode == null)
        cheapestNode = openNodes.get(iNode);

      // if the heurestic of iNode < previous select this as new
      if (getHeuristic(cheapestNode) > getHeuristic(openNodes.get(iNode)))
        cheapestNode = openNodes.get(iNode);
    }

    currentNode.Visit();
    currentNode = cheapestNode;
    solutionPath.add(currentNode);
  }

  public float getHeuristic(Node node) {
    float distanceX = node.position.x - endNote.position.x;
    float distanceY = node.position.y - endNote.position.y;
    float distance;

    if (distanceX >= distanceY)
      distance = (distanceX - distanceY) + distanceX * 1.4f;
    else
      distance = (distanceY - distanceX) + distanceY * 1.4f;

    return node.cost + distance;
  }
}
