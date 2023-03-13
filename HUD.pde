class HUD
{
  int size = 25;
  PImage lives;
  public HUD()
  {
    lives = loadImage("heart.png");
    lives.resize(int(size),0);
  }
  void score()
  {
    fill(255);
    text("Score: ", width-200, 50);
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
    fill(255);
    image(lives,width/12,height-50);
    image(lives,width/10,height-50);
    image(lives,width/8.5,height-50);
    imageMode(CENTER);
  }
}
