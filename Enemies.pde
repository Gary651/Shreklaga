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
  float enemyYspd = 2;
  float enemyXspd = 0.5;  
  float laserySpeed = 5;
  PImage enemy;
  PImage laser;
  
  public Enemies()
  {
   //Sets random positions for the enemy x positions and y positions and sets these positions in bounds
   enemyxPos = random(enemySize/2,width-(enemySize/2));
   enemyyPos = random(enemySize/2,height/2);
   
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
    image(enemy,enemyxPos,enemyyPos);
  }
  
  
  void moveEnemy()//Not complete
  {
   //enemyyPos += enemyYspd;
   if(millis() >= 10000)
   {
   enemyyPos += random( enemyYspd); 
  //  enemyxPos += random(enemyXspd);
   }
  }
 
  void formation()//Not complete
  {
    
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
    
    if(!laserOnScreen)//If there is no laser on screen
    {
      //image(laser,enemyxPos,enemyLaserYpos);
      enemyLaserYpos = enemyyPos;//Sets the laser's y position to the enemy's y position
      shotTimer = millis() + random(10000);//Makes the shot timer for the enemy
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
    //If the player shot is within the radius of the enemy and the player shot is on screen
    if(dist(enemyxPos, enemyyPos, p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen)
    {
      p.shotOnScreen = false;//Removes the player's shot from the screen
      laserOnScreen = false;//Removes the enemy's shot off of screen
      h.score = h.score + 50;//Adds 50 to the player's score
      if(h.score <= h.highScore)
      {
        h.highScore = h.highScore + 50;
      }
    }
  }
  
}
