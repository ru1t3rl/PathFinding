class NodeMenu extends GameObjectList {
  //Stone
  Square stoneS, grassS, dirtS, waterS, nonWalkableS;
  TextObject stoneTxt, grassTxt, dirtTxt, waterTxt, nonWalkableTxt;

  Square startS, finishS;
  TextObject startTxt, finishTxt;

  Square clearBtn, randomBtn, exportBtn, loadBtn;
  TextObject clearTxt, randomTxt, exportTxt, loadTxt;

  EGroundType selectedType = null;

  TextObject statusTxt;
  
  Square aStarBtn, dijkBtn, bfsBtn;
  TextObject aStarTxt, dijkTxt, bfsTxt;

  public NodeMenu(PVector position) {
    super(position);

    // Tile Types
    this.add(stoneS = new Square(new PVector(20, 20), new PVector(20, 20), EGroundType.Stone));
    stoneS.setColor(stoneColor);
    this.add(stoneTxt = new TextObject("Stone ("+stoneCost+")", new PVector(45, 38), 18));

    this.add(grassS = new Square(new PVector(20, 45), new PVector(20, 20), EGroundType.Grass));
    grassS.setColor(grassColor);
    this.add(grassTxt = new TextObject("Grass ("+grassCost+")", new PVector(45, 63), 18));

    this.add(dirtS = new Square(new PVector(20, 70), new PVector(20, 20), EGroundType.Dirt));
    dirtS.setColor(dirtColor);
    this.add(dirtTxt = new TextObject("Dirt ("+dirtCost+")", new PVector(45, 88), 18));

    this.add(waterS = new Square(new PVector(20, 95), new PVector(20, 20), EGroundType.Water));
    waterS.setColor(waterColor);
    this.add(waterTxt = new TextObject("Water ("+waterCost+")", new PVector(45, 113), 18));

    this.add(nonWalkableS = new Square(new PVector(20, 120), new PVector(20, 20), EGroundType.NonWalkable));
    nonWalkableS.setColor(nonWalkableColor);
    this.add(nonWalkableTxt = new TextObject("Non-Walkable", new PVector(45, 138), 18));

    // Start and finish
    this.add(startS = new Square(new PVector(20, 175), new PVector(20, 20), EGroundType.Start));
    startS.setColor(startColor);
    this.add(startTxt = new TextObject("Start", new PVector(45, 193), 18));

    this.add(finishS = new Square(new PVector(20, 200), new PVector(20, 20), EGroundType.Finish));
    finishS.setColor(finishColor);
    this.add(finishTxt = new TextObject("Finish", new PVector(45, 218), 18));

    this.add(statusTxt = new TextObject("Status: Idle", new PVector(20, height - 212), 18));

    // Export n Load Button
    this.add(exportBtn = new Square(new PVector(20, height - 195), new PVector(300/2 - 25, 40)));
    exportBtn.setColor(new PVector(200, 200, 200));
    this.add(exportTxt = new TextObject("Export", new PVector(20 + 300/8, height - 167), 18));

    this.add(loadBtn = new Square(new PVector(5+300/2, height - 195), new PVector(300/2 - 25, 40)));
    loadBtn.setColor(new PVector(200, 200, 200));
    this.add(loadTxt = new TextObject("Load", new PVector(20 + 300/1.7f, height - 167), 18));


    // Start Button    
    this.add(aStarBtn = new Square(new PVector(20, height - 105), new PVector(300/3f - 25, 40)));
    aStarBtn.setColor(new PVector(200, 200, 200));
    this.add(aStarTxt = new TextObject("A*", new PVector(20 +300/10f, height - 77), 20));
    
    this.add(dijkBtn = new Square(new PVector(5+300/2.75f, height - 105), new PVector(300/3f - 25, 40)));
    dijkBtn.setColor(new PVector(200, 200, 200));
    this.add(dijkTxt = new TextObject("Dijk...", new PVector(20 + 300/2.9f, height - 77), 20));
    
    this.add(bfsBtn = new Square(new PVector(5+300/1.5f, height - 105), new PVector(300/3f - 25, 40)));
    bfsBtn.setColor(new PVector(200, 200, 200));
    this.add(bfsTxt = new TextObject("BFS", new PVector(20 + 300/1.48f, height - 77), 20));

    // Random Button
    this.add(randomBtn = new Square(new PVector(20, height - 150), new PVector(300 - 40, 40)));
    randomBtn.setColor(new PVector(200, 200, 200));
    this.add(randomTxt = new TextObject("Random Walls", new PVector(20 + 300/5, height - 122), 20));

    // Clear Button
    clearBtn = new Square(new PVector(20, height - 60), new PVector(300 - 40, 40));
    clearBtn.setColor(new PVector(200, 200, 200));
    clearTxt = new TextObject("Clear", new PVector(20 + 300/3, height - 32), 20);
    clearBtn.Parent = this;
    clearTxt.Parent = this;
  }

  void update() {
    super.update();
    if (inputHelper.IsMouseDown()) {

      if (manager.playingState.algo.base.selectedNode != null) {
        // Tile Types
        if (mouseX > stoneS.getGlobalPosition().x && mouseX < stoneS.getGlobalPosition().x + stoneS.size.x && mouseY > stoneS.getGlobalPosition().y && mouseY < stoneS.getGlobalPosition().y + stoneS.size.y)
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Stone);
        if (mouseX > grassS.getGlobalPosition().x && mouseX < grassS.getGlobalPosition().x + grassS.size.x && mouseY > grassS.getGlobalPosition().y && mouseY < grassS.getGlobalPosition().y + grassS.size.y)
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Grass);
        if (mouseX > dirtS.getGlobalPosition().x && mouseX < dirtS.getGlobalPosition().x + dirtS.size.x && mouseY > dirtS.getGlobalPosition().y && mouseY < dirtS.getGlobalPosition().y + dirtS.size.y)
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Dirt);
        if (mouseX > nonWalkableS.getGlobalPosition().x && mouseX < nonWalkableS.getGlobalPosition().x + nonWalkableS.size.x && mouseY > nonWalkableS.getGlobalPosition().y && mouseY < nonWalkableS.getGlobalPosition().y + nonWalkableS.size.y)
          manager.playingState.algo.base.selectedNode.setType(EGroundType.NonWalkable);
        if (mouseX > waterS.getGlobalPosition().x && mouseX < waterS.getGlobalPosition().x + waterS.size.x && mouseY > waterS.getGlobalPosition().y && mouseY < waterS.getGlobalPosition().y + waterS.size.y)
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Water);

        // Start and finish
        if (mouseX > startS.getGlobalPosition().x && mouseX < startS.getGlobalPosition().x + startS.size.x && mouseY > startS.getGlobalPosition().y && mouseY < startS.getGlobalPosition().y + startS.size.y) {
          manager.playingState.algo.base.startNode = manager.playingState.algo.base.selectedNode;
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Start);
        }
        if (mouseX > finishS.getGlobalPosition().x && mouseX < finishS.getGlobalPosition().x + finishS.size.x && mouseY > finishS.getGlobalPosition().y && mouseY < finishS.getGlobalPosition().y + finishS.size.y) {
          manager.playingState.algo.base.endNode = manager.playingState.algo.base.selectedNode;
          manager.playingState.algo.base.selectedNode.setType(EGroundType.Finish);
        }

        statusTxt.setText("Status: Idle");
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
        statusTxt.setText("Status: Idle");
      }

      if (mouseX > exportBtn.getGlobalPosition().x && mouseX < exportBtn.getGlobalPosition().x + exportBtn.size.x && mouseY > exportBtn.getGlobalPosition().y && mouseY < exportBtn.getGlobalPosition().y + exportBtn.size.y) {
        statusTxt.setText("Status: Exporting");
        PImage map = manager.playingState.algo.base.exportMap();
        map.save(dataPath("map.png"));
        statusTxt.setText("Status: Exported");
      }
      if (mouseX > loadBtn.getGlobalPosition().x && mouseX < loadBtn.getGlobalPosition().x + loadBtn.size.x && mouseY > loadBtn.getGlobalPosition().y && mouseY < loadBtn.getGlobalPosition().y + loadBtn.size.y) {
        statusTxt.setText("Status: Loading");
        manager.playingState.algo.base.loadMap(loadImage("data/map.png"));
        statusTxt.setText("Status: Loaded");
      }

      // Random Walls button
      if (mouseX > randomBtn.getGlobalPosition().x && mouseX < randomBtn.getGlobalPosition().x + randomBtn.size.x && mouseY > randomBtn.getGlobalPosition().y && mouseY < randomBtn.getGlobalPosition().y + randomBtn.size.y)
        manager.playingState.algo.base.placeRandomWalls(random(10f, 35f));

      // Start Button
      if (mouseX > aStarBtn.getGlobalPosition().x && mouseX < aStarBtn.getGlobalPosition().x + aStarBtn.size.x && mouseY > aStarBtn.getGlobalPosition().y && mouseY < aStarBtn.getGlobalPosition().y + aStarBtn.size.y) {
        manager.playingState.algo.start(Algorithms.aStar);
        statusTxt.setText("Status: Finding Path");
      }
      
      if (mouseX > dijkBtn.getGlobalPosition().x && mouseX < dijkBtn.getGlobalPosition().x + dijkBtn.size.x && mouseY > dijkBtn.getGlobalPosition().y && mouseY < dijkBtn.getGlobalPosition().y + dijkBtn.size.y) {
        manager.playingState.algo.start(Algorithms.Dijkstra);
        statusTxt.setText("Status: Finding Path");
      }
      
      if (mouseX > bfsBtn.getGlobalPosition().x && mouseX < bfsBtn.getGlobalPosition().x + bfsBtn.size.x && mouseY > bfsBtn.getGlobalPosition().y && mouseY < bfsBtn.getGlobalPosition().y + bfsBtn.size.y) {
        manager.playingState.algo.start(Algorithms.BFS);
        statusTxt.setText("Status: Finding Path");
      }

      // Clear Button
      if (manager.playingState.algo.started) {
        if (mouseX > clearBtn.getGlobalPosition().x && mouseX < clearBtn.getGlobalPosition().x + clearBtn.size.x && mouseY > clearBtn.getGlobalPosition().y & mouseY < clearBtn.getGlobalPosition().y + clearBtn.size.y) {
          manager.playingState.algo.clear();
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
