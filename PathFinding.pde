/*
 Before you start developing your game decide wether your use rectMode CENTER or CORNER.
 This will make the default collision detection easier and more precise.
 
 To Add GameSates to the manager go to the StateManager.pde file and add it manually.
 
 TODO:
  - Add a function for adding new GameStates
 */

final int FPS = 60;
InputHelper inputHelper;
GameStateManager manager;

void settings() {
  Debug.log("Setting the Debug mode");
  Debug.mode = Debug.Mode.Release;

  Debug.log("Setting Window Size");
  //fullScreen(P3D);

  size(900, 900, P3D);
}

void setup() {
  Debug.log("Setting Frame Rate");
  frameRate(FPS);

  Debug.log("Turning stroke off");
  noStroke();

  Debug.log("\nEverything is setup! You're ready to rock");
  inputHelper = new InputHelper();
  manager = new GameStateManager(GameState.PlayingState);
}

void Update() {
  manager.Update();
}

void draw() {
  background(255);
  Update();
  manager.draw();
  inputHelper.Update();
}

void keyPressed() {
  inputHelper.keysDown[char(key)] = true;
  inputHelper.keysPressed[char(key)] = true;
}

void keyReleased() {
  inputHelper.keysPressed[char(key)] = false;
}

void mousePressed() {
  inputHelper.mouseDown = true;
  inputHelper.mouseP = true;
}

void  mouseReleased() {
  inputHelper.mouseDown = false;
  inputHelper.mouseP = false;
}

static class Debug {
  private static Mode mode = Mode.Debug;

  public static void log(Object value) {
    if (mode == Mode.Debug || mode == Mode.Develop)
      println(value);
  }

  public static void log(Object value, Mode whenToShow) {
    if (mode == whenToShow)
      println(value);
  }

  public enum Mode {
    Debug,
      Develop,
      Release
  }
}
