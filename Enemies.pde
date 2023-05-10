class Enemies
{
  //Tracking variables
  public float enemyxPos = 0.0;
  public float enemyyPos = 0.0;
  public float enemyLaserYpos;
  public float enemySize = 60;
  public boolean laserOnScreen = false;
  float laserWidth = 35;
  float laserHeight = 50;
  float shotTimer = 0;
  float enemyYspd = random(1,2);
  float enemyXspd = 0.5;
  float laserySpeed = 5;
  int destination;
  int enemyyOffset = 0;
  int enemyxOffset = 0;
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
   enemyyPos = y+enemyyOffset;//Adds the enemy offset to the y given added to the offset given
   
   //Sets the enemy laser's y position to the enemy's y position
   enemyLaserYpos = enemyyPos;
   
   if(h.level == 1)//If the player is on the first level
   {
     if(millis() < 46000)
       shotTimer = random(300,2000) + 61000;
     
     else if(millis() > 60000)
       shotTimer = random(300,2000) + 73000;
   }
     
   /*If the player is on the second level, add 16500(16.5 seconds) to millis and the shot timer
     This makes it to where each enemy has a random shot timer on the second level*/
   else if(h.level == 2)
     shotTimer = millis() + 16500 + random(300,2000);
     
   /*If the player is on the first level, add 12000(12 seconds) to the shot timer
     This makes it to where each enemy has a random shot timer on the third level*/
   else if(h.level == 3)
     shotTimer = millis() + 12000 + random(300,2000);
   
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
    //Resizes the enemy to the enemy size(60)
    enemy.resize(int(enemySize),0);
    laser.resize(int(laserWidth),0);//Resizes all lasers to 35
  }
 
  void drawEnemies()
  {
    //Sets the enemy's image mode to center and draws the enemy at their specific x position and y position
    imageMode(CENTER);
    image(enemy,(int)(enemyxPos + enemyxOffset),(enemyyPos + enemyyOffset));//Setting the y position to enemyyPos - enemyOffset allows the enemy to move down the screen
  }
 
 
  void moveEnemy()
  {
    enemyxPos += 15;//Moves the enemy very fastly into position
    if(enemyxPos >= destination && destination > 0)//If the enemy has reached it's destination on screen
    {
       enemyxPos = destination;//Stop enemy
       enemyHasReachedDestination = true;//Says that enemy has reached it's destination
    }
    
      if( !allEnemiesInPosition )//If all enemies aren't in position
      {
        int enemiesInPosition = 0;//Set enemiesInPosition to zero
        for(int i = 0; i < enemyCount; i++)
        {
          if(e[i].enemyHasReachedDestination)//If the enemy is in it's position
            enemiesInPosition++;//Add one to enemiesInPosition
          else
            return;//Check the next enemy
        }
        if(enemiesInPosition == enemyCount)//If the numbers of enemies in position is the same as the enemy count
        {
          allEnemiesInPosition = true;//Say that all enemies are in position //<>//
        }
     }
     //If the enemy is leaving the screen
    if(enemyLeavingScreen)
    {
      //Remove the enemy's shot and move the enemy down the screen
      laserOnScreen = false;
      enemyyOffset += 5;
      
      if(enemyxPos < p.playerX)//Check to see if the enemy is to the left
        enemyxOffset += 3.5;//Track player horizontally
      else if(enemyxPos > p.playerX)//Check to see if the enemy is to the right
        enemyxOffset -= 3.5;//Track player horizontally
    }
  }
 
  void drawLasers()
  {
    if(enemyLaserYpos > height)//If the laser is off the screen, say that there is no laser on the screen
      laserOnScreen = false;
      
    if(laserOnScreen)//If the laser is on screen
    {
      imageMode(CENTER);
      image(laser,enemyxPos+enemyxOffset,enemyLaserYpos);//Draws laser
    }
    else if(!laserOnScreen && shotTimer <= millis())//If there is no laser on screen and the enemy's shot timer is at it's position
    {
      enemyLaserYpos = (enemyyPos + enemyyOffset);//Sets the laser's y position to the enemy's y position
      shotTimer = millis() + random(300, 2000);//Resets the shot timer for the enemy
      laserOnScreen = true;//Says that there is a laser on screen
    }
  }
  
 
  //Moves the laser down the screen
  void moveLasers()
  {
    imageMode(CENTER);
    enemyLaserYpos += laserySpeed;
  }
 
 
  void enemyHit()
  {
    //If the player shot is within the radius of the enemy, if the player shot is on screen and if the enemy is not leaving the screen
    if(dist((enemyxPos + enemyxOffset), (enemyyPos + enemyyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && !enemyLeavingScreen)
    {
      p.shotOnScreen = false;//Removes the player's shot from the screen
      h.score = h.score + 50;//Adds 50 to the player's score
      enemyLeavingScreen = true;//Makes the enemy leave the screen
      enemiesOnScreen--;
      if(h.score >= h.highScore)
        h.highScore = h.score;
    }
    //If enemy player gets shot while leaving the screen
    else if(dist((enemyxPos+enemyxOffset), (enemyyPos + enemyyOffset), p.shotX, p.shotY) <= (enemySize/2) && p.shotOnScreen && enemyLeavingScreen)
      p.shotOnScreen = false;//Remove the player shot from the screen
  }
 
}
