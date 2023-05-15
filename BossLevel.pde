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
  float bossLaserSpeed = 5;
  float bossLaserWidth = 35;
  float bossLaserHeight = 50;
  float bossShotTimer = 0;
  int bossDestination; 
  int dragonxOffset = 0;
  int dragonyOffset = 0;

  public BossLevel()
  {
    dragon = loadImage("dragonBoss.png");
    bossSize = 700;
    dragonxPos = (width/2) + dragonxOffset;
    dragonyPos = -1000;
    bossDestination = int(height/1.5);
    bossShotTimer = millis() + random(300,2000);
  }
  
  public void drawBoss()
  {
    imageMode(CENTER);
    image(dragon,(int)(dragonxPos + dragonxOffset),(int)(dragonyPos + dragonyOffset));
    dragon.resize(bossSize,0);
  }
  
  public void moveBoss()
  {
    if(dragonyPos < bossDestination)
    {
      dragonyOffset += 5;
    }
    if(bossSize >= 50)
    {
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
