class aStart extends GameObjectList { //<>//
  int rows = 5;
  int cols = 5;

  Spot[][] nodes = new Spot[rows][cols];

  Spot startSpot, endSpot, currentSpot;

  //open set still needs evaluation
  ArrayList<Spot> openSet = new ArrayList<Spot>();
  //closet set is finished evaluation
  ArrayList<Spot> closedSet = new ArrayList<Spot>();
  ArrayList<Spot> path = new ArrayList<Spot>();

  public aStart() {
    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        this.Add(nodes[i][j] = new Spot(new PVector(i * (width/ cols), j * (height/rows)), new PVector(width/cols, height/rows)));
      }
    }

    for (int i = 0; i < cols; i++) {
      for (int j = 0; j < rows; j++) {
        if (i > 0)
          nodes[i][j].addNeighbor(nodes[i-1][j]);
        if (i < cols - 1)
          nodes[i][j].addNeighbor(nodes[i+1][j]);
        if (j > 0)
          nodes[i][j].addNeighbor(nodes[i][j-1]);
        if (j < rows - 1)
          nodes[i][j].addNeighbor(nodes[i][j+1]);
      }
    }

    startSpot = nodes[0][0];
    endSpot = nodes[cols - 1][rows - 1];

    openSet.add(startSpot);
  }

  public void Update() {
    super.Update();

    if (openSet.isEmpty())
      return;

    int lowestIndex = 0;
    for (int i = 0; i < openSet.size(); i++) {
      if (openSet.get(i).f < openSet.get(lowestIndex).f)
        lowestIndex = i;
    }

    currentSpot = openSet.get(lowestIndex);

    if (currentSpot == endSpot && path.isEmpty()) {
      Debug.log("Done");
      // Find Path
      noLoop();
    }

    openSet.remove(currentSpot);
    closedSet.add(currentSpot);

    ArrayList<Spot> neighbors = currentSpot.neighbors;
    for (int i = 0; i < neighbors.size(); i++) {
      Spot neighbor = neighbors.get(i);

      if (!closedSet.contains(neighbor)) {
        float tempG = currentSpot.g + 1;

        if (openSet.contains(neighbor)) {
          if (tempG < neighbor.g) {
            neighbor.g = tempG;
          }
        } else {
          neighbor.g = tempG;
          openSet.add(neighbor);
        }

        neighbor.h = heuristic(neighbor, endSpot);
        neighbor.f = neighbor.g + neighbor.h;
        neighbor.Parent = currentSpot;
      }
    }

    path = new ArrayList<Spot>();
    Spot temp = currentSpot;
    path.add(temp);

    while (temp.parent != null) {
      path.add(temp.parent);
      temp = temp.parent;
    }
  }
  
  float heuristic(Spot current, Spot end) {
    //float d = dist(current.position.x, current.position.x, end.position.x, end.position.y);
    float d = abs(current.position.x - end.position.x) + abs(current.position.y - end.position.y);
    return d;
  }

  public void draw() {
    super.draw();
    /*
    for (int i = 0; i < cols; i++) {
     for (int j = 0; j < rows; j++) {
     nodes[i][j].clr = new PVector(255, 255, 255);
     }
     }
     */

    for (int i = 0; i < openSet.size(); i++) {
      openSet.get(i).clr = new PVector(0, 255, 0);
    }

    for (int i = 0; i < closedSet.size(); i++) {
      closedSet.get(i).clr = new PVector(255, 0, 0);
    }

    for (int i = 0; i < path.size(); i++) {
      path.get(i).clr = new PVector(0, 0, 0);
    }
  }
}

class Spot extends GameObject {
  float f = 0,
    g = 0,
    h = 0;

  Spot parent = null;

  PVector clr = new PVector(255, 255, 255);

  ArrayList<Spot> neighbors = new ArrayList<Spot>();

  public Spot(PVector position, PVector size) {
    super(position, size);
  }

  public void addNeighbor(Spot spot) {
    neighbors.add(spot);
  }

  public void draw() {
    super.draw();
    stroke(0);
    strokeWeight(1);
    fill(clr.x, clr.y, clr.z);
    rect(getGlobalPosition().x, getGlobalPosition().y, size.x, size.y);
  }
}
