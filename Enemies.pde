class Enemies
{
  public float enemyxPos;
  public float enemyyPos;
  public float laserYpos;
  float enemySize = 50;
  float laserWidth = 25;
  float laserHeight = 50;
  float shotTimer;
  float enemyYspd = 0.5;
  float laserySpeed = 5;
  PImage enemy;
  PImage laser;
  
  public Enemies()
  {
   enemyxPos = random(width-enemySize);
   enemyyPos = random(height/2);
   laserYpos = random(height/2);
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
    image(laser,enemyxPos,laserYpos);
    
    if (laserYpos > height && shotTimer <= millis())
    {
     //image(laser,enemyxPos,laserYpos);
     laserYpos = enemyyPos;
     shotTimer = millis() + 10000;
    }
    
  }
  void moveLasers()
  {
    laserYpos += laserySpeed;
  }
}
