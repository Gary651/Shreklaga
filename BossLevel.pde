class BossLevel
{
  public float bossxPos = 0.0;
  public float bossyPos = 0.0;
  public float bossLaserYpos;
  public float bossSize = 700;
  public boolean laserOnScreen = false;
  PImage dragon;
  PImage bossLaser;
  PImage fireballShot;
  float bossLaserSpeed = 5;
  float bossLaserWidth = 35;
  float bossLaserHeight = 50;
  float bossShotTimer = 0;
  int destination = (int)(height/1.5);
  int bossxOffset = 0;
  int bossyOffset = 0;

  public BossLevel()
  {
    imageMode(CENTER);
    dragon = loadImage("dragonBoss.png");
    bossxPos = (width/2) + bossyOffset;
  }
}
