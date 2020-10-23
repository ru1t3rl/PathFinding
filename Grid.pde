/* TODO: Replacenew GameObject in SetupCells with Cell */
/* TODO: Add a SetupCells with background color*/

class Grid extends GameObjectList {
  PVector gridSize, cellSize;
  float weight;
  GameObjectList[] rows;

  public Grid(PVector gridSize, PVector cellSize) {
    super();
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "Grid";
    SetupCells();
  }

  public Grid() {
    super();
  }

  public Grid(PVector gridSize) {
    super();
    this.gridSize = gridSize;
    this.cellSize = (width/gridSize.x > height/gridSize.y) ? new PVector(height/gridSize.y, height/gridSize.y) : new PVector(width/gridSize.x, width/gridSize.x);
    id = "Grid";

    SetupCells();
  }

  public Grid(PVector gridSize, PVector cellSize, PVector bg) {
    super();
    this.gridSize = gridSize;
    this.cellSize = cellSize;
    id = "Grid";

    SetupCells(bg);
  }

  void Update() {
    super.Update();
  }

  void draw() {
    super.draw();
  }

  void SetupCells() {
    rows = new GameObjectList[(int)gridSize.y];

    for (int iRow = 0; iRow < gridSize.y; iRow++) {
      // Intialize the GameObjectList which will contain the cells of that row
      rows[iRow] = new GameObjectList();

      for (int iCol = 0; iCol < gridSize.x; iCol++) {
        rows[iRow].Add(new Cell(new PVector(cellSize.x * iCol, cellSize.y * iRow), cellSize));
      }

      Add(rows[iRow]);
    }
  }

  void SetupCells(PVector bg) {
    rows = new GameObjectList[(int)gridSize.y];

    for (int iRow = 0; iRow < gridSize.y; iRow++) {
      // Intialize the GameObjectList which will contain the cells of that row
      rows[iRow] = new GameObjectList();

      for (int iCol = 0; iCol < gridSize.x; iCol++) {
        rows[iRow].Add(new Cell(new PVector(cellSize.x * iCol, cellSize.y * iRow), cellSize, bg));
      }

      Add(rows[iRow]);
    }
  }

  public void SetBackground(PVector background) {
    for (int iRow = 0; iRow < gridSize.y; iRow++) {
      for (int iCol = 0; iCol < gridSize.x; iCol++) {
        Cell c = (Cell)rows[iRow].children.get(iCol);
        c.bg = background;
        rows[iRow].children.set(iCol, c);
      }
      children.set(iRow, rows[iRow]);
    }
  }
}
