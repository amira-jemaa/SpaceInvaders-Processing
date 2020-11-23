
/*
               Amira Jemaa
     Space Invaders 2d game Project
    _________________________________
   
*/




//////////////////////////////////////////////////////////////
//
// Les déclarations de variables
//
//////////////////////////////////////////////////////////////
final float bulletspeed = 1;
final int gunHeight = 20;

// les coordonnées du canon
float gunX, gunY;
// les coordonnées du missile
float bulletX, bulletY;
// les coordonnées de l'invader
float invaderX, invaderY;
// le vecteur vitesse de l'invader
float invaderVx, invaderVy;

// est-ce qu'un missile a été tiré ?
boolean bullet; 
// est-ce que l'invader a été touché ?
boolean hit;
int hitIndex;
// est-ce que la partie est finie ?
boolean gameOver;
// le score et le meilleur score
int score, best;
// l'horloge
int clock;
// le nombre de ticks d'horloge entre 2 activations de l'invader
int clockPeriod;
// le temps pendant lequel l'invader touché change de couleur
int hitPeriod;

int j, i;
// les images de l'invader et du canon
PImage night;
PImage invader  [][];
PImage gun, invader2, invader3, invader4, invader5, invader6, invader7, invader8, invader9;
// les polices pour le texte
PFont fonte16, fonte32;
int [][] invadersPos = new int [10][6];
int invaderIndex=0;
boolean currentfire;
PImage firework_red [][]; // image du bullet
PImage firework_red0 , firework_red1 , firework_red2 , firework_red3, firework_red4 , firework_red5 , firework6 , firework_red7;
float [] [] bulletcount = new  float [10] [3];
int bullet0 [][];
int BulletIndx =0;

//////////////////////////////////////////////////////////////
//
// La fonction d'initialisation
//
//////////////////////////////////////////////////////////////
void setup() {
  // fixe la taille de la fenêtre
  size(800, 450);

  // change les paramètres de dessin
  strokeWeight(3);
  // charge les images en mémoire
  invader = loadImages1 ("invader", 10);
  firework_red = loadImages ("firework_red", 7);
  night = loadImage("c:\\SpaceInvadersdm3\\data\\night.jpg");
  night = loadImage("night.jpg");
  gun = loadImage("gun.png");

  imageMode(CENTER);

  // charge les polices de caractères en mémoire
  fonte16 = createFont("joystix.ttf", 16);
  fonte32 = createFont("joystix.ttf", 32);
  // initialise les paramètres pour l'affichage du texte
  textAlign(LEFT, CENTER); 
  textFont(fonte16);
  // au départ, pas de meilleur score
  best = 0;
  // 50 appels par seconde de la fonction draw
  frameRate(50);
  // image indice de l'invader
  invaderIndex=0;
  // indice du bullet 
  BulletIndx =0;
  // appelle la fonction d'initialisation du jeu
  newGame();
}

//////////////////////////////////////////////////////////////
//
// La boucle de rendu
//
//////////////////////////////////////////////////////////////
void draw() {
   
  // incrémente l'horloge
  clock = (clock + 1) % clockPeriod;

  // le suivi du missile
  goBullet();
  // l'activation de l'invader
  goInvader();

  // le test de collision missile/invader
  testHit();

  // met à jour l'affichage
  repaint();
  // gestion de l'interaction
  control();
  // charge les images du bullet
}
//////////////////////////////////////////////////////////////
//
// L'initialisation du jeu
//
//////////////////////////////////////////////////////////////
void newGame() {
  // la position du canon au centre de l'écran, en bas
  gunX = width / 2;
  gunY = height - gunHeight;
  // pas de missile tiré
  bullet = false;
  // la partie n'est pas finie
  gameOver = false;
  // position et vitesse de l'invader

  for (int i =0; i<10; ++i) {

    invadersPos [i][0]= (int)random (50, 450);
    invadersPos [i][1]=  (int)random (10, 100);
    invadersPos[i][2] = (int)random (-20, 20);
    invadersPos[i][3] = (int)random (1, 255);
    invadersPos[i][4] = (int)random (1, 255);
    invadersPos[i][5] = (int)random (1, 255);
  } 
  for ( int i=0; i<bulletcount.length; ++i) { 
 
       bulletcount [i][0] =  bulletX;
    bulletcount [i][1] = bulletY;
    bulletcount [i][2] = (int) random (-20, 20);
  }
  // paramètres d'horloge
  clock = 0;
  clockPeriod = 50;
  // score remis à 0
  score = 0;
}
// charge les images de l'invader
PImage [][] loadImages1 ( String name1, int nbImages1) 
{ 
  PImage [][] tab = new PImage[2][nbImages1];
  for (int i=0; i<10; i++) {
    tab [0][i] = loadImage (name1 + i + ".png");
  }
  return tab ;
} 
// charges les images du bullet 
PImage [][] loadImages ( String name, int nbImages) 
{
  PImage [][] tab0 = new PImage [2][nbImages];
  for ( int i=0; i<7; i++) {
    tab0 [0][i] = loadImage ( name + i + ".png");
  }
  return tab0;
}
//////////////////////////////////////////////////////////////
//
// Le tir d'un missile
//
//////////////////////////////////////////////////////////////
void fire() {
  // place le missile au bout du canon
 
     for ( i=0; i<10; ++i) {
    bulletX= gunX;
    bulletY= gunY - 30; 
    // un missile a été tiré
    bullet = true;
 
 
     }
} 

//////////////////////////////////////////////////////////////
//
// L'animation du missile
//
//////////////////////////////////////////////////////////////
void goBullet (  ) {

  for ( int i=0; i<bulletcount.length; i++) {
    
    // si un missile a été tiré
    if (bullet) {
    

      // on le déplace verticalement
      bulletY-= bulletspeed;
  } 

  

    // si il sort en haut, il n'y a plus de missile tiré
    if (bulletY< 0) {
      bullet = false;
       
    }
  }   
}


//////////////////////////////////////////////////////////////
//
// L'animation de l'invader
//
//////////////////////////////////////////////////////////////
void goInvader() 
{

  for ( i=0; i<10; i++) 
  {

    // quand l'horloge revient à 0, on déplace l'invader horizontalement
    if (clock == 0) 
    {

      invadersPos[i][0] += invadersPos[i][2];

      // gère le déplacement de l'invader quand il arrive à droite
     

      if (invadersPos[i][0]> width -50)
      {
        if (clockPeriod > 2) 
        {
         
          clockPeriod -= 2;
        }
        invadersPos[i][2] *= -1;
        invadersPos[i][1] += 25;
      }


      // gère le déplacement de l'invader quand il arrive à droite
      else if (invadersPos[i][0] < 50) 
      {
        if (clockPeriod > 2)
        {
          //for ( i=0; i<10; i++) {
          clockPeriod -= 2;
        }
        invadersPos[i][2] *= -1;
        invadersPos[i][1] += 25;
      }

      // la partie est finie quand l'invader arrive en bas
  
      if (invadersPos[i][1] >= height)
        gameOver = true;
      //}
    }
  }
} 
//////////////////////////////////////////////////////////////
//
// La mise à jour de la fenêtre d'animation
// Cette fonction utilise notamment les fonctions :
// - drawGun pour afficher le canon
// - drawInvader pour afficher l'invader
// - drawBullet pour afficher le missile
//
//////////////////////////////////////////////////////////////
void repaint() {
  // fond de la fenêtre en blanc
  background(night);



  // affiche l'écran Game Over si la partie est finie
  if (gameOver) {
    gameOver();
  }
  // sinon affiche le jeu
  else {
    // affiche les éléments du jeu
    drawGun();
    drawBullet();
    drawInvader();
    drawScore();
  }
}

//////////////////////////////////////////////////////////////
//
// L'affichage du canon/
//
//////////////////////////////////////////////////////////////
void drawGun() {
  // choisit la couleur
  tint(0, 123, 0);
  // affiche le canon
  image(gun, gunX, gunY);
}

//////////////////////////////////////////////////////////////
//
// L'affichage de l'invader
//
//////////////////////////////////////////////////////////////
void drawInvader() {

  for (int i=0; i<invadersPos.length; ++i) { // quand il est touché
    if (hit && hitIndex==i) {
      // il s'affiche en rouge
      tint (255, invaderX, invaderY);
       
      // pendant un certain temps
      hitPeriod--;
      if (hitPeriod == 0)
        hit = false;
    } else

      tint (invadersPos[i][3], invadersPos[i][4], invadersPos[i][5]);

    image (invader[0][invaderIndex], invadersPos[i][0], invadersPos[i][1]);
    invaderIndex = (invaderIndex + 1) % 10;
  }
}




//////////////////////////////////////////////////////////////
//
// L'affichage du missile
//
//////////////////////////////////////////////////////////////
void drawBullet() {
  for ( i=0; i<10; i++) {
  if ( bulletX>=0 && bulletY<=width && 
      bulletY<=height) {
     tint (255, bulletX, bulletY);
      image ( firework_red [0][BulletIndx], bulletX, bulletY);
      BulletIndx = (BulletIndx +1) % firework_red.length;
    }
  }
}

//////////////////////////////////////////////////////////////
//
// Teste si le missile percute l'invader
//
//////////////////////////////////////////////////////////////
void testHit() { 
  for ( int i=0; i<10; i++) { 

    // si le missile est dans la "boîte englobante" de l'invader 
    if ((bulletX >= invadersPos[i][0] - 25) &&
      (bulletX <= invadersPos[i][0] + 25) &&
      (bulletY<= invadersPos[i][1] + 18) && 
      (bulletY >= invadersPos[i][1] - 18)) {
      // met à jour le score
        ++score;
       
      if (score > best)
        best = score;
      // l'invader est touché
      hit = true;
      hitIndex=i;
      hitPeriod = 10;
      // il n'y a plus de missile lancé
      bullet = false;
     
      // on le met de côté pour le cacher
      bulletX= -10;
       fire();
    }
}
}


//////////////////////////////////////////////////////////////
//
// L'affichage du 
//
//////////////////////////////////////////////////////////////
void drawScore() {
  // affiche le score
  fill(255, 255, 0);
  text("Score : " + score, width - 300, 20);
  text("Meilleur score : " + best, width - 300, 40);
  fill(255, 255, 0);
}

//////////////////////////////////////////////////////////////
//
// L'affichage du message "GAME OVER"
//
//////////////////////////////////////////////////////////////
void gameOver() {
  pushStyle();
  textAlign(CENTER, CENTER);
  textFont(fonte32);
  fill(255, 255, 0);
  text("GAME OVER !!!", width/2, height/2);
  
  textFont(fonte16);
  text("Press space bar to restart", width/2 - 5, height/2 + 30);
  popStyle();
}

//////////////////////////////////////////////////////////////
//
// Pilote le canon et contrôle le lancement de missiles
//
//////////////////////////////////////////////////////////////
void control() {
  if (keyPressed) {
    if (key == CODED) {
      // quand on appuie sur la flèche droite
      if (keyCode == RIGHT) {
        if (gunX < width - 25)
          gunX+=5;
      }
      // quand on appuie sur la flèche gauche
      else if (keyCode == LEFT) {
        if (gunX > 25)
          gunX-=5;
      }
    }
    // quand on appuie sur la barre d'espace
    else if (key == ' ') {
      // relance une nouvelle partie si c'était gameOver
      println ("test");
      if (gameOver) {
        gameOver = false;
        newGame();
      }
      // sinon tire un missile
      else {
        fire();
      }
    }
  }
}
