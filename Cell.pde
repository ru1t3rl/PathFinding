class Cell extends GameObjectList {
  public PVector bg;
  boolean prevEn, selected;

  public Cell(PVector position, PVector size) {
    super();
    this.position = position;
    this.size = size;

    id = "Cell";
    bg = new PVector(255, 255, 255);
    setupBorders();
  }

  public Cell(PVector position, PVector size, PVector bg) {
    super();
    this.position = position;
    this.size = size;
    this.bg = bg;

    id = "Cell";
    setupBorders();
  }


  void update() {
    super.update();
    if (prevEn != enabled) {
      for (GameObject gobj : children) {
        gobj.enabled = enabled;
      }
    }

    prevEn = enabled;

    if (inputHelper.IsMouseDown()) {
      if ((mouseX > getGlobalPosition().x && mouseX < getGlobalPosition().x - size.x) && (mouseY > getGlobalPosition().y && mouseY < getGlobalPosition().y + size.y)) {
        // Show a bar for setting the tile type
      }
    }
  }

  protected void setupBorders() {
    // Top Border
    this.add(new Border(Position.Top, new PVector(0, 0), new PVector(size.x, 0)));

    // Left Border
    this.add(new Border(Position.Left, new PVector(0, 0), new PVector(0, size.x)));

    // Right Border
    this.add(new Border(Position.Right, new PVector(size.x, 0), new PVector(size.x, size.y)));

    // Bottom Border
    this.add(new Border(Position.Bottom, new PVector(0, size.y), new PVector(size.x, size.y)));
  }

  public void toggleWall(Position pos) {
    for (int iBorder = 0; iBorder < this.children.size(); iBorder++) {
      Border b = (Border)this.children.get(iBorder);

      if (b.Pos() == pos) {
        this.children.get(iBorder).enabled = !this.children.get(iBorder).enabled;
      }
    }
  }

  public void draw() {
    super.draw();

    noStroke();
    fill(bg.x, bg.y, bg.z);
    rect(getGlobalPosition().x, getGlobalPosition().y, size.x, size.y);
  }
}

public enum Position {
  Top,
    Bottom,
    Left,
    Right
}

class Border extends GameObject {
  PVector start, end, clr;
  float weight;
  Position pos;
  Node parent;



  public Position Pos() {
    return pos;
  }

  public Border(Position pos, PVector start, PVector end) {
    this.start = start;
    this.end = end;
    this.pos = pos;

    weight = 1;
    clr = new PVector(0, 0, 0);
  }

  public Border(Position pos, PVector start, PVector end, Node parent) {
    this.start = start;
    this.end = end;
    this.pos = pos;

    weight = 1;
    clr = new PVector(0, 0, 0);
    this.parent = parent;
  }

  public Border(PVector start, PVector end, PVector clr) {
    this.start = start;
    this.end = end;

    this.clr = clr;
    weight = 1;
  }

  public Border(PVector start, PVector end, float weight) {
    this.start = start;
    this.end = end;
    this.weight = weight;

    clr = new PVector(0, 0, 0);
  }

  public Border(PVector start, PVector end, PVector clr, float weight) {
    this.start = start;
    this.end = end;

    this.clr = clr;
    this.weight = weight;
  }

  public void draw() {
    if (enabled) {
      strokeWeight(0.5f);
      if (!parent.selected)
        stroke(clr.x, clr.y, clr.z, 255);
      else
        stroke(255, 0, 0);
        
      line(Parent.getGlobalPosition().x + start.x, Parent.getGlobalPosition().y + start.y, Parent.getGlobalPosition().x + end.x, Parent.getGlobalPosition().y + end.y);
    }
  }
}
