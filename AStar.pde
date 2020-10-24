class AStar extends Algorithm {
  ArrayList<Node> openSet, closedSet;
  Node lastCheckedNode;

  public AStar(PVector gridSize) {
    super(gridSize);
  }

  public AStar(PVector gridSize, PVector cellSize) {
    super(gridSize, cellSize);
  }

  public AStar(PVector gridSize, PVector cellSize, PVector startNodeIndex) {
    super(gridSize, cellSize, startNodeIndex);
  }

  private void reconstructPath(Node endNode) {
    path = new ArrayList<Node>();
    Node temp = endNode;
    path.add(temp);
    
    while(temp.previous != null){
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
    // Draw path
    if (path != null) {
      for (int iNode = 0; iNode < path.size(); iNode++) {
        path.get(iNode).bg = new PVector(0, 255, 255);
      }
    }
    
    super.draw();
  }

  public void FindPath() {
    if (openSet.isEmpty()){
      manager.playingState.menu.btnText.SetText("Not Found!");
      return;
    } else if(finished)
      return;

    int lowestIndex = 0;
    for (int iNode = 0; iNode < openSet.size(); iNode++) {
      if (openSet.get(iNode).f < openSet.get(lowestIndex).f) {
        lowestIndex = iNode;
      }

      if (openSet.get(iNode).f == openSet.get(lowestIndex).f) {
        if (openSet.get(iNode).g > openSet.get(lowestIndex).g) {
          lowestIndex = iNode;
        }
      }
    }

    currentNode = openSet.get(lowestIndex);
    lastCheckedNode = currentNode;

    if (currentNode == endNode) {
      finished = true;
      manager.playingState.menu.btnText.SetText("Finished!");
    }

    openSet.remove(currentNode);
    closedSet.add(currentNode);

    ArrayList<Node> neighbors = currentNode.neighbors;
    for (int iNode = 0; iNode < neighbors.size(); iNode++) {
      Node neighbor = neighbors.get(iNode);

      if (!closedSet.contains(neighbor) && neighbor.eGroundType != EGroundType.NonWalkable) {
        float tempG = currentNode.g + heuristic(neighbor, currentNode) + neighbor.cost;

        if (!openSet.contains(neighbor)) {
            openSet.add(neighbor);
        } else if(tempG >= neighbor.g) {
          // It's not a better path 
          continue; 
        }

        neighbor.g = tempG;
        neighbor.h = heuristic(neighbor, endNode);
        neighbor.f = neighbor.g + neighbor.h;
        neighbor.previous = currentNode;
      }
    }

    reconstructPath(lastCheckedNode);
  }
  
  public void PlaceRandomWalls(float change){
    while(change > 100){
       change /= 10; 
    }
    
    for(int iRow = 0; iRow < gridSize.y; iRow++){
      for(int iCol = 0; iCol < gridSize.x; iCol++){
         if(random(100f) <= change){
            nodes.get(iRow).get(iCol).setType(EGroundType.NonWalkable); 
         }
      }
    }
  }

  float heuristic(Node current, Node end) {
    //float d = dist(current.position.x, current.position.x, end.position.x, end.position.y);
    float d = abs(current.position.x - end.position.x) + abs(current.position.y - end.position.y);
    return d;
  }
}
