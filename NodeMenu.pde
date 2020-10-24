class NodeMenu extends GameObjectList {
  //Stone
  Square stoneS, grassS, dirtS, waterS, nonWalkableS;
  TextObject stoneTxt, grassTxt, dirtTxt, waterTxt, nonWalkableTxt;

  Square startS, finishS;
  TextObject startTxt, finishTxt;

  Square startBtn, clearBtn, randomBtn;
  TextObject btnText, clearTxt, randomTxt;

  EGroundType selectedType = null;

  public NodeMenu(PVector position) {
    super(position);

    // Tile Types
    this.Add(stoneS = new Square(new PVector(20, 20), new PVector(20, 20), EGroundType.Stone));
    stoneS.SetColor(stoneColor);
    this.Add(stoneTxt = new TextObject("Stone ("+stoneCost+")", new PVector(45, 38), 18));

    this.Add(grassS = new Square(new PVector(20, 45), new PVector(20, 20), EGroundType.Grass));
    grassS.SetColor(grassColor);
    this.Add(grassTxt = new TextObject("Grass ("+grassCost+")", new PVector(45, 63), 18));

    this.Add(dirtS = new Square(new PVector(20, 70), new PVector(20, 20), EGroundType.Dirt));
    dirtS.SetColor(dirtColor);
    this.Add(dirtTxt = new TextObject("Dirt ("+dirtCost+")", new PVector(45, 88), 18));

    this.Add(waterS = new Square(new PVector(20, 95), new PVector(20, 20), EGroundType.Water));
    waterS.SetColor(waterColor);
    this.Add(waterTxt = new TextObject("Water ("+waterCost+")", new PVector(45, 113), 18));

    this.Add(nonWalkableS = new Square(new PVector(20, 120), new PVector(20, 20), EGroundType.NonWalkable));
    nonWalkableS.SetColor(nonWalkableColor);
    this.Add(nonWalkableTxt = new TextObject("Non-Walkable", new PVector(45, 138), 18));

    // Start and finish
    this.Add(startS = new Square(new PVector(20, 175), new PVector(20, 20), EGroundType.Start));
    startS.SetColor(startColor);
    this.Add(startTxt = new TextObject("Start", new PVector(45, 193), 18));

    this.Add(finishS = new Square(new PVector(20, 200), new PVector(20, 20), EGroundType.Finish));
    finishS.SetColor(finishColor);
    this.Add(finishTxt = new TextObject("Finish", new PVector(45, 218), 18));

    // Start Button
    this.Add(startBtn = new Square(new PVector(20, height - 105), new PVector(300 - 40, 40)));
    startBtn.SetColor(new PVector(200, 200, 200));
    this.Add(btnText = new TextObject("Start", new PVector(20 + 300/3, height - 77), 20));

    // Random Button
    this.Add(randomBtn = new Square(new PVector(20, height - 150), new PVector(300 - 40, 40)));
    randomBtn.SetColor(new PVector(200, 200, 200));
    this.Add(randomTxt = new TextObject("Random Walls", new PVector(20 + 300/5, height - 122), 20));

    // Clear Button
    clearBtn = new Square(new PVector(20, height - 60), new PVector(300 - 40, 40));
    clearBtn.SetColor(new PVector(200, 200, 200));
    clearTxt = new TextObject("Clear", new PVector(20 + 300/3, height - 32), 20);
    clearBtn.Parent = this;
    clearTxt.Parent = this;
  }

  void Update() {
    super.Update();
    if (inputHelper.IsMouseDown()) {

      if (manager.playingState.algo.selectedNode != null) {
        // Tile Types
        if (mouseX > stoneS.getGlobalPosition().x && mouseX < stoneS.getGlobalPosition().x + stoneS.size.x && mouseY > stoneS.getGlobalPosition().y && mouseY < stoneS.getGlobalPosition().y + stoneS.size.y)
          manager.playingState.algo.selectedNode.setType(EGroundType.Stone);
        if (mouseX > grassS.getGlobalPosition().x && mouseX < grassS.getGlobalPosition().x + grassS.size.x && mouseY > grassS.getGlobalPosition().y && mouseY < grassS.getGlobalPosition().y + grassS.size.y)
          manager.playingState.algo.selectedNode.setType(EGroundType.Grass);
        if (mouseX > dirtS.getGlobalPosition().x && mouseX < dirtS.getGlobalPosition().x + dirtS.size.x && mouseY > dirtS.getGlobalPosition().y && mouseY < dirtS.getGlobalPosition().y + dirtS.size.y)
          manager.playingState.algo.selectedNode.setType(EGroundType.Dirt);
        if (mouseX > nonWalkableS.getGlobalPosition().x && mouseX < nonWalkableS.getGlobalPosition().x + nonWalkableS.size.x && mouseY > nonWalkableS.getGlobalPosition().y && mouseY < nonWalkableS.getGlobalPosition().y + nonWalkableS.size.y)
          manager.playingState.algo.selectedNode.setType(EGroundType.NonWalkable);
        if (mouseX > waterS.getGlobalPosition().x && mouseX < waterS.getGlobalPosition().x + waterS.size.x && mouseY > waterS.getGlobalPosition().y && mouseY < waterS.getGlobalPosition().y + waterS.size.y)
          manager.playingState.algo.selectedNode.setType(EGroundType.Water);

        // Start and finish
        if (mouseX > startS.getGlobalPosition().x && mouseX < startS.getGlobalPosition().x + startS.size.x && mouseY > startS.getGlobalPosition().y && mouseY < startS.getGlobalPosition().y + startS.size.y) {
          manager.playingState.algo.startNode = manager.playingState.algo.selectedNode;
          manager.playingState.algo.selectedNode.setType(EGroundType.Start);
        }
        if (mouseX > finishS.getGlobalPosition().x && mouseX < finishS.getGlobalPosition().x + finishS.size.x && mouseY > finishS.getGlobalPosition().y && mouseY < finishS.getGlobalPosition().y + finishS.size.y) {
          manager.playingState.algo.endNode = manager.playingState.algo.selectedNode;
          manager.playingState.algo.selectedNode.setType(EGroundType.Finish);
        }
      } else {
        // Tile Types
        if (mouseX > stoneS.getGlobalPosition().x && mouseX < stoneS.getGlobalPosition().x + stoneS.size.x && mouseY > stoneS.getGlobalPosition().y && mouseY < stoneS.getGlobalPosition().y + stoneS.size.y) {
          if (selectedType != EGroundType.Stone)
            selectedType = EGroundType.Stone;
          else
            selectedType = null;
        }
        if (mouseX > grassS.getGlobalPosition().x && mouseX < grassS.getGlobalPosition().x + grassS.size.x && mouseY > grassS.getGlobalPosition().y && mouseY < grassS.getGlobalPosition().y + grassS.size.y) {
          if (selectedType != EGroundType.Grass)
            selectedType = EGroundType.Grass;
          else
            selectedType = null;
        }
        if (mouseX > dirtS.getGlobalPosition().x && mouseX < dirtS.getGlobalPosition().x + dirtS.size.x && mouseY > dirtS.getGlobalPosition().y && mouseY < dirtS.getGlobalPosition().y + dirtS.size.y) {
          if (selectedType != EGroundType.Dirt)
            selectedType = EGroundType.Dirt;
          else
            selectedType = null;
        }
        if (mouseX > nonWalkableS.getGlobalPosition().x && mouseX < nonWalkableS.getGlobalPosition().x + nonWalkableS.size.x && mouseY > nonWalkableS.getGlobalPosition().y && mouseY < nonWalkableS.getGlobalPosition().y + nonWalkableS.size.y) {
          if (selectedType != EGroundType.NonWalkable)
            selectedType = EGroundType.NonWalkable;
          else
            selectedType = null;
        }
        if (mouseX > waterS.getGlobalPosition().x && mouseX < waterS.getGlobalPosition().x + waterS.size.x && mouseY > waterS.getGlobalPosition().y && mouseY < waterS.getGlobalPosition().y + waterS.size.y) {
          if (selectedType != EGroundType.Water)
            selectedType = EGroundType.Water;
          else
            selectedType = null;
        }

        // Start and finish
        if (mouseX > startS.getGlobalPosition().x && mouseX < startS.getGlobalPosition().x + startS.size.x && mouseY > startS.getGlobalPosition().y && mouseY < startS.getGlobalPosition().y + startS.size.y) {
          if (selectedType != EGroundType.Start)
            selectedType = EGroundType.Start;
          else
            selectedType = null;
        }

        if (mouseX > finishS.getGlobalPosition().x && mouseX < finishS.getGlobalPosition().x + finishS.size.x && mouseY > finishS.getGlobalPosition().y && mouseY < finishS.getGlobalPosition().y + finishS.size.y) {
          if (selectedType != EGroundType.Finish)
            selectedType = EGroundType.Finish;
          else
            selectedType = null;
        }
      }

      // Random Walls button
      if (mouseX > randomBtn.getGlobalPosition().x && mouseX < randomBtn.getGlobalPosition().x + randomBtn.size.x && mouseY > randomBtn.getGlobalPosition().y && mouseY < randomBtn.getGlobalPosition().y + randomBtn.size.y)
        manager.playingState.algo.PlaceRandomWalls(random(10f, 35f));

      // Start Button
      if (mouseX > startBtn.getGlobalPosition().x && mouseX < startBtn.getGlobalPosition().x + startBtn.size.x && mouseY > startBtn.getGlobalPosition().y && mouseY < startBtn.getGlobalPosition().y + startBtn.size.y) {
        manager.playingState.algo.Start();
        btnText.SetText("Running");
      }

      // Clear Button
      if (manager.playingState.algo.started) {
        if (mouseX > clearBtn.getGlobalPosition().x && mouseX < clearBtn.getGlobalPosition().x + clearBtn.size.x && mouseY > clearBtn.getGlobalPosition().y & mouseY < clearBtn.getGlobalPosition().y + clearBtn.size.y) {
          manager.playingState.algo.Clear();
          btnText.SetText("Start");
        }
      }
    }
  }

  void draw() {
    super.draw();

    if (manager.playingState.algo.started) {
      clearBtn.draw();
      clearTxt.draw();
    }
  }
}
