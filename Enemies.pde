class Enemies
{
  float enemyxPos;
  float enemyyPos;
  float laserYpos;
  float enemySize = 50;
  float laserWidth = 25;
  float laserHeight = 50;
  int shotTimer;
  float enemyYspd = 0.5;
  float laserySpeed = 5;
  PImage enemy;
  PImage laser;
  public Enemies()
  {
   enemyxPos = random(width-enemySize);
   enemyyPos = random(height/2);
   laserYpos = random(height/2);
    
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
    image(laser,enemyxPos,laserYpos);
    if (laserYpos == width && shotTimer >= millis() + 1000)
    {
     image(laser,enemyxPos,laserYpos);
     shotTimer += millis() + 1000;
    }
    
  }
  void moveLasers()
  {
    laserYpos += laserySpeed;
  }
}
