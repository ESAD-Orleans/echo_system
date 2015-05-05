
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

Minim minim;
AudioInput in;
PImage meme;

void setup() {
  meme = loadImage("cat.jpg");
  size(meme.width, meme.height);
  minim = new Minim(this);
  in = minim.getLineIn(Minim.STEREO,meme.width);
 
}

void draw() {
  image(meme, 0, 0);
 
 noFill();
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    
    float hauteurDeSon = in.mix.get(i);
    float randomAngle = random(-1,1);
    int x = width/2 + round(cos(randomAngle*PI)*hauteurDeSon*height/2);
    int y = height/2 + round(sin(randomAngle*PI)*hauteurDeSon*height/2);
    float hauteurAmortie = -1/(abs(hauteurDeSon)+1)+1;
    int r = round(random(100));
    int offsetX = floor(hauteurDeSon*100*random(-1,1));
    int offsetY = floor(hauteurDeSon*100*random(-1,1));
    
    x += random(-100,100);
    y += random(-100,100);
   
    if(abs(hauteurDeSon)>.99){
      hauteurDeSon+=random(hauteurDeSon/abs(hauteurDeSon));
    }
    
    
    copy (meme, x-r/2, y-r/2, r, r, offsetX+x-r/2, offsetY+y-r/2, r, r);
    //line(width/2,height/2,x,y);
    rectMode(CENTER);
    //rect(x,y,r,r);

  }
  
  
}

void stop() {
  in.close();
  minim.stop();
  super.stop();
}

