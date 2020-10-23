class GameObject {
  PVector velocity, position, size;

  boolean enabled = true;
  String id = "Null";
  GameObject Parent;
  protected float deltaTime = 0;


  public GameObject() {
    Setup(new PVector(0, 0), new PVector(0, 0), new PVector(0, 0));
  }

  public GameObject(PVector position) {
    Setup(position, new PVector(0, 0), new PVector(0, 0));
  }

  public GameObject(PVector position, PVector size) {
    Setup(position, size, new PVector(0, 0));
  }

  public GameObject(PVector position, PVector size, PVector velocity) {
    Setup(position, size, velocity);
  }

  protected void Setup(PVector position, PVector size, PVector velocity) {
    this.position = position;
    this.velocity = velocity;
    this.size = size;
  }

  public void Update() {
    deltaTime = frameRate*1.0 / FPS;
    PVector newVelocity = velocity;
    position.add(newVelocity.mult(deltaTime));
  }

  public void draw() {
  }

  public boolean Collide(GameObject other, RECTMODE mode) {
    boolean x = false,
      y = false;

    if (mode == RECTMODE.Center) {
      x = (other.position.x - size.x/2 > this.position.x - size.x/2 && other.position.x - size.x/2 < this.position.x + size.x/2) ||
        (other.position.x + size.x/2 > this.position.x - size.x/2 && other.position.x + size.x/2 < this.position.x + size.x/2);
      y = (other.position.y - size.y/2 > this.position.y - size.y/2 && other.position.y - size.y/2 < this.position.y + size.y/2) ||
        (other.position.y + size.y/2 > this.position.y - size.y/2 && other.position.y + size.y/2 < this.position.y + size.y/2);
    } else if (mode == RECTMODE.Corner) {
      x = (other.position.x > this.position.x && other.position.x < this.position.x + size.x ||
        other.position.x + size.x > this.position.x && other.position.x + size.x < this.position.x + size.x);
      y = (other.position.y > this.position.y && other.position.y < this.position.y + size.y ||
        other.position.y + size.y > this.position.y && other.position.y + size.y < other.position.y + size.y);
    } else {
      println("This specified rectmode isn't valid");
    }

    return x && y;
  }


  public PVector getGlobalPosition() {
    if (Parent != null)
      return new PVector(position.x + Parent.getGlobalPosition().x, position.y + Parent.getGlobalPosition().y);
    else
      return position;
  }
}

public enum RECTMODE {
  Center,
    Corner
}
