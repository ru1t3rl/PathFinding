class TextObject extends GameObject {
  String text;
  int fontSize;
  PVector clr;

  public TextObject(String text, PVector position) {
    super(position);
    this.text = text;
    fontSize = 11;
    clr = new PVector(0, 0, 0);
  }

  public TextObject(String text, PVector position, int fontSize) {
    super(position);
    this.text = text;
    this.fontSize = fontSize;
    clr = new PVector(0, 0, 0);
  }

  public TextObject(String text) {
    super(new PVector(width/2, height/2));
    this.text = text;
    fontSize = 11;
    clr = new PVector(0, 0, 0);
  }
  
  public TextObject(String text, int fontSize){
     super(new PVector(width/2, height/2));
     this.text = text;
     this.fontSize = fontSize;
     clr = new PVector(0, 0, 0);
  }

  public void setText(String value) {
    text = value;
  }

  public void setPosition(PVector position) {
    this.position = position;
  }

  public void setColor(PVector clr){
     this.clr = clr; 
  }

  public void draw() {
    super.draw();
    textSize(fontSize);
    fill(clr.x, clr.y, clr.z);
    text(text, getGlobalPosition().x, getGlobalPosition().y);
  }
}
