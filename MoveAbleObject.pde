class MoveAbleSprite extends SpriteGameObject{
   public MoveAbleSprite(String assetName, PVector velocity){
       super(assetName);
       this.velocity = velocity;
   }
   
   void Update(){
      if(inputHelper.keysPressed['w']){
        position.y -= velocity.y;
      }
      if(inputHelper.keysPressed['s']){
         position.y += velocity.y;
      }
      if(inputHelper.keysPressed['a']){
         position.x -= velocity.x;
      }
      if(inputHelper.keysPressed['d']){
         position.x += velocity.x; 
      }
   }
}
