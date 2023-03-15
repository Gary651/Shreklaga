class Player
{
  /*Tracking variables
    Some variables are set to public in order to work with collision*/
  public int playerSize;
  public float xSpeed;
  public float playerX;
  public float playerY;
  public boolean shotOnScreen;
  PImage shrek;
  PImage shrekShot;
  PImage gingy;
  PImage gingyShot;
  float shotX;
  float shotY;
  boolean movingLeft;
  boolean movingRight;
  boolean playingAsShrek;
  boolean playingAsGingy;

  public Player()
  {
    imageMode(CENTER);//Centers all images
    
    //Player info
    playerSize = 50;
    xSpeed = 0;
    playerX = width/2;
    playerY = height - 50;
    
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
      image(shrek,playerX,playerY);//Draws Shrek
    if(playingAsGingy)//If the user has chosen to play as Gingerbread Man
      image(gingy,playerX,playerY);//Draws Gingerbread Man
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
 
  public void drawShot()
  {
    if(shotOnScreen && playingAsShrek)//If the shot is on the screen and the player has chosen to play as Shrek
      image(shrekShot, shotX, shotY);//Draws Shrek's shot
    if(shotOnScreen && playingAsGingy)//If the shot is on the screen and the player has chosen to play as Gingerbread Man
      image(gingyShot,shotX,shotY);//Draws Gingy's shot
    
    shotY -= 5;//Makes the shot move
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
      if( dist(playerX, playerY, e[i].enemyxPos, e[i].enemyLaserYpos) <= 25)
      {
        h.playerLives--;
        e[i].enemyLaserYpos = e[i].enemyyPos;
      }
    }
  }
}
