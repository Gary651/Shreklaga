class BossLevel
{
  /*Tracking variables
    Some are public so they can be used later*/
  public float dragonxPos;
  public float dragonyPos;
  public float bossLaserYpos;
  public int bossSize;
  public boolean bossLaserOnScreen = false;
  PImage dragon;
  PImage bossLaser;
  PImage fireballShot;
  float dragonxSpeed = 0;
  float bossLaserSpeed = 5;
  float bossLaserWidth = 70;
  float bossShotTimer = 0;
  int bossDestination; 
  int dragonyOffset = 0;

  public BossLevel()
  {
    /*Loads the boss and sets the initial boss size
      Resized down below so the boss size will reset whenever the boss is hit*/
    dragon = loadImage("dragonBoss.png");
    bossSize = 700;
    
    dragonxPos = (width/2);//Sets the initial dragon x position to the middle of the screen, will change later
    dragonyPos = -100;//Sets the initial dragon y position off the screen, will change later
    bossDestination = int(height/2.5);//Sets the boss' destination to about the middle of the screen so the boss can fully come on screen
    bossShotTimer = millis() + random(300,2000) + 6000;//Sets the boss timer to make it to where the boss won't shoot until it's on screen
    bossLaserSpeed = 5;//Sets the boss laser speed to five
    
    //Creates and resizes the boss laser
    bossLaser = loadImage("fireball.png");
    bossLaser.resize(int(bossLaserWidth), 0);
    
    //Switch statement to choose which direction the boss moves
    switch(int(random(1,3)))
    {
      case 1://If the int returned is one, make the boss move right
        dragonxSpeed = 5;
        break;
      case 2://If the int returned is two, make the boss move left
        dragonxSpeed = -5;
        break;
    }
  }
  
  public void drawBoss()
  {
    //Centers and draws the boss
    imageMode(CENTER);
    image(dragon,dragonxPos,(int)(dragonyPos + dragonyOffset));
    dragon.resize(max(1,bossSize),0);//Makes it to where the boss size will change whenever it gets hit
  }
  
  public void moveBoss()
  {
    if(bossSize <= 50)//If the boss size is fifty or less
    {
      dragonxSpeed = 0;//Stop the boss moving left or right
      
      //Remove the player and boss shots
      p.shotOnScreen = false;
      bossLaserOnScreen = false;
      
      //Move the boss off screen
      dragonyOffset -= 5;
    }
    else if((dragonyPos+dragonyOffset) < bossDestination)//If the boss is not at it's destination
      dragonyOffset += 5;//Move the boss down the screen
    else if((dragonyPos+dragonyOffset) > bossDestination && bossSize > 50)//If the boss is past it's position
    {
      //Stop the boss
      dragonyOffset = 0;
      dragonyPos = bossDestination;
      
      bossInPosition = true;//Say that boss is in position
    }
    if(bossInPosition)//If the boss is in position
    {
      //If the boss collides with a wall, move it the opposite direction
      if(dragonxPos <= bossSize/2)
         dragonxSpeed *= -1;
      else if(dragonxPos >= width - (bossSize/2))
         dragonxSpeed *= -1;
         
      dragonxPos += dragonxSpeed;//Add the x speed to the dragon's x position to allow the boss to move left/right
    }
  }
  
  public void drawBossShot()
  {
    if(bossLaserYpos > height)//If the boss laser is off the screen, say the boss laser is off the screen
        bossLaserOnScreen = false;
        
    if(bossLaserOnScreen)//If the boss laser is on screen
    {
      imageMode(CENTER);
      image(bossLaser,dragonxPos,bossLaserYpos);//Draws the boss laser
    }
    
    if(!bossLaserOnScreen && bossShotTimer <= millis())//If the shot timer has run out and the boss' laser is not on screen
    {
      bossShotTimer = millis() + random(300,2000);//Reset the boss timer
      bossLaserYpos = dragonyPos + dragonyOffset;//Reset the boss' laser y position
      bossLaserOnScreen = true;//Say that the boss' laser is on screen
    }
  }
  
  public void moveBossShot()
  {
    //Moves the shot down the screen
    imageMode(CENTER);
    bossLaserYpos += bossLaserSpeed;
  }

  public void bossHit()
  {
    if(dist(p.shotX, p.shotY, dragonxPos, dragonyPos) <= bossSize/2 && p.shotOnScreen)//If the player's shot is on the screen and it hits the boss
    {
      p.shotOnScreen = false;//Remove the player's shot
      bossSize -= 10;//Reduce the boss' size by 10
    }
  }
}
