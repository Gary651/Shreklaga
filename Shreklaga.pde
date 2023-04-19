// galaga type game
//makes it to where you can play the sounds
import beads.*;
import java.util.Arrays; 
AudioContext ac;
AudioContext ac2;
AudioContext ac3;
AudioContext ac4;
AudioContext ac5;
AudioContext ac6;
AudioContext ac7;
AudioContext ac8;
AudioContext ac9;
AudioContext ac10;
AudioContext ac11;
AudioContext ac12;
GranularSamplePlayer music;
Stars s;
Player p;
HUD h;
public int enemyCount=60;
int spawnCount = 0;
boolean playerHasLives;
boolean musicCurrentlyPlaying;
boolean allEnemiesInPosition = false;
public Enemies [] e = new Enemies[enemyCount];
void setup()
{
  ac = new AudioContext();
  ac2 = new AudioContext();
  ac3 = new AudioContext();
  ac4 = new AudioContext();
  ac5 = new AudioContext();
  
  
  fullScreen();
  s = new Stars();
  s = new Stars();
  p = new Player();
  h = new HUD();
  for(int i = 0; i < enemyCount; i++)
  {
    e[i] = new Enemies(-1,width+500);//Sets an x and a y for the specific enemy
  }
  playerHasLives = true;
  musicCurrentlyPlaying = false;
}

void draw()
{
  if(spawnCount < enemyCount)
    spawnEnemies();//Spawns however many enemies are set to spawn
    
  if(h.playerLives <= 0)//If the player has zero lives, say that the player has no lives
    playerHasLives = false;
  if(playerHasLives)//If the player has lives
  {
    background(0);
    s.drawStars();
    h.loadHighScore();
    p.drawShot();
    p.movePlayer();
    p.drawPlayer();
    for(int i = 0; i < enemyCount; i++)
    {
      e[i].drawEnemies();
      e[i].moveEnemy();
      if(allEnemiesInPosition)
      {
        e[i].drawLasers();
        e[i].moveLasers();
      }
      e[i].enemyHit();//Checks to see if enemy was hit
    }
    p.playerHit();//Checks to see if player was hit
    h.score();//Displays score
    h.highScore();//Displays the highest score
    h.level();//Displays the level
    h.lives();//Displays how many lives the player has
  }
  else//If the player is out of lives
    h.gameOverScreen();//Draw the game over screen
}

void spawnEnemies()
{
  if( millis()-1000 > spawnCount*1000 )//Draws 20 enemies per line until spawnCount reaches enemyCount
  {
    e[spawnCount] = new Enemies(width-((width/40)+(width/20)*(spawnCount%20)), 90+90*(spawnCount/20));
    spawnCount++;
  }
}

void keyPressed()
{
  if(key == 'a' || key == 'd')//If the key is 'a' or 'd', add a thrust to the player
    p.addThrust(key, true);
  
  //If the player presses 'w', the player is coming on screen or in it's position and all enemies are in position
  if(key == 'w' && !p.goingOffscreen && allEnemiesInPosition)
    p.shoot();//Let the enemy shoot
    
  if(key == 'g')//If the player presses 'g'
    p.switchPlayer();//Switch the character the player's playing as
   if(key == 'r')
   {
    ac.stop();
    ac2.stop();
    ac3.stop();
    ac4.stop();
    ac5.stop();
   }
  if(key == 't')
  {
    ac.start();
    ac2.start();
    ac3.start();
    ac4.start();
    ac5.start();
  }
  if(key == 's')
    h.saveHighScore();
    if(key == '`')
  {
    ac.start();
    Sample sample = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
  }  
  if(key == '1')
  {
    //ac.stop();
    Sample sample = SampleManager.sample(dataPath("allStar.mp3"));
    music = new GranularSamplePlayer(ac2, sample);
    Gain g = new Gain(ac2, 2, 1.0);
    g.addInput(music);
    ac2.out.addInput(g);
    ac2.start();
  } 
  if(key == '2')
  {
    ac3 = new AudioContext();
    Sample sample = SampleManager.sample(dataPath("TimeLapse.mp3"));
    music = new GranularSamplePlayer(ac3, sample);
    Gain g = new Gain(ac3, 2, 1.0);
    g.addInput(music);
    ac3.out.addInput(g);
    ac3.start();
  } 
  if(key == '3')
  {
    ac4 = new AudioContext();
    Sample sample = SampleManager.sample(dataPath("time.mp3"));
    music = new GranularSamplePlayer(ac4, sample);
    Gain g = new Gain(ac4, 2, 1.0);
    g.addInput(music);
    ac4.out.addInput(g);
    ac4.start();
  } 
  
  if(key == '4')
  {
    ac5 = new AudioContext();
    Sample sample = SampleManager.sample(dataPath("Limitless.mp3"));
    music = new GranularSamplePlayer(ac5, sample);
    Gain g = new Gain(ac5, 2, 1.0);
    g.addInput(music);
    ac5.out.addInput(g);
    ac5.start();
  } 
  /*
  if(key == '5')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '6')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '7')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '8')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '9')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '0')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '-')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '=')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  }
  */
  
}

void keyReleased()
{
  if(key == 'a' || key == 'd')//If the player releases 'a' or 'd', remove the thruster
    p.addThrust(key,false);
}
