class Enemies
{
  float enemyxPos;
  float enemyyPos;
  float laserYpos;
  float enemySize = 25;
  float laserWidth = 25;
  float laserHeight = 50;
  int shotTimer;
  float enemyYspd = 0.5;
  float laserySpeed = 5;
  public Enemies()
  {
   enemyxPos = random(width-enemySize);
   enemyyPos = random(height/2);
   laserYpos = random(height/2);
   
  }
  
  void drawEnemies()
  {
    fill(#FA031F);
    square(enemyxPos,enemyyPos,enemySize);
  }
  void moveEnemy()
  {
    enemyyPos += enemyYspd;
  }
 
  void formation()
  {
    
  }
  
  void drawLasers()
  {
    fill(#03FA1D);
    rect(enemyxPos,laserYpos,laserWidth,laserHeight);
    if (laserYpos == width && shotTimer >= millis() + 1000)
    {
     rect(enemyxPos,laserYpos,25,50);
     shotTimer += millis() + 1000;
    }
    
  }
  void moveLasers()
  {
    laserYpos += laserySpeed;
  }
}
