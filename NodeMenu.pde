class NodeMenu extends GameObjectList {
   //Stone
   Square stoneS, grassS, dirtS;
   TextObject stoneTxt, grassTxt, dirtTxt;
   
   //Start
   Square startS;
   TextObject startTxt;
   
   //Finish
   Square finishS;
   TextObject finishTxt;
  
   public NodeMenu(PVector position){
     super(position);
     
     // Position, Size
     this.Add(stoneS = new Square(new PVector(20, 20), new PVector(20, 20)));
     stoneS.SetColor(stoneColor);
     this.Add(stoneTxt = new TextObject("Stone (1)", new PVector(45, 38), 18));
          
     this.Add(grassS = new Square(new PVector(20, 45), new PVector(20, 20)));
     grassS.SetColor(grassColor);
     this.Add(grassTxt = new TextObject("Grass (2)", new PVector(45, 63), 18));
     
     this.Add(dirtS = new Square(new PVector(20,70), new PVector(20, 20)));
     dirtS.SetColor(dirtColor);
     this.Add(dirtTxt = new TextObject("Dirt (3)", new PVector(45, 88), 18));     
     
     this.Add(startS = new Square(new PVector(20, 95), new PVector(20, 20)));
     startS.SetColor(startColor);
     this.Add(startTxt = new TextObject("Start", new PVector(45, 113), 18)); 
     
     this.Add(finishS = new Square(new PVector(20, 120), new PVector(20, 20)));
     finishS.SetColor(finishColor);
     this.Add(finishTxt = new TextObject("Finish", new PVector(45, 138), 18));
   }
   
   void Update(){
     super.Update();
      if(inputHelper.IsMouseDown()){
         if(mouseX > stoneS.getGlobalPosition().x && mouseX < stoneS.getGlobalPosition().x + stoneS.size.x && mouseY > stoneS.getGlobalPosition().y && mouseY < stoneS.getGlobalPosition().y + stoneS.size.y)
           manager.playingState.algo.selectedNode.setType(EGroundType.Stone);
         if(mouseX > grassS.getGlobalPosition().x && mouseX < grassS.getGlobalPosition().x + grassS.size.x && mouseY > grassS.getGlobalPosition().y && mouseY < grassS.getGlobalPosition().y + grassS.size.y)
           manager.playingState.algo.selectedNode.setType(EGroundType.Grass);
         if(mouseX > dirtS.getGlobalPosition().x && mouseX < dirtS.getGlobalPosition().x + dirtS.size.x && mouseY > dirtS.getGlobalPosition().y && mouseY < dirtS.getGlobalPosition().y + dirtS.size.y)
           manager.playingState.algo.selectedNode.setType(EGroundType.Dirt);
      }
   }
}
