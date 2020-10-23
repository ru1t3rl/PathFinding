class Square extends GameObject {
  PVector clr;
  int Origin = CENTER;

  public Square(PVector position) {
    super(position);

    size = new PVector(10, 10);
    clr = new PVector(0, 0, 0);
    id = "Square";
  }

  public Square(PVector position, PVector size) {
    super(position);
    this.size = size;

    clr = new PVector(0, 0, 0);
    id = "Square";
  }

  public Square(PVector position, PVector size, PVector velocity, PVector clr) {
    super(position, velocity);
    this.size = size;
    this.clr = clr; //The color of the object
    id = "Square";
  }

  public void Update() {
    super.Update();
  }

  public void SetColor(PVector clr) {
    this.clr = clr;
  }

  public void draw() {
    super.draw();
    fill(clr.x, clr.y, clr.z);
    rectMode(Origin);
    rect(getGlobalPosition().x, getGlobalPosition().y, size.x, size.y);
  }
}
