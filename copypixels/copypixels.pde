// minim library
import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

// minim settings
Minim minim;
AudioInput in;

// image source
PImage meme;

// demarage
void setup() {
  // chargement de l'image
  meme = loadImage("cat.jpg");
  // taille de la fenetre en fonction de la taille de l'image source
  size(meme.width, meme.height);
  // initialisation de Minim
  minim = new Minim(this);
  // ouverture du microphone
  in = minim.getLineIn(Minim.STEREO,meme.width);
 
}

// boucle de dessin
void draw() {
  // dessine l'image source
  image(meme, 0, 0);
 
 // desactive le remplissage
 noFill();
 
 // boucle sur le buffer son
 // on analyse l'echantillion audio du micro
  for(int i = 0; i < in.bufferSize() - 1; i++)
  {
    
    // recupere une valeur de l'echantillion (de 0 a 500)
    float hauteurDeSon = in.mix.get(i);
    // un angle de rotation aleatoire, en radians, de -1 a 1
    float randomAngle = random(-1,1);
    // la position du centre du decallage en x et en y
    // a partir du centre
    // on deplace en fonction de la hauteur de son 
    int x = width/2 + round(cos(randomAngle*PI)*hauteurDeSon*height/2);
    int y = height/2 + round(sin(randomAngle*PI)*hauteurDeSon*height/2);
    
    // taille aleatoire du rectangle/carre
    int r = round(random(100));
    // decalage aleatoire et proportionnel de l'image
    int offsetX = floor(hauteurDeSon*100*random(-1,1));
    int offsetY = floor(hauteurDeSon*100*random(-1,1));
    
    // decalage aleatoire du point original
    x += random(-100,100);
    y += random(-100,100);
   
   // si le son sature, on "floute" la saturation
    if(abs(hauteurDeSon)>.99){
      hauteurDeSon+=random(hauteurDeSon/abs(hauteurDeSon));
    }
    
    // afichage de la copie decallee
    copy (meme, x-r/2, y-r/2, r, r, offsetX+x-r/2, offsetY+y-r/2, r, r);
    
    // debug preview
    // rectMode(CENTER);
    // line(width/2,height/2,x,y);
    // rect(x,y,r,r);

  }
  
  
}

void stop() {
  // fermeture du microphone et de l'application
  in.close();
  minim.stop();
  super.stop();
}

