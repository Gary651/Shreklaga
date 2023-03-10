class HUD
{
  void points()
  {
    fill(255);
    text("Points: ", width-200, 50);
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
    circle(width/12,height-50,20);
    circle(width/10,height-50,20);
    circle(width/8.5,height-50,20);
  }
}
