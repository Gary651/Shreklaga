class Enemies
{
  //ad
  float enemyxPos;
  float enemyyPos;
  int shotTime  = millis() + 10000 ;
  float yShot;
  float ySpeed = 1;
  public Enemies()
  {
   enemyxPos = random(width);
   enemyyPos = random(height/2);
   
  }
  
  void drawEnemies()
  {
    rect(enemyxPos,enemyyPos,25,25);
  }
 
  void formation()
  {
    
  }
  
  void drawLasers()
  {
    
    if (shotTime >= 10000)
    {
     rect(enemyxPos,yShot,25,50);
     shotTime = millis() + 10000;
    }
    
  }
  void moveLasers()
  {
     enemyyPos += ySpeed;
    yShot = random(height/2);
  
  }
}
