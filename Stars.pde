class Stars
{
  int starCount = 200;
  float starPos[][] = new float[2][starCount];

  public Stars()
  {
    for(int i = 0; i < starCount; i++)
    {
      starPos[0][i] = random(width);
      starPos[1][i] = random(height);
    }
  }
  void drawStars()
  {
    fill(255);
    noStroke();
    for(int i = 0; i < starCount; i++)
      ellipse(starPos[0][i], starPos[1][i], 5, 5);
  }
}
