class Player
{
  /*Tracking variables
    Some variables are set to public in order to work with collision*/
  public int playerSize;
  public float xSpeed;
  public float playerX;
  public float playerY;
  public boolean shotOnScreen;
  public boolean goingOffscreen;
  PImage shrek;
  PImage shrekShot;
  PImage gingy;
  PImage gingyShot;
  float shotX;
  float shotY;
  int playerOffset;
  boolean movingLeft;
  boolean movingRight;
  boolean playingAsShrek;
  boolean playingAsGingy;

  public Player()
  {
    imageMode(CENTER);//Centers all images
    
    //Player info
    playerSize = 60;
    xSpeed = 0;
    playerX = width/2;
    playerY = height - 50;
    playerOffset = 0;
    goingOffscreen = false;
    
    //Loads and appropriately sizes player
    shrek = loadImage("shrek.png");
    shrek.resize(playerSize,0);
    gingy = loadImage("gingerbreadMan.png");
    gingy.resize(playerSize,0);
    
    //Loads and appropriately sizes the player's shot
    shrekShot = loadImage("stankOnion.png");
    shrekShot.resize(35,0);
    gingyShot = loadImage("gumDrop.png");
    gingyShot.resize(35,0);
    
    //Sets the shot's x and y positions to zero so that they can be tampered with later
    shotX = 0;
    shotY = 0;
    
    //Sets all moving/shot booleans to false so that they can track later in the code
    movingLeft = false;
    movingRight = false;
    shotOnScreen = false;
    
    /*Sets default character to Shrek
      Sets "playingAsGinger" to false to allow the user to switch characters*/
    playingAsShrek = true;
    playingAsGingy = false;
  }

  void drawPlayer()
  {
    if(playingAsShrek)//If the user has chosen to play as Shrek
      image(shrek,playerX,(playerY+playerOffset));//Draws Shrek
    if(playingAsGingy)//If the user has chosen to play as Gingerbread Man
      image(gingy,playerX,(playerY+playerOffset));//Draws Gingerbread Man
  }

 
  public void addThrust(char pressedKey, boolean active)
  {
    if(pressedKey == 'a' && active)//Sets "movingLeft" to true if the player is pressing 'a'
      movingLeft = true;
    if(pressedKey == 'd' && active)//Sets "movingRight" to true if the player is pressing 'd'
      movingRight = true;
    if(pressedKey == 'a' && !active)//Sets "movingLeft" to false if the player not is pressing 'a'
      movingLeft = false;
    if(pressedKey == 'd' && !active)//Sets "movingRight" to false if the player not is pressing 'd'
      movingRight = false;
  }
 
  public void movePlayer()
  {
    if(!goingOffscreen)
    {
      //If the player is moving left, decrease the speed(xSpeed) by .5
      if(movingLeft)
         xSpeed -= .5;
      //If the player is moving right, increase the speed(xSpeed) by .5
      if(movingRight)
         xSpeed += .5;
     
       //Makes it to where the player cannot move out of bounds
       if(playerX >= width - (playerSize/2))
         xSpeed = min(0,-xSpeed);
       if(playerX <= playerSize/2)
         xSpeed = max(0,-xSpeed);
     
       xSpeed *= 0.95;//Creates friction
       
       playerX += xSpeed;//Changes the xPos by the xSpeed
    }
    
    if(goingOffscreen)
      playerOffset += 3;
    else if(playerOffset > 0)
     playerOffset *= 0.9;
    
    if(playerOffset >= 150)
      goingOffscreen = false;
  }
 
  public void drawShot()
  {
    if(shotOnScreen && playingAsShrek)//If the shot is on the screen and the player has chosen to play as Shrek
      image(shrekShot, shotX, shotY);//Draws Shrek's shot
    if(shotOnScreen && playingAsGingy)//If the shot is on the screen and the player has chosen to play as Gingerbread Man
      image(gingyShot,shotX,shotY);//Draws Gingy's shot
    
    shotY -= 2.5;//Makes the shot move
    shotY *= 0.95;//Creates shot friction
    if(shotY < 0)//If the shot is not on the screen, set shotOnScreen to false and allow player to shoot
      shotOnScreen = false;
  }
 
  public void shoot()
  {
    if(!shotOnScreen)
    {
      //Sets shot info
      shotOnScreen = true;
      shotX = playerX;
      shotY = height-playerSize;
      //Music info
      ac = new AudioContext();
      Sample sample = SampleManager.sample(dataPath("laser.mp3"));
      music = new GranularSamplePlayer(ac, sample);
      Gain g = new Gain(ac, 2, 1.0);
      g.addInput(music);
      ac.out.addInput(g);
      ac.start();
    }
  }
  
  public void switchPlayer()
  {
    if(playingAsShrek)//Switches player from Shrek to Gingerbread Man
     {
       playingAsShrek = false;
       playingAsGingy = true;
     }
     else if(playingAsGingy)//Switches player from Gingerbread Man to Shrek
     {
       playingAsGingy = false;
       playingAsShrek = true;
     }
  }
  
  public void playerHit()
  {
    for(int i = 0; i < e.length; i++)
    {
      //If the enemy shot is within the radius of the player and the enemy's laser is on screen and the player is on the screen
      if(playerOffset == 0 && dist(playerX, playerY, e[i].enemyxPos, e[i].enemyLaserYpos) <= (playerSize/2) && e[i].laserOnScreen)
      {
        h.playerLives--;//Remove one of the player's lives
        shotOnScreen = false;//Takes player's shot off of screen
        e[i].laserOnScreen = false;//Remove the enemy's shot from the screen
        goingOffscreen = true;//Says that the player is going offscreen
        return;//Ends void method
      }
      //If the enemy directly hits the player and the player is not going offscreen
      else if(playerOffset == 0 && dist(playerX, playerY+playerOffset, e[i].enemyxPos, e[i].enemyyPos-e[i].enemyOffset) <= (playerSize/2))
      {
        h.playerLives--;//Remove one of the player's lives
        shotOnScreen = false;//Takes player's shot off of screen
        e[i].laserOnScreen = false;//Remove the enemy's shot from the screen
        goingOffscreen = true;//Says that the player is going offscreen
        return;//Ends void method
      }
    }
  }
}
