class Enemies
{
  //Tracking variables
  public float enemyxPos = 0.0;
  public float enemyyPos = 0.0;
  public float enemyLaserYpos;
  public float enemySize = 60;
  public boolean laserOnScreen = true;
  float laserWidth = 35;
  float laserHeight = 50;
  float shotTimer = 0;
  float enemyYspd = random(1,2);
  float enemyXspd = 0.5;  
  float laserySpeed = 5;
  int destination;
  int enemyOffset = 0;
  PImage enemy;
  PImage laser;
  boolean enemyHasReachedDestination=false;
  boolean enemyOffScreen = false;
  boolean enemyLeavingScreen = false;
  boolean firstShot = true;
 
  public Enemies(int x, int y)
  {
   /*Sets the enemy's destination to the given x
     While this is initially zero, it will change later and the enemies will not be able to go onscreen until it changes*/
   destination = x;
   enemyxPos = -100;//sets the x position to -100 to allow the enemy to move onto screen when it needs to
   enemyyPos = y+enemyOffset;//Adds the enemy offset to the y given added to the offset given
   
   //Sets the enemy laser's y position to the enemy's y position
   enemyLaserYpos = enemyyPos;
   shotTimer = millis() + random(100, 2000) + 65000;
   
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
    image(enemy,enemyxPos,(enemyyPos - enemyOffset));//Setting the y position to enemyyPos - enemyOffset allows the enemy to move down the screen
   
    //If the enemy is leaving the screen, move it down the screen and remove it's laser
    if(enemyLeavingScreen)
    {
      enemyOffset -= 5;
      laserOnScreen = false;
    }
  }
 
 
  void moveEnemy()
  {
    enemyxPos += 15;//Moves the enemy very fastly into position
    if(enemyxPos >= destination && destination > 0)//If the enemy has reached it's destination on screen
    {
       enemyxPos = destination;//Stop enemy
       enemyHasReachedDestination = true;//Says that enemy has reached it's destination
    }
    else//If the enemy has not reached it's on screen destination
      enemyHasReachedDestination = false;//Says that  enemy has not reached it's destination
      
    int enemiesInPosition = 0;
    for(int i = 0; i < enemyCount; i++)
    {
      if(e[i].enemyHasReachedDestination)
        enemiesInPosition++;
      else
        return;
    }
    if(enemiesInPosition == enemyCount)
    {
      allEnemiesInPosition = true;
      //println(millis()+" "+enemiesInPosition);
      if(firstShot)
      {
        firstShot = false;
        for(Enemies bad: e)
          bad.shotTimer = random(5000);
      }
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
    else if(!laserOnScreen && shotTimer >= millis() )// + random(100,2000))//If there is no laser on screen and the enemy's shot timer is at it's position
    {
      //if(firstShot)
      {
      //  firstShot=false;
      //  shotTimer = random(10,10000);
      }
      //else
      {
        enemyLaserYpos = (enemyyPos + enemyOffset);//Sets the laser's y position to the enemy's y position
        laserOnScreen = true;//Says that there is a laser on screen
      }
      shotTimer = millis() + random(100, 5000);//Makes the shot timer for the enemy
    }
  }
 
  //Moves the laser down the screen
  void moveLasers()
  {
    imageMode(CENTER);
    enemyLaserYpos += laserySpeed;
  }
 
  void trackPlayer()
  {
   
  }
 
  void enemyHit()
  {
    //If the player shot is within the radius of the enemy, if the player shot is on screen and if the enemy is not leaving the screen
    if(dist(enemyxPos, (enemyyPos + enemyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && !enemyLeavingScreen)
    {
      p.shotOnScreen = false;//Removes the player's shot from the screen
      h.score = h.score + 50;//Adds 50 to the player's score
      enemyLeavingScreen = true;//Makes the enemy leave the screen
      enemyCount--;
      if(h.score <= h.highScore)
        h.highScore = h.highScore + 50;
    }
    //If enemy player gets shot while leaving the screen
    else if(dist(enemyxPos, (enemyyPos + enemyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && enemyLeavingScreen)
      p.shotOnScreen = false;//Remove the player shot from the screen
  }
 
}
