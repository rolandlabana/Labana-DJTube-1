//The MIT License (MIT) - See Licence.txt for details

//Copyright (c) 2013 Mick Grierson, Matthew Yee-King, Marco Gillies

// Modifications per class assignment © 2014 Roland Labana
// Modifications:
// Change the animation
// Add new players to allow the user to control an instrument in different keys
// The instrument can be controlled on/off and speed similar to the original beats
// But the user can choose the key to play the instrument loop in
// The original beats (being beats) will not change in pitch when the user changes keys


int tvx, tvy;
int animx, animy;
int deck1x, deck1y;
int deck2x, deck2y;

// Labana: declaure vars for location of our new buttons to choose chords
int deckAx, deckAy, deckDx, deckDy, deckEx, deckEy;

boolean deck1Playing = false;
boolean deck2Playing = false;


// Labana:
// Set up players for 3 chords in key of A
// Note - we are not shifting the pitch in real time
// instead we are loading samples that are in each of the
// pitches of A, D, E
// the next exercise would be to load one sample only
// and dynamiacally shift the pitch to any arbitrary
// key. But this method here is good enough for week 2
// assignment - I think :)
boolean deckAPlaying = false;
boolean deckDPlaying = false;
boolean deckEPlaying = false;


float rotateDeck1 = 0;
float rotateDeck2 = 0;
float currentFrame = 0;
int margin = width/40;
PImage [] images;
PImage [] recordPlayer;
PImage TV;
Maxim maxim;
AudioPlayer player1;
AudioPlayer player2;

// Labana:
// Add our other audio players and images for the buttons
AudioPlayer playerA;
AudioPlayer playerD;
AudioPlayer playerE;

PImage AButtonPic, DButtonPic, EButtonPic;


float speedAdjust=1.0;


void setup()
{
  size(768,1024);
  imageMode(CENTER);
  images = loadImages("Animation_data/movie", ".jpg", 134);
  recordPlayer = loadImages("black-record_", ".png", 36);
  TV = loadImage("TV.png");
  maxim = new Maxim(this);
  player1 = maxim.loadFile("beat1.wav");
  player1.setLooping(true);
  player2 = maxim.loadFile("beat2.wav");
  player2.setLooping(true);
  
  //Labana:
  //Load our chord samples
  playerA = maxim.loadFile("AChord.wav");
  playerA.setLooping(true);
  
  playerD = maxim.loadFile("DChord.wav");
  playerD.setLooping(true);
  
  playerE = maxim.loadFile("EChord.wav");
  playerE.setLooping(true);
  
  //Labana:
  //Load our chord button images
  AButtonPic = loadImage("AChordButton.png");
  DButtonPic = loadImage("DChordButton.png");
  EButtonPic = loadImage("EChordButton.png");

  
  background(10);
}

void draw()
{
  background(10); 
  imageMode(CENTER);
  image(images[(int)currentFrame], width/2, images[0].height/2+margin, images[0].width, images[0].height);
  image(TV, width/2, TV.height/2+margin, TV.width, TV.height);
  deck1x = (width/2)-recordPlayer[0].width/2-(margin*10);
  deck1y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck1], deck1x, deck1y, recordPlayer[0].width, recordPlayer[0].height);
  deck2x = (width/2)+recordPlayer[0].width/2+(margin*10);
  deck2y = TV.height+recordPlayer[0].height/2+margin;
  image(recordPlayer[(int) rotateDeck2], deck2x, deck2y, recordPlayer[0].width, recordPlayer[0].height);
  
  //Labana:
  // Set up the buttons for the three chords
  deckAx = AButtonPic.width/2+margin;
  deckAy = AButtonPic.height/2+margin;
  if (deckAPlaying) {
        tint(0, 153, 204);  // Tint blue
      } else {     noTint();
  }
  image(AButtonPic, deckAx, deckAy, AButtonPic.width, AButtonPic.height);
  noTint();

  deckDx = DButtonPic.width/2+margin;
  deckDy = AButtonPic.height/2+margin+AButtonPic.height+5;
   if (deckDPlaying) {
        tint(0, 153, 204);  // Tint blue
      } else {     noTint();
  }
  image(DButtonPic, deckDx, deckDy, DButtonPic.width, DButtonPic.height);
  noTint();

  deckEx = EButtonPic.width/2+margin;
  deckEy = DButtonPic.height/2+margin+AButtonPic.height+DButtonPic.height+10;
   if (deckEPlaying) {
        tint(0, 153, 204);  // Tint blue
      } else {     noTint();
  }
  image(EButtonPic, deckEx, deckEy, EButtonPic.width, EButtonPic.height);
  noTint();

  


// Labana:
// Check if any chord players being played and adjust speed similar
// to existing players
  if (deck1Playing || deck2Playing || deckAPlaying || deckDPlaying || deckEPlaying) {
    
    player1.speed(speedAdjust);
    player2.speed((player2.getLengthMs()/player1.getLengthMs())*speedAdjust);
    currentFrame= currentFrame+1*speedAdjust;
    
    playerA.speed((playerA.getLengthMs()/player1.getLengthMs())*speedAdjust);
    playerD.speed((playerD.getLengthMs()/player1.getLengthMs())*speedAdjust);
    playerE.speed((playerE.getLengthMs()/player1.getLengthMs())*speedAdjust);

  }

  if (currentFrame >= images.length) {
    currentFrame = 0;
  }

  if (deck1Playing) {
    rotateDeck1 += 1*speedAdjust;
    if (rotateDeck1 >= recordPlayer.length) {
      rotateDeck1 = 0;
    }
  }

  if (deck2Playing) {
    rotateDeck2 += 1*speedAdjust;
    if (rotateDeck2 >= recordPlayer.length) {
      rotateDeck2 = 0;
    }
  }
  
 
  
  
}


void mouseClicked()
{

  //if (mouseX > (width/2)-recordPlayer[0].width-(margin*10) && mouseX < recordPlayer[0].width+((width/2)-recordPlayer[0].width-(margin*10)) && mouseY>TV.height+margin && mouseY <TV.height+margin + recordPlayer[0].height) {
  if(dist(mouseX, mouseY, deck1x, deck1y) < recordPlayer[0].width/2){
    deck1Playing = !deck1Playing;
  }
  if (deck1Playing) {
    player1.play();
  } 
  else {
    player1.stop();
  }

  if(dist(mouseX, mouseY, deck2x, deck2y) < recordPlayer[0].width/2){
    deck2Playing = !deck2Playing;
  }
  if (deck2Playing) {
    player2.play();
  } 
  else {
    player2.stop();
  }
  
  // Labana:
  // Check which any of the Chord buttons are clicked and start playing the
  // approriate wav sample. Stop the other chords, since we only want
  // one to play at a time
   if(dist(mouseX, mouseY, deckAx, deckAy) < AButtonPic.width/2){
    deckAPlaying = !deckAPlaying;
    deckDPlaying = false;
    deckEPlaying = false;

  }
  if (deckAPlaying) {
    playerA.play();
    playerD.stop();
    playerE.stop();
  } 
  else {
    playerA.stop();
  }
  
 if(dist(mouseX, mouseY, deckDx, deckDy) < DButtonPic.width/2){
    deckDPlaying = !deckDPlaying;
    deckAPlaying = false;
    deckEPlaying = false;
  }
  if (deckDPlaying) {
    playerD.play();
    playerA.stop();
    playerE.stop();
  } 
  else {
    playerD.stop();
  }
  
 if(dist(mouseX, mouseY, deckEx, deckEy) < EButtonPic.width/2){
    deckEPlaying = !deckEPlaying;
    deckDPlaying = false;
    deckAPlaying = false;
  }
  if (deckEPlaying) {
    playerE.play();
    playerD.stop();
    playerA.stop();
  } 
  else {
    playerE.stop();
  }
  
}

void mouseDragged() {
   
 if (mouseY>height/2) {
  
   speedAdjust=map(mouseX,0,width,0,2);
   
 } 
}

