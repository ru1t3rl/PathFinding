class CircleGameObject extends GameObject {
  float radius;

  public CircleGameObject(PVector position, float radius) {
    super(position);
    this.radius = radius;
  }
  
  public boolean Collide(CircleGameObject other){
    float dX = other.position.x - this.position.x;
    float dY = other.position.y - this.position.y;
    float d = (float)Math.sqrt(dX*dX + dY*dY);
    
    return d - (this.radius + other.radius) <= 0;    
  }

  public void draw(){
    super.draw();
    ellipse(getGlobalPosition().x, getGlobalPosition().y, radius, radius);
  }
}
