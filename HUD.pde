class HUD
{
  public int playerLives = 3;
  public int score;
  public float heartxPos;
  int size = 25;
  PImage lives;
  public HUD()
  {
    lives = loadImage("heart.png");
    lives.resize(int(size),0);
    score = 0;
    heartxPos = 0;
  }
  void score()
  {
    fill(255);
    text("Score: " + score, width-200, 50);
    textSize(25);
  }
  
  void highScore()
  {
    fill(255);
    text("HighScore: ", width-200, 80);
    textSize(25);
  }
  
  void level()
  {
    fill(255);
    text("Level: ", width-200, 110);
    textSize(25);
  }
  
  void lives()
  {
    imageMode(CENTER);
    for(int i = 1; i <= playerLives; i++)
    {
      if(i == 1)
        heartxPos = width/12;
      if(i == 2)
        heartxPos = width/10;
      if(i == 3)
        heartxPos = width/8.5;
      image(lives, heartxPos, height-50);
    }
  }
  
  public void gameOverScreen()
  {
    fill(#FA3535);
    textAlign(CENTER);
    textSize(300);
    text("GAME OVER!", width/2, height/2);
  }
}
