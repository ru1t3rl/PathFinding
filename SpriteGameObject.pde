class SpriteGameObject extends GameObject {
  PImage sprite;
  PVector tint;
  
  public SpriteGameObject(String assetName){
    setup(assetName, new PVector(0, 0), new PVector(0, 0), null); 
  }

  public SpriteGameObject(String assetName, PVector position) {
    setup(assetName, position, new PVector(0, 0), null);
  }

  public SpriteGameObject(String assetName, PVector position, PVector velocity) {
    setup(assetName, position, velocity, null);
  }

  public SpriteGameObject(String assetName, PVector position, PVector velocity, PVector size) {
    setup(assetName, position, velocity, size);
  }

  public void setup(String assetName, PVector position, PVector velocity, PVector size) {
    this.position = position;
    this.velocity = velocity;
    this.size = size;
    
    tint = new PVector(255, 255, 255);
    
    try { 
      sprite = loadImage(assetName);
    }
    catch (Exception ex) {
      sprite = null;
    }
  }

  public void draw() {
    tint(tint.x, tint.y, tint.z);
    if(size != null)
      image(sprite, getGlobalPosition().x, getGlobalPosition().y, size.x, size.y);
    else
      image(sprite, getGlobalPosition().x, getGlobalPosition().y);
  }
}
