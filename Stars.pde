class Stars
{
  //Sets the number of stars in the sky and creates an array with that many stars
  int starCount = 500;
  float starPos[][] = new float[2][starCount];

  public Stars()
  {
    //Sets the current star's x position and y position to random
    for(int i = 0; i < starCount; i++)
    {
      starPos[0][i] = random(width);
      starPos[1][i] = random(height);
    }
  }
  void drawStars()
  {
    //Makes stars white and removes their strokes
    fill(255);
    noStroke();
    //Sets every star's position to the current x and y positions, and sets their size to 5 by 5
    for(int i = 0; i < starCount; i++)
      ellipse(starPos[0][i], starPos[1][i], 5, 5);
  }
}
