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
BossLevel b;
public int enemyCount = 60;
public int enemiesOnScreen = enemyCount;
int spawnCount = 0;
boolean playerHasLives;
boolean gameStarted = false;
boolean newGameStarted = false;
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
  b = new BossLevel();
  playerHasLives = true;
  musicCurrentlyPlaying = false;
  for(int i = 0; i < enemyCount; i++)
  {
    e[i] = new Enemies(-1,width+500);//Sets an x and a y for the specific enemy
  }
}

void draw()
{
  if(millis() > 44000 && !gameStarted)//If the player has been on the title screen for over 44 seconds
  {
    //Start the game at level one
    gameStarted = true;
    h.level = 1;
  }
  
  if(h.level < 4)
    spawnEnemies(enemiesOnScreen);//Spawns however many enemies are set to spawn
  
  if(h.playerLives <= 0)//If the player has zero lives, say that the player has no lives
    playerHasLives = false;
  background(0);//Makes background black for the title screen
  s.drawStars();//Draws the stars for the title screen
  h.titleScreen();//Draws the title screen
  
  //If the player has started the game or has started a new game, if they have lives and if they're on level one, two or three
  if(gameStarted && playerHasLives || newGameStarted && playerHasLives)
  {
    if(h.level <= 3)
    {
      //Makes the background black for the game and draws stars for the game
      background(0);
      s.drawStars();
      
      //Draws the player shot, draws the player and allows the player to move
      p.drawShot();
      p.movePlayer();
      p.drawPlayer();
      p.playerHit();
      for(int i = 0; i < enemyCount; i++)
      {
        e[i].drawEnemies();//Draws each individual enemy
        e[i].moveEnemy();//Moves the enemy if they get shot
        e[i].enemyHit();//Checks to see if enemy was hit
        if(allEnemiesInPosition)
        {
          //If all enemies are in position, draw and move the enemy's laser
          e[i].drawLasers();
          e[i].moveLasers();
        }
      }
      p.playerHit();//Checks to see if player was hit
      h.score();//Displays score
      h.highScore();//Displays the highest score
      h.level();//Displays the level
      h.lives();//Displays how many lives the player has
      }
      else if(h.level == 4)
      {
        b.drawBoss();
        b.moveBoss();
      }
    }
    else if(!playerHasLives)//If the player is out of lives
    {
      h.gameOverScreen();//Draw the game over screen
      h.saveHighScore();//Save the high score
      
      //Takes player back to title screen
      gameStarted = false;
      newGameStarted = false;
    }
  text("Millis: " + millis(), 50, height/2.5);
  text("Shot timer: " + e[0].shotTimer, 50, height/1.5);
}

void spawnEnemies(int enemiesAlive)
{
  if(h.level == 1)//If the player is on the first level
  {
    if( millis()-1000 > spawnCount*1000 && spawnCount < enemyCount)//Draws 20 enemies per line until spawnCount reaches enemyCount(60)
    {
      e[spawnCount] = new Enemies(width-((width/40)+(width/20)*(spawnCount%20)), 90+90*(spawnCount/20));
      spawnCount++;
    }
    if(enemiesAlive == 0)//If the player kills all the enemies
    {
      /*Say that not all enemies are in position, sets enemyCount to the next level's enemy count
        spawnCount is reset to allow tracking for the next level*/
      allEnemiesInPosition = false;
      spawnCount = 0;
      enemyCount = 80;
      enemiesOnScreen = enemyCount;
      e = new Enemies[enemyCount];//Makes a new array of enemies for the next level
      for(int i = 0; i < enemyCount; i++)
      {
        e[i] = new Enemies(-1,width+500);//Sets an x and a y for the specific enemy for the next level
      }
      h.level++;//Progress to the next level
    }
  }
  else if(h.level == 2)//If the player is on the second level
  {
    if( millis()-1000 > spawnCount*1000 && spawnCount < enemyCount)//Draws 20 enemies per line until spawnCount reaches enemyCount(80)
    {
      e[spawnCount] = new Enemies(width-((width/40)+(width/20)*(spawnCount%20)), 90+90*(spawnCount/20));
      spawnCount++;
    }
    if(enemiesAlive == 0)//If the player kills all the enemies
    {
      /*Say that not all enemies are in position, sets enemyCount to the next level's enemy count
        spawnCount is reset to allow tracking for the next level*/
      allEnemiesInPosition = false;
      spawnCount = 0;
      enemyCount = 100;
      enemiesOnScreen = enemyCount;
      e = new Enemies[enemyCount];//Makes a new array of enemies for the next level
      for(int i = 0; i < enemyCount; i++)
      {
        e[i] = new Enemies(-1,width+500);//Sets an x and a y for the specific enemy for the next level
      }
      h.level++;//Progress to the next level
    }
  }
  else if(h.level == 3)//If the player is on the third level
  {
    if( millis()-1000 > spawnCount*1000 && spawnCount < enemyCount)//Draws 20 enemies per line until spawnCount reaches enemyCount(100)
    {
      e[spawnCount] = new Enemies(width-((width/40)+(width/20)*(spawnCount%20)), 90+90*(spawnCount/20));
      spawnCount++;
    }
    if(enemiesAlive == 0)
    {
      spawnCount = 0;
      enemyCount = 0;
      h.level++;
    }
  }
}

void mousePressed()
{
  //If you click the start game button it resumes the previous game
  if(mouseX >= 715 && mouseX <= 930 && mouseY >= 500 && mouseY <= 550)
  {
    h.level = 1;
    h.loadHighScore();
    gameStarted = true;
  }
  
  //If you click the new game button it resets the high score back to zero
  if(mouseX >= 715 && mouseX <= 930 && mouseY >= 600 && mouseY <= 650)
  {
    h.level = 1;
    h.loadHighScore();
    newGameStarted = true;
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
    
  if(key == 'n')
    
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
/*    if(key == '`')
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
