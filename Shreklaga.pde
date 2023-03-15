// galaga type game
//makes it to where you can play the sounds
import beads.*;
import java.util.Arrays; 
AudioContext ac;
GranularSamplePlayer music;
Stars s;
Player p;
HUD h;
boolean playerHasLives;
public Enemies [] e = new Enemies[15];
void setup()
{
  //plays sounds
  ac = new AudioContext();
  Sample sample = SampleManager.sample(dataPath("background.mp3"));
  music = new GranularSamplePlayer(ac, sample);
  music.setLoopType(SamplePlayer.LoopType.LOOP_FORWARDS);
  Gain g = new Gain(ac, 2, 1.0);
  g.addInput(music);
  ac.out.addInput(g);
  ac.start();
  
  fullScreen();
  s = new Stars();
  s = new Stars();
  p = new Player();
  h = new HUD();
  //e = new Enemies();
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
    p.drawShot();
    p.movePlayer();
    p.drawPlayer();
    for(int i = 0; i < 15; i++)
    {
      e[i].drawEnemies();
      e[i].moveLasers();
      e[i].drawLasers();
    }
    p.playerHit();
    h.score();
    h.highScore();
    h.level();
    h.lives();
  }
  else
    h.gameOverScreen();
}

void keyPressed()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key, true);
  if(key == 'w')
    p.shoot();
  if(key == 'g')
    p.switchPlayer();
}

void keyReleased()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key,false);

}
