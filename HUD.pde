class HUD
{
  /*Tracking variables
    Some are public so that they can be called outside of HUD class*/
  public int playerLives = 3;
  public int level = 1;
  public int score;
  public int highScore;
  public float heartxPos;
  int size = 25;
  PImage shrekLives;
  PImage gingyLives;
  
  public HUD()
  {
    //Loads hearts for both Shrek and the Gingerbread Man
    shrekLives = loadImage("heart.png");
    shrekLives.resize(size, 0);
    gingyLives = loadImage("candyHeart.png");
    gingyLives.resize(size, 0);
    score = 0;//Sets score to zero(will be changed whenever the player hits an enemy)
    heartxPos = 0;//Sets the heart x position to zero to allow it to track later on
  }
  
  void titleScreen()
  {
    push();
    fill(#08FA66);
    textAlign(CENTER);
    textSize(200);
    text("Shreklaga", width/2, height-800);
    rectMode(CENTER);
    textSize(30);
    rect(width/2,height/2,300,50);
    fill(0);
    text("click anywhere to start", width/2, height-510);
    pop();
  }
  
  void score()
  {
    //Displays the score in the right hand side of the screen
    fill(255);
    text("Score: " + score, width/1.15, height-900);
    textSize(25);
  }
  
  void highScore()
  {
    //Displays the high score in the right hand of the screen
    fill(255);
    if(score == highScore)
      highScore = score;
    text("HighScore: " + highScore, width/1.15, height-870);
    textSize(25);
    
  }
  
  void loadHighScore()
  {
    //load the high score
    String [] highScoreSave = loadStrings("High Score.txt");
    highScore = Integer.parseInt(highScoreSave[0]);
  }
  
  void saveHighScore()
  {
    //save the high score 
    PrintWriter hScore = createWriter( "High Score.txt" );
    hScore.println(highScore);
    hScore.flush();
    hScore.close();
  }
  
  void level()
  {
    //Displays the level in the right hand of the screen
    fill(255);
    text("Level: " + level, width/1.15, height-840);
    textSize(25);
  }
  
  void lives()
  {
    imageMode(CENTER);//Centers players hearts
    for(int i = 1; i <= playerLives; i++)
    {
      //Evenly spaces the player's hearts
      if(i == 1)
        heartxPos = width/12;
      if(i == 2)
        heartxPos = width/10;
      if(i == 3)
        heartxPos = width/8.5;
      if(p.playingAsShrek)//If the user is playing as Shrek, draws Shrek's hearts
        image(shrekLives, heartxPos, height-50);
      if(p.playingAsGingy)//If the user is playing as the Gingerbread Man, draws Gingy's hearts
        image(gingyLives, heartxPos, height-50);
    }
  }
  
  public void gameOverScreen()
  {
    //Writes "GAME OVER!" whenever the player is out of lives
    fill(#FA3535);
    textAlign(CENTER);
    textSize(300);
    text("GAME OVER!", width/2, height/2);
  }
  
}
