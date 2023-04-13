// galaga type game
//makes it to where you can play the sounds
import beads.*;
import java.util.Arrays; 
AudioContext ac;
GranularSamplePlayer music;
Stars s;
Player p;
HUD h;
<<<<<<< HEAD
public int enemyCount=60;
int joe;
int spawnCount = 0;
=======
>>>>>>> 35fe1b0f811c95e3beeb39bf560342ce16e10fa7
boolean playerHasLives;
public Enemies [] e = new Enemies[15];
void setup()
{
  //plays sounds
  ac = new AudioContext();
  Sample sample = SampleManager.sample(dataPath("allStar.mp3"));
  music = new GranularSamplePlayer(ac, sample);
  //Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
  //music = new GranularSamplePlayer(ac, sample1);
  Gain g = new Gain(ac, 2, 1.0);
  g.addInput(music);
  ac.out.addInput(g);
  ac.start();
  
  fullScreen();
  s = new Stars();
  s = new Stars();
  p = new Player();
  h = new HUD();
  for(int i = 0; i < 15; i++)
  {
    e[i] = new Enemies();
  }
  playerHasLives = true;
}

void draw()
{
  if(h.playerLives <= 0)
    playerHasLives = false;
  if(playerHasLives)
  {
    background(0);
    s.drawStars();
    h.loadHighScore();
    p.drawShot();
    p.movePlayer();
    p.drawPlayer();
    for(int i = 0; i < 15; i++)
    {
      e[i].drawEnemies();
      e[i].moveLasers();
      e[i].drawLasers();
      e[i].enemyHit();//Checks to see if enemy was hit
    }
    p.playerHit();//Checks to see if player was hit
    h.score();//Displays score
    h.highScore();//Displays the highest score
    h.level();//Displays the level
    h.lives();//Displays how many lives the player has
  }
<<<<<<< HEAD
  else//If the player is out of lives
    h.gameOverScreen();//Draw the game over screen
    
}

void TEST_METHOD()
{
  for(int i = 0; i < e.length; i++)
  {
    if( e[i].enemyHasReachedDestination )
      fill(0,200,0);
    else
      fill(200,0,0);
    
    ellipse(i*10,height/2,8,8);
  }
}

void spawnEnemies()
{
  if( millis()-1000 > spawnCount*1000 )//Draws 20 enemies per line until spawnCount reaches enemyCount
  {
    e[spawnCount] = new Enemies(width-((width/40)+(width/20)*(spawnCount%20)), 90+90*(spawnCount/20));
    spawnCount++;
  }
}

void checkEnemyPositions()
{
  joe = 0;
  for(int i = 0; i < e.length; i++)
  {
    if(e[i].enemyHasReachedDestination)
      joe++;
  }
  if(joe == e.length)
      allEnemiesInPosition = true;
=======
  else
    h.gameOverScreen();
    h.saveHighScore();
>>>>>>> 35fe1b0f811c95e3beeb39bf560342ce16e10fa7
}

void keyPressed()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key, true);
  if(key == 'w' && !p.goingOffscreen)
    p.shoot();
  if(key == 'g')
    p.switchPlayer();
  if(key == 'r')
    ac.stop();
  if(key == 't')
    ac.start();    
  if(key == 'l')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
}

void keyReleased()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key,false);
}
