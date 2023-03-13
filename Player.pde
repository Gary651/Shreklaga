class Player
{
  //Tracking variables
  int playerSize;
  float xSpeed;
  float xPos;
  float yPos;
  PImage shrek;
  PImage playerShot;
  float shotX;
  float shotY;
  boolean movingLeft;
  boolean movingRight;
  boolean shotOnScreen;

  public Player()
  {
    imageMode(CENTER);//Centers all images
    
    //Player info
    playerSize = 50;
    xSpeed = 0;
    xPos = width/2;
    yPos = height - 50;
    
    //Loads and appropriately sizes player
    shrek = loadImage("shrek.png");
    shrek.resize(playerSize,0);
    
    //Loads and appropriately sizes the player's shot
    playerShot = loadImage("stankOnion.png");
    playerShot.resize(35,0);
    
    //Sets the shot's x and y positions to zero so that they can be tampered with later
    shotX = 0;
    shotY = 0;
    
    //Sets all booleans to false so that they can track later in the code
    movingLeft = false;
    movingRight = false;
    shotOnScreen = false;
  }

  void drawPlayer()
  {
    image(shrek,xPos,yPos);//Draws the player
    fill(0,255,0);//Makes the player green
    image(shrek,xPos,yPos);//Draws the player
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
     if(xPos >= width - (playerSize/2))
       xSpeed = min(0,-xSpeed);
     if(xPos <= playerSize/2)
       xSpeed = max(0,-xSpeed);
     
     xSpeed *= 0.95;//Creates friction
       
     xPos += xSpeed;//Changes the xPos by the xSpeed
  }
 
  public void drawShot()
  {
    if(shotOnScreen)//If the shot is on the screen
    {
      image(playerShot,shotX,shotY);
      fill(255,255,255);//Shot color
      image(playerShot, shotX, shotY);//Draws shot
    }
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
      shotX = xPos;
      shotY = height-playerSize;
    }
  }
}
