// galaga type game
//makes it to where you can play the sounds
import beads.*;
import java.util.Arrays; 
AudioContext ac;
GranularSamplePlayer music;
Stars s;
Player p;
HUD h;
Enemies [] e = new Enemies[15];
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

}

void draw()
{
  background(0);
  p.drawShot();
  p.movePlayer();
  p.drawPlayer();
  for(int i = 0; i < 15; i++)
  {
    e[i].drawEnemies();
    e[i].moveLasers();
    e[i].drawLasers();
  }
  if(e[1].enemyLaserYpos == p.playerY-p.playerSize && h.livesLost == 3)
  {
    fill(#FA3535);
    text("GAME OVER!", width/2, height/2);
    textSize(100);
  }
  if(p.shotY == e[1].enemyyPos && p.shotX == e[1].enemyxPos)
  {
    
  }
  s.drawStars();
  p.drawPlayer();
  h.score();
  h.highScore();
  h.level();
  h.lives();
  s.drawStars();
  

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
