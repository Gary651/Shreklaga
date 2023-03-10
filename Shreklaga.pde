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
  s.drawStars();
  p.movePlayer();
  s.drawStars();
  p.drawPlayer();
  for(int i = 0; i < 15; i++)
  {
  e[i].drawEnemies();
  e[i].drawLasers();
  e[i].moveLasers();
  }
 
  s.drawStars();
  p.drawPlayer();
  h.points();
  h.highScore();
  h.level();
  h.lives();
  
}

void keyPressed()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key, true);
}

void keyReleased()
{
  if(key == 'a' || key == 'd')
    p.addThrust(key,false);
}
