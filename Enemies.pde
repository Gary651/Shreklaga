class Enemies
{
  //Tracking variables
  public float enemyxPos;
  public float enemyyPos;
  public float enemyLaserYpos;
  public float enemySize = 60;
  public boolean laserOnScreen = true;
  float laserWidth = 35;
  float laserHeight = 50;
  float shotTimer;
  float enemyYspd = random(1,2);
  float enemyXspd = 0.5;  
  float laserySpeed = 5;
  float destination;
  int enemyOffset = 0;
  PImage enemy;
  PImage laser;
  boolean enemyHasReachedDestination = false;
  boolean enemyOffScreen = false;
  boolean enemyLeavingScreen = false;
  
  public Enemies(int x, int y)
  {
   //Sets random positions for the enemy x positions and y positions and sets these positions in bounds
   destination = x;
   enemyxPos = -100;
   enemyyPos = y+enemyOffset;
   
   //Sets the enemy laser's y position to the enemy's y position
   enemyLaserYpos = enemyyPos;
   shotTimer = 0;
    
    /*Switch case to set the enemy's character to a random character
      If the case is not 0, 1, or 2, the enemy is automatically set to Rumplestiltskin*/
    switch( int(random(4)) )
    {
      case 0:
        enemy = loadImage("fairyGodMother.png");
        laser = loadImage("spellOrb.png");
        break;
      case 1:
        enemy = loadImage("lordFarquad.png");
        laser = loadImage("sword.png");
        break;
      case 2:
        enemy = loadImage("princeCharming.png");
        laser = loadImage("charmingJr.png");
        break;
      default:
        enemy = loadImage("rumpelstiltskin.png");
        laser = loadImage("coinShot.png");
        break;
    }
    laser.resize(int(laserWidth),0);//Resizes all lasers to 35
  }
  
  void drawEnemies()
  {
    //Resizes the enemy to the enemy size(60)
    enemy.resize(int(enemySize),0);
    
    //Sets the enemy's image mode to center and draws the enemy at their specific x position and y position
    imageMode(CENTER);
    image(enemy,enemyxPos,(enemyyPos - enemyOffset));
    
    if(enemyLeavingScreen)
    {
      enemyOffset -= 5;
      laserOnScreen = false;
    }
  }
  
  
  void moveEnemy()
  {
   enemyxPos += 15;
   if(enemyxPos > destination)
   {
     enemyxPos = destination;
     enemyHasReachedDestination = true;
   }
  }
  
  void drawLasers()
  {
    if(enemyLaserYpos > height)
      laserOnScreen = false;
    if(laserOnScreen)//If the laser is on screen
    {
      imageMode(CENTER);
      image(laser,enemyxPos,enemyLaserYpos);//Draws laser
    }
    else if(!laserOnScreen && shotTimer <= millis())//If there is no laser on screen
    {
      enemyLaserYpos = (enemyyPos + enemyOffset);//Sets the laser's y position to the enemy's y position
      shotTimer = millis() + random(2000);//Makes the shot timer for the enemy
      laserOnScreen = true;//Says that there is a laser on screen
    }
  }
  
  //Moves the laser down the screen
  void moveLasers()
  {
    enemyLaserYpos += laserySpeed;
  }
  
  void enemyHit()
  {
    //If the player shot is within the radius of the enemy, if the player shot is on screen and if the enemy is not leaving the screen
    if(dist(enemyxPos, (enemyyPos + enemyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && !enemyLeavingScreen)
    {
      p.shotOnScreen = false;//Removes the player's shot from the screen
      h.score = h.score + 50;//Adds 50 to the player's score
      enemyLeavingScreen = true;//Makes the enemy leave the screen
      if(h.score <= h.highScore)
        h.highScore = h.highScore + 50;
    }
    //If enemy player gets shot while leaving the screen
    else if(dist(enemyxPos, (enemyyPos + enemyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && enemyLeavingScreen)
      p.shotOnScreen = false;//Remove the player shot from the screen
  }
  
}
