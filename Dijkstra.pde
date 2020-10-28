class Dijkstra extends Algorithm {
  Node lastCurrentNode;

  public void start() {
    super.start();

    openSet = new ArrayList<Node>();
    closedSet = new ArrayList<Node>();

    for (int iRow = 0; iRow < nodes.size(); iRow++) {
      for (int iCol = 0; iCol < nodes.get(iRow).size(); iCol++) {
        nodes.get(iRow).get(iCol).g = MAX_FLOAT;
        nodes.get(iRow).get(iCol).previous = null;
        
        openSet.add(nodes.get(iRow).get(iCol));
      }
    }
       
    currentNode = startNode;
    currentNode.g = 0;
  }

  public void update() {
    super.update();

    if (started && !finished)
      search();
  }

  public void search() {
    if (openSet.isEmpty()) {
      finished = true;
      return;
    }
    
    if (currentNode == endNode) {
      finished = true;
      reconstructPath(currentNode);
      return;
    }

    for (int iNode = 0; iNode < currentNode.neighbors.size(); iNode++) {
      Node neighbor = currentNode.neighbors.get(iNode);

      // if the is walkable and not in already visited
      if (neighbor.eGroundType != EGroundType.NonWalkable && !closedSet.contains(neighbor)) {

        float alt = currentNode.g + distance(neighbor, currentNode) + neighbor.cost;     

        if (alt < neighbor.g) {
          neighbor.g = alt;
          neighbor.previous = currentNode;
        }
      }
    }

    closedSet.add(currentNode);
    openSet.remove(currentNode);

    currentNode = getMinNode();

    reconstructPath(currentNode);
  }

  float distance(Node n1, Node n2) {
    float dX = abs(n1.position.x - n2.position.x) + abs(n1.position.y - n2.position.y);
    return dX * 10;
  }

  Node getMinNode() {
    int lowestIndex = 0;
    for (int iNode = 0; iNode < openSet.size(); iNode++) {
      if (openSet.get(iNode).g < openSet.get(lowestIndex).g)
        lowestIndex = iNode;
    }

    Node n = openSet.get(lowestIndex);
    return n;
  }
}
