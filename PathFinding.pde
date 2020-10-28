/*
 Before you start developing your game decide wether your use rectMode CENTER or CORNER.
 This will make the default collision detection easier and more precise.
 
 To Add GameSates to the manager go to the StateManager.pde file and add it manually.
 
 TODO:
 - Add a function for adding new GameStates
 */

final int FPS = 1000;
InputHelper inputHelper;
GameStateManager manager;

void settings() {
  Debug.log("Setting the Debug mode");
  Debug.mode = Debug.Mode.Develop;

  Debug.log("Setting Window Size");
  //fullScreen(P3D);

  size(1200, 900, P3D);
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
  manager.update();
}

void draw() {
  background(255);
  Update();
  manager.draw();
  inputHelper.update();
}

void keyPressed() {
  try {
    inputHelper.keysDown[char(key)] = true;
    inputHelper.keysPressed[char(key)] = true;
  }
  catch (ArrayIndexOutOfBoundsException e) {
  }
}

void keyReleased() {
  try {
    inputHelper.keysPressed[char(key)] = false;
  }
  catch (ArrayIndexOutOfBoundsException e) {
  }
}

void mousePressed() {
  try {
    inputHelper.mouseDown = true;
    inputHelper.mouseP = true;
  }
  catch (ArrayIndexOutOfBoundsException e) {
  }
}

void  mouseReleased() {
  try {
    inputHelper.mouseDown = false;
    inputHelper.mouseP = false;
  }
  catch (ArrayIndexOutOfBoundsException e) {
  }
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

/// Variables
PVector stoneColor = new PVector(200, 200, 200);
float stoneCost = .5f;
PVector grassColor = new PVector(0, 100, 0);
float grassCost = 7.5f;
PVector dirtColor = new PVector(139, 69, 19);
float dirtCost = 15;
PVector waterColor = new PVector(0, 0, 255);
float waterCost = 35;
PVector nonWalkableColor = new PVector(20, 20, 20);

PVector startColor = new PVector(0, 255, 0);
PVector finishColor = new PVector(255, 0, 0);
