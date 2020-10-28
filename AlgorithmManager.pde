class AlgorithmManager extends GameObjectList {
  AStar aStar;
  Dijkstra dijkstra;
  BestFirstSearch bfs;
  Algorithm base;

  Algorithms algorithm;

  boolean started = false, finished = false;

  public AlgorithmManager(PVector gridSize, PVector cellSize) {
    this.add(base = new Algorithm(gridSize, cellSize));

    this.add(aStar = new AStar());
    aStar.enabled = false;
    aStar.cellSize = cellSize;
    aStar.gridSize = gridSize;

    this.add(bfs = new BestFirstSearch());
    bfs.enabled = false;
    bfs.cellSize = cellSize;
    bfs.gridSize = gridSize;

    this.add(dijkstra = new Dijkstra());
    dijkstra.enabled = false;
    dijkstra.cellSize = cellSize;
    dijkstra.gridSize = gridSize;
  }

  void update() {
    super.update();

    if (started) {
      finished = aStar.finished || bfs.finished || dijkstra.finished;
    }
  }

  void start(Algorithms algo) {
    started = true;

    switch(algo) {
    case aStar:
      base.enabled = false;
      aStar.enabled = true;
      aStar.setGrid(base.nodes);
      aStar.startNode = base.startNode;
      aStar.endNode = base.endNode;
      aStar.start();
      break;
    case Dijkstra:
      base.enabled = false;
      dijkstra.enabled = true;
      dijkstra.setGrid(base.nodes);
      dijkstra.startNode = base.startNode;
      dijkstra.endNode = base.endNode;
      dijkstra.start();
      break;
    case BFS:
      base.enabled = false;
      bfs.enabled = true;
      bfs.setGrid(base.nodes);
      bfs.startNode = base.startNode;
      bfs.endNode = base.endNode;
      bfs.start();
      break;
    }

    algorithm = algo;
  }

  public void clear() {
    base.enabled = true;
    base.clear();

    aStar.enabled = false;
    dijkstra.enabled = false;
    bfs.enabled = false;

    aStar.finished = false;
    bfs.finished = false;
    dijkstra.finished = false;

    finished = false;
    started = false;
  }
}
