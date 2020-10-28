class AStar extends Algorithm {
  Node lastCheckedNode;

  public void start() {    
    super.start();
    if (startNode != null && endNode != null) {
      clear();

      started = true;

      openSet = new ArrayList<Node>();
      closedSet = new ArrayList<Node>();

      openSet.add(startNode);
    }
  }

  void update(){
     super.update();

     if(started && !finished)
       search();
  }

  protected void search() {      
    if (openSet.isEmpty()) {
      manager.playingState.menu.statusTxt.setText("Not Found!");
      return;
    } else if (finished)
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
      manager.playingState.menu.statusTxt.setText("Finished!");
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
        } else if (tempG >= neighbor.g) {
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

  float heuristic(Node current, Node end) {
    float d = abs(current.position.x - end.position.x) + abs(current.position.y - end.position.y);
    return d;
  }

  public void clear() {
    super.clear();
    try{
    openSet.clear();
    closedSet.clear();
    } catch (NullPointerException ex) { }
  }
}
