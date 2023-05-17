class BossLevel
{
  public float dragonxPos;
  public float dragonyPos;
  public float bossLaserYpos;
  public int bossSize;
  public boolean laserOnScreen = false;
  PImage dragon;
  PImage bossLaser;
  PImage fireballShot;
  float dragonxSpeed = 0;
  float bossLaserSpeed = 5;
  float bossLaserWidth = 35;
  float bossLaserHeight = 50;
  float bossShotTimer = 0;
  int bossDestination; 
  int dragonyOffset = 0;

  public BossLevel()
  {
    dragon = loadImage("dragonBoss.png");
    bossSize = 700;
    dragonxPos = (width/2);
    dragonyPos = -100;
    bossDestination = int(height/2.5);
    bossShotTimer = millis() + random(300,2000);
  }
  
  public void drawBoss()
  {
    imageMode(CENTER);
    image(dragon,dragonxPos,(int)(dragonyPos + dragonyOffset));
    dragon.resize(bossSize,0);
  }
  
  public void moveBoss()
  {
    if((dragonyPos+dragonyOffset) < bossDestination)
      dragonyOffset += 5;
    if((dragonyPos+dragonyOffset) > bossDestination)
    {
      dragonyOffset = 0;
      dragonyPos = bossDestination;
      bossInPosition = true;
    }
    if(bossInPosition)
    {
      if(dragonxPos <= bossSize/2)
         dragonxSpeed *= -1;
      else if(dragonxPos >= width - (bossSize/2))
         dragonxSpeed *= -1;
      dragonxPos += dragonxSpeed;
    }
    if(bossSize <= 50)
    {
      dragonxSpeed = 0;
      p.shotOnScreen = false;
      dragonyOffset -= 5;
    }
  }

  public void bossHit()
  {
    if(dist(p.shotX, p.shotY, dragonxPos, dragonyPos) <= bossSize/2)
    {
      bossSize -= 25;
      p.shotOnScreen = false;
      bossShotTimer = millis() + random(300,2000);
    }
  }
}
