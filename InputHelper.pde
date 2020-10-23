class InputHelper extends GameObject{
  private final int MAX_KEYS = 1024;
  private boolean[] keysPressed = new boolean[MAX_KEYS], 
    keysDown = new boolean[MAX_KEYS];
  //private boolean[] previousKeys = new boolean[MAX_KEYS];
  private int[] framesActive;
  private boolean mouseDown, mouseP;

  public InputHelper() {
    framesActive = new int[MAX_KEYS];
    for (int iKey = 0; iKey < MAX_KEYS; iKey++) {
      framesActive[iKey] = 0;
    }
  }

  public void Update() {
    // Loop through all the keys and check if it's active
    // When it's active add 1 to the corresponding framesActive
    // if the framesActive is greater then 1 the key is pressed and not down (down means keyPressed for 1 frame)
    for (int iKey = 0; iKey < MAX_KEYS; iKey++) {
      if (keysPressed[iKey]) {
        framesActive[iKey]++;
        if (framesActive[iKey] <= 1)
          keysDown[iKey] = true;
        else
          keysDown[iKey] = false;
      } else
        framesActive[iKey] = 0;
    }

    mouseDown = false;
  }

  public boolean IsKeyPressed(int keyCode) {
    return keysPressed[keyCode];
  }
  
  public boolean IsKeyPressed(char key){
     return keysPressed[key]; 
  }

  public boolean IsKeyDown(int keyCode) {
    return keysDown[keyCode];
  }
  
  public boolean IsKeyDown(char key){
     return keysDown[key]; 
  }

  // Will return true the entire time mouse is down
  public boolean IsMousePressed(){
    return mouseP;
  }

  // Will only return true the first frame the mouse is pressed
  public boolean IsMouseDown(){
    return mouseDown;
  }
}
