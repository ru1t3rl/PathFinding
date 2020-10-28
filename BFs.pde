class BestFirstSearch extends Algorithm {

  public void start() {
    super.start();
  }

  public void update() {
    super.update();

    if (started && !finished)
      search();
  }

  protected void search() {
    if (openSet.isEmpty()) {
      finished = true;
      return;
    }

    int lowestIndex = 0;
    for (int iNode = 0; iNode < currentNode.neighbors.size(); iNode++) {
      Node neighbor = currentNode.neighbors.get(iNode);

      if (!closedSet.contains(neighbor) && neighbor.eGroundType != EGroundType.NonWalkable) {
        if (manDistance(neighbor, endNode) < manDistance(currentNode.neighbors.get(lowestIndex), endNode)) {
          lowestIndex = iNode;
        }

        openSet.add(neighbor);
      }
    }

    closedSet.add(currentNode);
    openSet.remove(currentNode);

    currentNode.neighbors.get(lowestIndex).previous = currentNode;
    currentNode = currentNode.neighbors.get(lowestIndex);

    path.add(currentNode);

    if (currentNode == endNode) {
      finished = true;
    }
  }

  float manDistance(Node n1, Node n2) {
    float distanceX = Math.abs(n1.position.x - n2.position.x);
    float distanceY = Math.abs(n1.position.y - n2.position.y);
    float distance;

    if (distanceX >= distanceY)
    {
      distance = (distanceX - distanceY) + distanceY * 1.4f;
    } else
    {
      distance = (distanceY - distanceX) + distanceX * 1.4f;
    }

    return distance;
  }
}
