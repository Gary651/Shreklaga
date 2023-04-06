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
boolean playerHasLives;
boolean musicCurrentlyPlaying;
public Enemies [] e = new Enemies[50];
void setup()
{
  ac = new AudioContext();
  ac2 = new AudioContext();
  
  fullScreen();
  s = new Stars();
  s = new Stars();
  p = new Player();
  h = new HUD();
  for(int i = 0; i < 50; i++)
  {
    e[i] = new Enemies((i+1)*-60);
  }
  playerHasLives = true;
  musicCurrentlyPlaying = false;
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
    for(int i = 0; i < 50; i++)
    {
      e[i].drawEnemies();
      e[i].moveEnemy();
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
  else
    h.gameOverScreen();
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
  {
    ac.stop();
    ac2.stop();
  }
  if(key == 't')
    ac.start();
  if(key == 's')
    h.saveHighScore();
    if(key == '`')
  {
    //ac.stop();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
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
  /*
  if(key == '2')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("allStar.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
    
  } 
  (key == '3')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
  if(key == '4')
  {
    ac = new AudioContext();
    Sample sample1 = SampleManager.sample(dataPath("background.mp3"));
    music = new GranularSamplePlayer(ac, sample1);
    Gain g = new Gain(ac, 2, 1.0);
    g.addInput(music);
    ac.out.addInput(g);
    ac.start();
  } 
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
  if(key == 'a' || key == 'd')
    p.addThrust(key,false);
}
