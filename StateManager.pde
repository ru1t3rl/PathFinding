class GameStateManager extends GameObject {
    GameState currentState;

    PlayingState playingState;

    public GameStateManager(GameState startState){
        currentState = startState;

        playingState = new PlayingState();
    }

    public GameStateManager(){
        currentState = GameState.PlayingState;

        playingState = new PlayingState();
    }
    
    public void SetState(GameState state){
       currentState = state; 
    }

    public void Update(){
      super.Update();
        switch (currentState) {
            case PlayingState:
                playingState.Update();
                break;
            default :
                println(currentState.toString()+" is not a valid gameState!");
                break;	
        }
    }
    
    public void draw(){
       super.draw(); 
       switch (currentState) {
            case PlayingState:
                playingState.draw();
                break;
            default :
                println(currentState.toString()+" is not a valid gameState!");
                break;  
        }
    }
}

public enum GameState{
    PlayingState
}
