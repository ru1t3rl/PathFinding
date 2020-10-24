class AStar extends Algorithm {
  ArrayList<Node> openSet, closedSet;

  public AStar(PVector gridSize) {
    super(gridSize);
  }

  public AStar(PVector gridSize, PVector cellSize) {
    super(gridSize, cellSize);
  }

  public AStar(PVector gridSize, PVector cellSize, PVector startNodeIndex) {
    super(gridSize, cellSize, startNodeIndex);
  }

  private void reconstructPath(Node current) {
    path = new ArrayList<Node>();

    Node temp = current;
    path.add(temp);

    while (temp.previous != null) {
      path.add(temp.previous);
      temp = temp.previous;
    }
  }

  public void Start() {
    if (startNode != null && endNode != null) {
      started = true;

      openSet = new ArrayList<Node>();
      closedSet = new ArrayList<Node>();

      openSet.add(startNode);
    }
  }

  public void Clear() {
    started = false;
    openSet.clear();
    closedSet.clear();
    path.clear();
    finished = false;
    ResetNodes();
  }

  private void ResetNodes() {
    for (int iRow = 0; iRow < nodes.size(); iRow++) {
      for (int iCol = 0; iCol < nodes.get(iRow).size(); iCol++) {
        nodes.get(iRow).get(iCol).f = 0;
        nodes.get(iRow).get(iCol).h = 0;
        nodes.get(iRow).get(iCol).g = 0;
      }
    }
  }

  public void Update() {
    super.Update();

    if (started && !finished)
      FindPath();
  }

  public void draw() {
    super.draw();

    // Draw path
    if (path != null) {
      for (int iNode = 0; iNode < path.size(); iNode++) {
        path.get(iNode).bg = new PVector(0, 255, 255);
      }
    }
  }

  public void FindPath() {
    if (openSet.isEmpty() || finished)
      return;

    int lowestIndex = 0;
    for (int iNode = 0; iNode < openSet.size(); iNode++) {
      if (openSet.get(iNode).f < openSet.get(lowestIndex).f) {
        lowestIndex = iNode;
      }
    }

    currentNode = openSet.get(lowestIndex);

    if (currentNode == endNode) {
      finished = true;
      manager.playingState.menu.btnText.SetText("Finished!");
    }

    openSet.remove(currentNode);
    closedSet.add(currentNode);

    ArrayList<Node> neighbors = currentNode.neighbors;
    for (int iNode = 0; iNode < neighbors.size(); iNode++) {
      Node neighbor = neighbors.get(iNode);

      if (!closedSet.contains(neighbor)) {
        float tempG = currentNode.g + 1;

        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.g)
            neighbor.g = tempG;
        } else {
          neighbor.g = tempG;
          if (neighbor.eGroundType != EGroundType.NonWalkable)
            openSet.add(neighbor);
        }

        neighbor.h = heuristic(neighbor, endNode);
        neighbor.f = neighbor.g + neighbor.h;
        neighbor.previous = currentNode;
      }
    }

    reconstructPath(currentNode);
  }

  float heuristic(Node current, Node end) {
    //float d = dist(current.position.x, current.position.x, end.position.x, end.position.y);
    float d = abs(current.position.x - end.position.x) + abs(current.position.y - end.position.y);
    return d;
  }
}
