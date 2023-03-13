class Player
{
  //Player info
  int playerSize = 50;
  float xSpeed = 0;
  float xPos = width/2;
 
  //Player shot info
  float shotX = 0;
  float shotY = 0;
 
  //Tracking booleans
  boolean movingLeft = false;
  boolean movingRight = false;
  boolean shotOnScreen = false;
  
  //Player image
  PImage player;
  
  //Shot image
  PImage shot;

  void drawPlayer()
  {
    fill(0,255,0);//Makes the player green
    player = loadImage("shrek.png");
    player.resize(playerSize,0);
    image(player,xPos,height-playerSize);//Draws the player
    imageMode(CENTER);
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
      fill(255,255,255);//Shot color
      ellipse(shotX, shotY, 25, 25);//Draws shot
    }
    shotY -= 5;//Makes the shot move
    shotY *= 0.95;//Creates shot friction
    if(shotY < 0)
      shotOnScreen = false;
  }
 
  public void shoot()
  {
    if(!shotOnScreen)
    {
      shotOnScreen = true;
      shotX = xPos;
      shotY = height-playerSize;
    }
  }
}
