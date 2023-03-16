class Enemies
{
  public float enemyxPos;
  public float enemyyPos;
  public float enemyLaserYpos;
  public float enemySize = 60;
  float laserWidth = 25;
  float laserHeight = 50;
  float shotTimer;
  float enemyYspd = 0.5;
  float laserySpeed = 5;
  PImage enemy;
  PImage laser;
  
  public Enemies()
  {
   enemyxPos = random(enemySize/2,width-(enemySize/2));
   enemyyPos = random(enemySize/2,height/2);
   enemyLaserYpos = random(enemySize/2,height/2);
   shotTimer = 0;
    
    switch( int(random(4)) )
    {
      case 0:
        enemy = loadImage("fairyGodMother.png");
        break;
      case 1:
        enemy = loadImage("lordFarquad.png");
        break;
      case 2:
        enemy = loadImage("princeCharming.png");
        break;
      default:
        enemy = loadImage("rumpelstiltskin.png");
    }
    laser = loadImage("stankOnion.png");
  }
  
  void drawEnemies()
  {
    enemy.resize(int(enemySize),0);
    image(enemy,enemyxPos,enemyyPos);
    imageMode(CENTER);
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
    laser.resize(int(laserWidth)*2,0);
    image(laser,enemyxPos,enemyLaserYpos);
    
    if (enemyLaserYpos > height && shotTimer <= millis())
    {
     //image(laser,enemyxPos,enemyLaserYpos);
     enemyLaserYpos = enemyyPos;
     shotTimer = millis() + random(10000);
    }
    
  }
  
  void moveLasers()
  {
    enemyLaserYpos += laserySpeed;
  }
  
  void enemyHit()
  {
    if(dist(enemyxPos, enemyyPos, p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen)
    {
      p.shotOnScreen = false;
      h.score = h.score + 50;
      if(h.score <= h.highScore)
      {
        h.highScore = h.highScore + 50;
      }
      else
      {
        
      }
    }
  }
}
