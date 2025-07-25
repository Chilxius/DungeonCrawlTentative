//CURRENT TASK: //<>// //<>//
  //Add cancel button to more screens
  //Work on select-key system
  //Re-color base hero fists?
  //Make start-of-combat text be ghost words
  //Status icons for baddies

  //Improve Rend damge
  //Need a little more exp in forest before man-wolf
  //Increase Prey damage
  //Fix sekeleton "banana sword"
  //Windrazor damage
  //Bandit knives still too powerful
  //Viper form poisoned a dead enemy
  //Sister Kat by the river
  //Playtest/balance Saurians - too boring
  //Make equipment worth less than treasures
  //Viper form poisons empty slots
  //Walking up into rapids pushes the player down two
  //Grass!
  //No "monster takes damage" message after magic
  //Get mp back from attacking
  //Some extra bonus from defending?
  //Bombs: keep from crit?
  //Still getting into un-endable text loop (debug mode?)
  //Have a Ritisu priest talk about reagents
  //Improve bomb damage

//To change once font is chosen:
  //cleric owed money
  //child's comment about mud washing out (spacing)
  //fix music notes
  //martial artists class name
  //Ability descriptions (armor break)


//Import files for Minim (sound)
/*
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
*/

//Dungeon Crawl Game
//Bennett Ritchie

//Why is ostinato so powerful at higher levels? (maybe cut the level by two in the calculation)

//PROBLEMS:
//Fix objects getting strange tile colors
//Boss didn't drop money when killed by poison (might not have given exp either)
//Balance armor pierce abilities (wow, razor is crazy)
//Hero gained a level while dead (3rd position, was revived once)
//Damage seems to be increasing a bit quickly (did ~60 to Big gray rat)
//Cost of ostinato went to 0 - must have negative rhythm (couldn't replicate)
//Defensive Strike did not give extra energy on crit

//TO DO:
//Finish up boat in Waraka harbor
//Change start-of-battle messages
//Change Kat's initial dialogue
//Make tomb guardians more dangerous
//Look up String.trim()
//Skills: animation system
//Make battles stop triggering on spaces with events
//Add a "holding on" mechanic to stay alive after critical damage
//Mechanic for someone following you (tied to a Key)
//Change game over to zoom out of crystal

//IMPROVEMENT:
//Still reaching necromancer at level 5 - add more skeletons or improve their exp  
//Have inns charge money?
//Delay before "vanquished" line where enemy vanishes
//Character Backs: Knight helmet/neck, Barbarian axe/legs, Karate hair, Thief cowl, Priest hair, saurian head, druid antler/staff
//Tone fixes for random text
//More random names

//IMAGES I NEED:
//heroes

//NOTES:
//I edited the log class to remove spaces in text - might cause errors downstream
//I edited the log class again to not add text from an empty string
//Poison seems to be killing heroes properly
//poison dealt 1 but removed 2 (couldn't reproduce)
//I cut the value of armor in half in the code to normalize damage - might need to re-test earlier levels
//Animations seem to be multi-dispaying; it was less transparent due to layering.

//Turned sound off for the time being. Will include later with Beads
import processing.sound.*;

//For Debug Mode
boolean debugMode = true;

int mapCount = 10;
Map [] m = new Map[mapCount];
DangerMap [] dm = new DangerMap[mapCount];
boolean dangerMapOn = false; //DEBUG TOOL
boolean locationMapOn = false; //DEBUG TOOL
boolean noClip = false; //DEBUG TOOL

//Game begins waiting for a typed input, which will be stored as the save file name
Input input = Input.TYPING;
Input previous = Input.NONE; //Attempt to make new system work
Display display = Display.MAIN_MENU;
Display previousDisplay = Display.NONE;
HeroCreationStep step = HeroCreationStep.NAME;
HeroSelectReason reason = HeroSelectReason.NONE;

//NEW LOG SYSTEM
Logbook log = new Logbook(43);

//The text to be displayed in the box
String textLine1 = " ";
String textLine2 = " ";
String textBuffer = ""; //For when something is being typed in (character limit 10).

//Game data limits
int itemCount = 200;
int doorCount = 100;
int bossCount = 100;

//Hero Data
int currentHero = 0; //0,1,2
String tempName;
Job tempJob = Job.NONE;
color tempColor, tempInverseColor;
float tempRed=80,tempGreen=80,tempBlue=80;  //for character creation
float tempRed2=40,tempGreen2=40,tempBlue2=40; //for character creation
boolean slider[] = {false,false,false,false,false,false,false};
int tempHair = 1, tempSkin = 150;
color hairTone[] = {#090806, #463723, #8C7850, #D2BE46, #E16E32, #FFF5F1};
//color skinTone[] = {#3b2219,#a16e4b,#d4aa78,#e6bc98,#ffe7d1};
boolean heroDataDisplayed[] = {false,false,false};

//Exploration Data
Party party = new Party( new Hero(false), new Hero(false), new Hero(false));
ArrayList<Portal> exits = new ArrayList<Portal>();
int zoneNumber = 1; //type of zone the party is in (mostly for music)

//UI data
Artist vanGogh;// = new Artist();
ArrayList<GhostNumber> floatingNumbers = new ArrayList<GhostNumber>();
int windowX, windowY; //position of program window
int frameWidth, frameHeight; //dimensions of game window  //These are not implemented
int frameX, frameY; //position of game window (corner)    //to work for all sizes yet.
boolean showUX = false; //show/hide clickable UI buttons
int UIButtonClicked = 0; //which button to depress
int handIndex = 0; //which hero's hand color is used for icon
int potionIndex = 12; //which color potion is displayed

//Sound effects
Sound s;
//SoundFile openDoorSound, openChestSound, lockedDoorSound, potionDrinkSound, foodBiteSound;
SoundFile SFX[] = new SoundFile[9];

/*
//Music
//SoundFile titleScreenMusic, safeCellarMusic, caveMusic, forestMusic, townMusic, graveyardMusic, cathedralMusic, ritisuMusic;
SoundFile music[] = new SoundFile[8];
int currentMusic = 0, nextMusic = 0;
boolean crossFading = false;
float volume;
*/

//Minim audio;
//AudioPlayer openDoorSound, openChestSound, lockedDoorSound, potionDrinkSound, foodBiteSound;
//AudioPlayer titleScreenMusic;

//Image data
PImage tileImage[]    = new PImage[200]; //I've since used this for more than just tiles
PImage battleBack[]   = new PImage[10];  //Backgrounds for battles
PImage iconImage[]    = new PImage[50];  //Icons for buttons, need to move some items from tileImage
PImage effectImage[]  = new PImage[110]; //Images for effects. Will eventually include spell effects.
PImage mouseUXImage[] = new PImage[25];   //Images for mouse controls
PImage cursor;
PImage border;
//Animation data
ArrayList<Animation> animations = new ArrayList<Animation>();

//Item data
Loot [][] lootList = new Loot[8][itemCount]; //UPDATE AS FLOORS ARE ADDED!!
Loot emptyChest = new Loot(0,0,new Item(),"EMPTY CHEST ERROR");
int consumableValue = 0;
Equipment newEquip, oldEquip; //for switching in new equipment
int newEquipIndex = -1;
LootTable theStuff = new LootTable();

//Save data
String saveFileName = "";
boolean awaitingFileName = true;
boolean newGame = false;
SavePoint [] savePoints = new SavePoint[20]; //10 is temporary
SavePoint lastSave = new SavePoint(); //should defalt to starting position
boolean confirmSave = false;
ProgressSwitch itemSwitches[] = new ProgressSwitch[itemCount]; //don't know how big this will get
ProgressSwitch doorSwitches[] = new ProgressSwitch[doorCount]; //or this
ProgressSwitch bossSwitches[] = new ProgressSwitch[bossCount]; //or, in fact, this
static int itemSwitchCount = 0;
static int doorSwitchCount = 0;
static int bossSwitchCount = 0;

//Battle Data
Battle battle;
Beastiary zoo;// = new Beastiary();
int randomBattleCounter = 0;
Monster battleMonsters[];
int potionType = 0; //potion being drunk
float battleTextSpeed = 1.3; //speed battle text displays
int currentBoss = -1; //index of boss being fought
boolean multiBoss = false; //is this a multiple enemy boss fight
int skillSelection = -1; //index of chosen skill (hero)

//Font Data
PFont font;
float fontScale = 1.05;

//Save Data
PrintWriter saveOutput;

boolean gameover = false;

void setup()
{
  background(0);
  
  println("Loading font...");
  font = createFont("Inconsolata-Bold.ttf", 14);
  textFont(font);
  
  //fullScreen();
  size(750,750);
  frameWidth = 700;
  frameHeight = 700;
  frameX = (width-frameWidth)/2;
  frameY = (height-frameHeight)/2;
  
  frameRate(60);
  surface.setTitle("THE RIDDLE OF IRON");
  cursor = loadImage("cursorSword.png");
  cursor.resize(32,0);
  cursor(cursor,0,0);
  
  vanGogh = new Artist();
  windowX = displayWidth/2-width/2;
  windowY = displayHeight/2-height/2;
  surface.setLocation(windowX, windowY);
  
  println("Loading item data...");
  newEquip = new Equipment();
  oldEquip = new Equipment();
  
  println("Loading monster data...");
  zoo = new Beastiary();
  
  println("Loading graphics data...");
  //Setting up image files (MOVE THIS TO Artist)
  loadImages(); //Done in Artist tab
  
  Sound s = new Sound(this);
  s.volume(1);
  
  println("Loading sound effect data...");
  //Sound effects
  SFX[0] = new SoundFile(this, "lock.mp3");
  SFX[1] = new SoundFile(this, "chest.mp3");
  SFX[2] = new SoundFile(this, "jiggle.mp3");
  SFX[3] = new SoundFile(this, "gulp.mp3");
  SFX[4] = new SoundFile(this, "bite.mp3");
  SFX[5] = new SoundFile(this, "glass.mp3");  SFX[5].amp(0.5);
  SFX[6] = new SoundFile(this, "save.mp3");
  SFX[7] = new SoundFile(this, "gate.wav");   SFX[7].amp(0.5);
  SFX[8] = new SoundFile(this, "paper.wav");  SFX[8].amp(1);
  
  /*
  println("Loading music data...");
  //Music
  music[0] = new SoundFile(this, "tryAndSolve.wav");    //titleScreenMusic.volume(0.5);
  music[1] = new SoundFile(this, "reminiscence.mp3");
  music[2] = new SoundFile(this, "cave.mp3");
  music[3] = new SoundFile(this, "mountains.wav");
  music[4] = new SoundFile(this, "fridayAfternoon.wav");
  music[5] = new SoundFile(this, "phantomForest.mp3");
  music[6] = new SoundFile(this, "palace.mp3");
  music[7] = new SoundFile(this, "corridorsOfTime.mp3");
  */
  
  //audio = new Minim(this);
  //Sound Effects
  //openDoorSound = audio.loadFile("lock.mp3",1024);
  //openChestSound = audio.loadFile("chest.mp3",1024);
  //lockedDoorSound = audio.loadFile("jiggle.mp3",1024);
  //foodBiteSound = audio.loadFile("bite.mp3",1024);
  //potionDrinkSound = audio.loadFile("gulp.mp3",1024);
  //Musics
  //titleScreenMusic = audio.loadFile("Try and Solve This Loop.wav",1024);

  createInventories();
  //setUpLootList();
    
  //party.keyInventory[0] = Key.SKELETON_KEY;
  /*
  party.inventory[0]  = new Item( "Potion", 12 );
  party.inventory[4]  = new Item( "Bread", 10 );
  party.inventory[6]  = new Item( "Pork", 20 );
  party.inventory[14] = new Item( "Bread", 10 );
  party.inventory[20] = new Item( "Bread", 10 );
  party.inventory[15] = new Item( "Fruit", 30 );
  party.inventory[25] = new Item( "Crab", 40 );
  party.inventory[10] = new Item( "Health Potion", 12 );
  party.inventory[21] = new Item( "Mana Potion", 24 );
  party.inventory[13] = new Item( "Vapor Potion", 36 );
  party.inventory[8]  = new Item( "Elixer", 48 );
  */
  
  party.setPosition(1,4,2);

  setupMaps();

  battleMonsters = new Monster[3];
  
  //music[0].play();
}


void draw()
{
  if(vanGogh.screenShaking)
    vanGogh.shakeScreen();
  
  background(0);
  
  translate(25,25); //Shift everything down into the border
  
  if(display == Display.MAIN_MENU)
    vanGogh.drawMainMenu();

  vanGogh.drawTextBoxes(input,textBuffer,textLine1,textLine2);
  
  if( step == HeroCreationStep.DONE || step == HeroCreationStep.NAME )
  {
    vanGogh.drawHeroBoxes( party.hero );
    drawConditions(); // <- move to drawHeroBoxes
    if( step == HeroCreationStep.NAME && input == Input.TYPING && !awaitingFileName)
      vanGogh.drawTextConfirmButton();
  }
  
  //Hero creation process only
  if(step == HeroCreationStep.JOB)
    vanGogh.drawJobChoices(currentHero);
  else if(step == HeroCreationStep.COLOR)
    vanGogh.drawCustomizeScreen(tempRed,tempGreen,tempBlue,tempRed2,tempGreen2,tempBlue2,tempHair,tempSkin);
    
  if(display == Display.MAP)
    m[party.floor].drawMapOnPosition(party.X,party.Y,party.hero(0).getColor(),party.hero(1).getColor(),party.hero(2).getColor());
  else if(display == Display.KEY_LIST)
    vanGogh.drawKeys(party.keyInventory);
  else if(display == Display.ITEM_LIST)
    vanGogh.drawItems(party.inventory);
  else if(display == Display.HELP_MENU)
    vanGogh.drawHelpMenuScreen();
  else if(display == Display.CREDITS)
    vanGogh.drawCredits();
  else if(display == Display.FOOD_MENU)
    vanGogh.drawFoodMenu(party.inventory);
  else if(display == Display.POTION_MENU)
    vanGogh.drawPotionMenu(party.inventory);
  else if(display == Display.HERO_SELECT || display == Display.EQUIP )
    vanGogh.drawHeroSelectScreen();
  else if(display == Display.BATTLE)
  {
    if(vanGogh.battleWindowOpening)
      m[party.floor].drawMapOnPosition(party.X,party.Y,party.hero(0).getColor(),party.hero(1).getColor(),party.hero(2).getColor());
    else
    {
      if(gameover)
      {
        vanGogh.runGameoverAnimation();
      }
      else if(!battle.runBattle()) //don't begin initiative until battle is loaded
      {                        //returns true when battle is over
        display = Display.MAP;
        input = Input.EXPLORING;
      }
    }
    if(!gameover)
      vanGogh.drawBattleWindow();
  }
  
  vanGogh.drawAndCleanupFloatingNumbers();
  
  if((heroDataDisplayed[0]||heroDataDisplayed[1]||heroDataDisplayed[2])&&(input == Input.EXPLORING || input == Input.BATTLE_MENU ))
  {
    if     (heroDataDisplayed[0]) vanGogh.drawHeroData(0);
    else if(heroDataDisplayed[1]) vanGogh.drawHeroData(1);
    else if(heroDataDisplayed[2]) vanGogh.drawHeroData(2);
  }

  if(input==Input.ADVANCE_TEXT)
    vanGogh.drawAdvanceTextPrompt();
  
  //Border
  push();
  imageMode(CORNER);
  image(border,-25,-25);
  pop();
    
  if(vanGogh.resting)
    vanGogh.drawRestFadeout();
  
  //Advance any animations
  vanGogh.animate();
  
  //if( dist( mouseX, mouseY, 50+frameX, 50+frameY ) < 25 ) //TESTING    ODD HOW TRANSLATE WORKS
  //text("X:"+(mouseX-25) + " Y:"+(mouseY-25), width/2, 100);
  if( dangerMapOn )
    m[party.floor].drawDangerMap( party.X, party.Y );
  if( locationMapOn )
    m[party.floor].drawLocationMap( party.X, party.Y );
    
  //TESTING
  textSize(25);
  fill(0);
  text("INPUT: "+input + "     STEP: "+step, width/2, 0);
}

void drawConditions()
{
  for(int h = 0; h < 3; h++)
    for(int i = 0; i < 5; i++)
      if(party.hero(h).hasCondition(i))
        vanGogh.drawCondition(i,h);
}

public String inputText() //Retrieves the text in the box and switches game state
{
  if(awaitingFileName)
  {
    saveFileName = textBuffer;
    awaitingFileName = false;

    //If load fails, will start normal game
    loadFile( saveFileName );

  }
  else
  {
    if(party.hero(2).isCreated())
    {
      previous = input;
      input = Input.ADVANCE_TEXT;
      //key = ' ';
    }
    else
    {
      step = HeroCreationStep.JOB;
      input = Input.HERO_JOB_CHOICE; //<>// //<>//
      if(textBuffer.equals(""))
        textBuffer = randomName();
      advanceText("What is "+textBuffer+"'s Job");
    }
  }
  
  return textBuffer;
}


void advanceText( String s ) //usually for specific edge cases.-
{
  textLine1 = textLine2;
  textLine2 = s;
}

void advanceNextTextLine() //pops the queue (do you pop queues? I don't recall)
{
  advanceText(log.message());
  if( log.isEmpty() )
    input = previous;
}

void displayTextLine( String s ) //Most common for single-line text
{
  pushTextLine( s );
  keyPressed();
}

void pushTextLine( String s ) //Add a line to the queue
{
  previous = input;
  input = Input.ADVANCE_TEXT; //forces text advance prompt for more than two lines 
  log.addMessage(s);
  key = ' ';
}

void createInventories()
{
  for(int i = 0; i < party.keyInventory.length; i++)
    party.keyInventory[i] = Key.NONE;
  for(int i = 0; i < party.inventory.length; i++)
    party.inventory[i] = new Item();
}

//Gets floor, x, y, and key type. Adds to the loot table and progress switches
void createLoot( int serial, int fl, int xP, int yP, Key k )
{
  lootList[fl][serial] = new Loot(xP,yP,k);
  itemSwitches[itemSwitchCount++] = new ProgressSwitch( SwitchType.CHEST, xP, yP, fl );
}

//Gets floor, x, y, and item details. Adds to the loot table and progress switches
void createLoot( int serial, int fl, int xP, int yP, Item i )
{
  lootList[fl][serial] = new Loot(xP,yP,i);
  itemSwitches[itemSwitchCount++] = new ProgressSwitch( SwitchType.CHEST, xP, yP, fl );
}
  
public boolean isBombKit( Key k ) //Is key a bomb kit
{
  if( k == Key.F || k == Key.I || k == Key.A || k == Key.W
   || k == Key.FI || k == Key.FA || k == Key.FW
   || k == Key.IA || k == Key.IW || k == Key.AW
   || k == Key.FIA || k == Key.FIW || k == Key.FAW || k == Key.IAW
   || k == Key.FIAW )
    return true;
  return false;
}

void getActiveBombs( Key kit, boolean [] bomb )
{
  if( kit == Key.FIAW )
  {
    bomb[0]=bomb[1]=bomb[2]=bomb[3]=true;
    return;
  }
  
  if( kit == Key.F || kit == Key.FI || kit == Key.FA || kit == Key.FW || kit == Key.FIA || kit == Key.FIW || kit == Key.FAW )
    bomb[0] = true;
  if( kit == Key.I || kit == Key.FI || kit == Key.IA || kit == Key.IW || kit == Key.FIA || kit == Key.FIW || kit == Key.IAW )
    bomb[1] = true;
  if( kit == Key.A || kit == Key.IA || kit == Key.FA || kit == Key.AW || kit == Key.FIA || kit == Key.IAW || kit == Key.FAW )
    bomb[2] = true;
  if( kit == Key.W || kit == Key.IW || kit == Key.AW || kit == Key.FW || kit == Key.IAW || kit == Key.FIW || kit == Key.FAW )
    bomb[3] = true;
}

String ordinalNumber( int num ) //for indecies
{
  if(num==0) return "first";
  if(num==1) return "second";
  if(num==2) return "third";
  if(num==3) return "fourth";
  if(num==4) return "fifth";
  if(num==5) return "sixth";
  return "?????";
}

String indefArticle( String word )
{
  if( isVowel( word.toLowerCase().charAt(0) ) )
    return "an";
  return "a";
}

String wasOrWere( char c )
{
  if( c == 's' )
    return "were";
  return "was";
}

String hasOrHave( char c )
{
  if( c == 's' )
    return "has";
  return "have";
}

String isOrAre( char c )
{
  if( c == 's' )
    return "is";
  return "are";
}

String needAnA( String s )
{
  if( s == "sword" )
    return "a ";
  if( s == "axe" )
    return "an ";
  return "";
}

boolean isVowel( char c )
{
  if(c=='a' || c=='A'
  || c=='e' || c=='E'
  || c=='i' || c=='I'
  || c=='o' || c=='O'
  || c=='u' || c=='U' )
    return true;
  return false;
}

boolean attemptMove( String direction )
{
  boolean result = false;
  switch(direction)
  {
    case "left":
      if((party.X > 0 && m[party.floor].tilePathable(party.X-1,party.Y)) || noClip)
      {  party.X--; checkEvent(); result = true; } break;
    case "right":
      if((party.X < 99 && m[party.floor].tilePathable(party.X+1,party.Y)) || noClip)
      {  party.X++; checkEvent(); result = true; } break;
    case "up":
      if((party.Y > 0 && m[party.floor].tilePathable(party.X,party.Y-1)) || noClip)
      { party.Y--; checkEvent(); result = true; } break;
    case "down":
      if((party.Y < 99 && m[party.floor].tilePathable(party.X,party.Y+1)) || noClip)
      {  party.Y++; checkEvent(); result = true; } break;
  }
  
  if( checkRapids( direction ) && input != Input.ADVANCE_TEXT ) //Had to add input check to avoid adding bonk text during conversations while on rapids
    checkEvent();
  
  if( m[party.floor].tiles[party.X][party.Y].type == TileType.AUTO_DOOR || m[party.floor].tiles[party.X][party.Y].type == TileType.AUTO_CAVE_DOOR ) //This will probably be a method later
    changeMap();
  
  vanGogh.checkLocationForTitleCard( party.floor, party.X, party.Y );
  
  if( result && checkForBattle() && !noClip )
    triggerBattle(dm[party.floor].dangerValueChar(party.X,party.Y));
  
  return result;
}

void checkEvent()
{
  //Event text
  if(m[party.floor].tileHasEvent(party.X,party.Y))
  {
    //println("PLAY EVENT");
    m[party.floor].tiles[party.X][party.Y].playEvent();
  }
}

boolean checkRapids( String d )
{
  boolean result = false;
  //Pull Down
  if(party.Y < 99 && m[party.floor].tiles[party.X][party.Y].type==TileType.RAPIDS )//&& m[party.floor].tiles[party.X][party.Y+1].pathable)
  {
    if( d.equals("up") && m[party.floor].tiles[party.X][party.Y+1].pathable )
    {
      party.Y++;
      result = true;
    }
    if( !d.equals("down") && m[party.floor].tiles[party.X][party.Y+1].pathable )
    {
      party.Y++;
      result = true;
    }
  }
  //Pull Up
  if(party.Y > 0 && m[party.floor].tiles[party.X][party.Y].type==TileType.RAPIDS_UP )
  {
    if( !d.equals("up") && m[party.floor].tiles[party.X][party.Y-1].pathable )
    {
      party.Y--;
      result = true;
    }
    if( d.equals("down") && m[party.floor].tiles[party.X][party.Y-1].pathable )
    {
      party.Y--;
      result = true;
    }
  }
  //Pull Left
  if(party.X > 0 && m[party.floor].tiles[party.X][party.Y].type==TileType.RAPIDS_LEFT )
  {
    if( !d.equals("left") && m[party.floor].tiles[party.X-1][party.Y].pathable )
    {
      party.X--;
      result = true;
    }
    if( d.equals("right") && m[party.floor].tiles[party.X-1][party.Y].pathable )
    {
      party.X--;
      result = true;
    }
  }
  //Pull Right
  if(party.X < 99 && m[party.floor].tiles[party.X][party.Y].type==TileType.RAPIDS_RIGHT )
  {
    if( d.equals("left") && m[party.floor].tiles[party.X+1][party.Y].pathable )
    {
      party.X++;
      result = true;
    }
    if( !d.equals("right") && m[party.floor].tiles[party.X+1][party.Y].pathable )
    {
      party.X++;
      result = true;
    }
  }
  return result;
}

boolean checkForBattle()
{
  if(random(100)<randomBattleCounter)  // <- THIS IS PROBABLY WHERE THE BATTLE STARTING ON EVENT SQUARE WILL BE FIXED
  {
    randomBattleCounter = -10;
    return true;
  }
  
  //println(zoneNumber);
  //println(randomBattleCounter + "  DL:" +dm[party.floor].dangerValueChar(party.X,party.Y));
  //println(m[1].tiles[40][4].occupantText);
  randomBattleCounter++;
  
  //if(randomBattleCounter > 0 && randomBattleCounter % 5 == 0)  // <- not sure why the >0 was there
  if( randomBattleCounter % 5 == 0 )
    party.tickDownPoisons();
  if(randomBattleCounter % 2 == 0 )
  {
    party.tickDownSleep();
    party.tickDownParalysis();
  }
  
  return false;
}
  
public String randomName()
{
  switch( int(random(97)) )
  {
    case 1: return "Angel";    case 26: return "Alex";     case 42: return "Ash";     case 74: return "Alicia";
    case 2: return "Björn";    case 27: return "Briar";    case 52: return "Bella";   case 75: return "Basil";
    case 3: return "Cadell";   case 28: return "Colette";  case 53: return "Cyrus";   case 76: return "Caroline";
    case 4: return "Darya";    case 29: return "Draco";    case 54: return "Dirk";    case 77: return "Dexter";
    case 5: return "Enyo";     case 30: return "Elwyn";    case 55: return "Europa";  case 78: return "Ella";
    case 6: return "Fritjof";  case 31: return "Faith";    case 56: return "Freya";   case 79: return "Ferris";
    case 7: return "Gunhild";  case 32: return "Gale";     case 57: return "Gabriel"; case 80: return "Godric";
    case 8: return "Homer";    case 33: return "Hana";     case 58: return "Hope";    case 81: return "Herschel";
    case 9: return "Inola";    case 34: return "Ivan";     case 59: return "Ilsa";    case 82: return "Inigo";
    case 10: return "Joy";     case 35: return "Jazz";     case 60: return "Jude";    case 83: return "Jack";
    case 11: return "Kai";     case 36: return "Kim";      case 61: return "Kris";    case 84: return "Knox";
    case 12: return "Leocadia";case 37: return "Law";      case 62: return "Luna";    case 85: return "Linus";
    case 13: return "Marc";    case 38: return "Misty";    case 63: return "Molly";   case 86: return "Michael";
    case 14: return "Nadya";   case 39: return "Neon";     case 64: return "Nail";    case 87: return "Nick";
    case 15: return "Orion";   case 40: return "Olga";     case 65: return "Onyx";    case 88: return "Ophelia";
    case 16: return "Phoenix"; case 41: return "Penelope"; case 66: return "Pip";     case 89: return "Paris";
    case 17: return "Quinn";                                                          case 90: return "Queenie";
    case 18: return "Raven";   case 43: return "Rook";     case 67: return "River";   case 91: return "Rafe";
    case 19: return "Sky";     case 44: return "Spike";    case 68: return "Sage";    case 92: return "Saria";
    case 20: return "Tybalt";  case 45: return "Tabitha";  case 69: return "Tigerlily"; case 93: return "Taro";
    case 21: return "Ursa";    case 46: return "Ulric";
    case 22: return "Vela";    case 47: return "Vulcan";   case 70: return "Vahn";
    case 23: return "Wystan";  case 48: return "Willow";   case 71: return "Wren";    case 94: return "William";
    case 24: return "Xena";    case 49: return "Xia";
    case 25: return "Yoko";    case 50: return "Yin";      case 72: return "Yang";    case 95: return "York";
    default: return "Zazi";    case 51: return "Zak";      case 73: return "Zoe";     case 96: return "Mary Sue";
  }
}

String bonkText( char direction ) //for when the heroes run into obstacles
{                                  //also handles boss activation
  int x = party.X, y = party.Y;
  
  //party tried to move off the map
  if( direction == 'l'){ x--; if(x<0)return" ";}
  else if( direction == 'r'){ x++; if(x>=m[0].tiles.length)return" ";}
  else if( direction == 'u'){ y--; if(y<0)return" ";}
  else if( direction == 'd'){ y++; if(y>=m[0].tiles[0].length)return" ";}
  
  switch( m[party.floor].tiles[x][y].type )
  {
    case WALL:
    case SAND_WALL:
    case DARK_WALL: return "Solid stone";
    case WATER: return "It's too deep to swim";
    case TREE: case DARK_TREE: return "A tree";
    case BIG_RAT:
    case PORTCULLIS:
    case DOOR_GATE:
    case CAVE_DOOR:
    case CAVE_BROWN_DOOR:
    case DOOR: return m[party.floor].tiles[party.X][party.Y].keyMessage();
    case CHAIN:
    case CHAIN_HOLE: return "A heavy link of anchor chain";
    case BLACK_WALL: return " ";//"An unlit wall";
    case GARGOYLE_JADE: return "A gargoyle carved of jade";
    case GARGOYLE_DARK: return "An image of the Black Vanguard";
    case GARGOYLE: return "A beautiful gargoyle statue";
    case WEREWOLF_WHITE: return "A gargoyle statue...?";
    case S_GLASS: return "A beautiful stained glass window";
    case RUBBLE_OBJ: return "Rubble blocks the way";
    case HILL: return "A craggy hill";
    case CRATE:
    case CRATE_OBJ: return "A heavy crate";
    case FENCE_OBJ: return "A sturdy fence";
    case STALAGMITE:
    case STALAGMITE_OBJ: return "A rigid stalagmite";
    case BOOK: return "A shelf full of books";
    case BOOK_EMPTY: return "An empty shelf";
  }
  
  if( m[party.floor].tiles[x][y].isBoss )
  {
    for( int i = 0; i < bossSwitches.length; i++ )
      if( bossSwitches[i]!=null && bossSwitches[i].floor == party.floor && partyNextToBoss(i) ) //bossSwitches[i].X == party.X && bossSwitches[i].Y == party.Y ) //too tired to do this better right now
      {
        currentBoss = i;
        multiBoss = m[party.floor].tiles[x][y].multipleBoss;
        return m[party.floor].tiles[x][y].occupantText;
      }
    println("MISSING BOSS ERROR");
  }
  
  if(m[party.floor].tiles[x][y].occupied) //If space occupied by person
    return m[party.floor].tiles[x][y].occupantText;
    
  return "Bonk";
}

boolean partyNextToBoss( int index ) //party is orthaganally adjacent to a boss //<>// //<>//
{
  //for( int i = 0; i < bossSwitches.length; i++ ) //<>// //<>// //<>//
  //{
    if( ( ( party.X == bossSwitches[index].X-1 || party.X == bossSwitches[index].X+1 ) && party.Y == bossSwitches[index].Y ) 
    ||  ( ( party.Y == bossSwitches[index].Y-1 || party.Y == bossSwitches[index].Y+1 ) && party.X == bossSwitches[index].X ) )
      return true;
  //}
  return false;
}

int squareHasLoot( int x, int y ) //-1 if nothing
{
  for(int i = 0; i < lootList[party.floor].length; i++)
    if(lootList[party.floor][i].xPos == x
    && lootList[party.floor][i].yPos == y
    && lootList[party.floor][i].item.keyType == Key.NONE )
      return i;
  return -1;
}

int squareHasKey( int x, int y )
{
  for(int i = 0; i < lootList[party.floor].length; i++)
    if(lootList[party.floor][i].xPos == x
    && lootList[party.floor][i].yPos == y
    && lootList[party.floor][i].item.keyType != Key.NONE )
      return i;
  return -1;
  
}

//This assumes the party is standing on the loot to be cleared
void clearLoot( int index )
{
  lootList[party.floor][index] = emptyChest;
  if(m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST
  || m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST_GOLD
  || m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST_DARK
  || m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST_BONE
  || m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST_HONEY )
    SFX[1].play();
  m[party.floor].tiles[party.X][party.Y].obj = Object.NONE;
}

//For loading from files - fixes disappearing save point problem (I hope)
void clearLoot( int floor, int xPos, int yPos, int index )
{
  lootList[floor][index] = emptyChest;
  m[floor].tiles[xPos][yPos].obj = Object.NONE;
}

void flipItemSwitch( int index )
{
  itemSwitches[index].active = false;
}

void flipDoorSwitch( int xPos, int yPos )
{
  for(int i = 0; i < doorSwitches.length; i++)
    if(doorSwitches[i].X==xPos && doorSwitches[i].Y==yPos)
    {
      doorSwitches[i].active = false;
      break;
    }
}

void flipBossSwitch( int xPos, int yPos )
{
  for(int i = 0; i < bossSwitches.length; i++)
    if(bossSwitches[i].X==xPos && bossSwitches[i].Y==yPos)
    {
      bossSwitches[i].active = false;
      break;
    }
}

void triggerBattle( char danger )
{
  if( danger == '0' || danger > 119 || m[0].tiles[party.X][party.Y].isSafe() || currentBoss != -1 )
  {
    //println("BATTLE NOT TRIGGERED");
    //println("Danger Rating: " + danger);
    //println("Tile Type: " + m[party.floor].tiles[party.X][party.Y].type);
  }
  else
  {
    vanGogh.beginBattleAnimation();
    display = Display.BATTLE;
    input = Input.NONE;
    //println("Danger Level: "+danger + "  int: "+int(danger));
    battle = new Battle(party.hero,dm[party.floor].dangerValueChar(party.X,party.Y),-1);
  }
}

public void changeMap()
{
  //println("FLOOR: " +party.floor + "  X: "+party.X + "  Y: "+party.Y);
  for(int i = 0; i < exits.size(); i++)
    if(exits.get(i).originX == party.X
    && exits.get(i).originY == party.Y 
    && exits.get(i).originFloor == party.floor )
    {
      party.X = exits.get(i).destinationX;
      party.Y = exits.get(i).destinationY;
      party.floor = exits.get(i).destinationFloor;
      vanGogh.startLocationTitleCard(exits.get(i).title);
      checkForStairEvent(exits.get(i));
      return;
    }
  println("ERROR: NO EXIT FOUND");
}

public void checkForStairEvent( Portal p )
{
  if( p.originX == 90 && p.originY == 79 && p.originFloor == 2 ) //stained glass
    SFX[5].play();
}

boolean mouseInBox( float boxX, float boxY ) //assumes boxes are 70x70
{
  if( mouseX-frameX > boxX-35 && mouseX-frameX < boxX+35 && mouseY-frameY > boxY-35 && mouseY-frameY < boxY+35 )
    return true;
  return false;
}

public int mouseInZone() //For UI overlay
{
  //Eye
  if( dist( mouseX, mouseY, 622.5+25, 510+25 ) < 75 ) return 1;
  //Move
  if( dist( mouseX, mouseY, 622.5+25, 370+25 ) < 75 ) return 9;
  //Hand
  if( dist( mouseX, mouseY, 622.5+25, 230+25 ) < 75 ) return 10;
  
  //Food
  if( dist( mouseX, mouseY, 77.5+25, 230+25 ) < 75 ) return 6;
  //Potion
  if( dist( mouseX, mouseY, 77.5+25, 370+25 ) < 75 ) return 7;
  //Key Item
  if( dist( mouseX, mouseY, 77.5+25, 510+25 ) < 75 ) return 8;

  //Arrows (lower priority)
  if( dist( mouseX, mouseY, 350+25, 240+25 ) < 75 ) return 2;
  if( dist( mouseX, mouseY, 240+25, 370+25 ) < 75 ) return 3;
  if( dist( mouseX, mouseY, 350+25, 500+25 ) < 75 ) return 4;
  if( dist( mouseX, mouseY, 480+25, 370+25 ) < 75 ) return 5;
  
  return 0;
}
  
public color appropriateColor( AttackType element )
{
  switch(element)
  {
    case FIRE:
      return color(200,0,0);
    case ICE:
      return color(0,0,200);
    case WIND:
      return color(0,200,0);
    case EARTH:
      return color(200,150,50);
    case HOLY:
      return color(255,255,0);
    default:
      return color(255);
  }
}

public int getZone( String title )
{
  switch( title )
  {
    case "": return zoneNumber;
    
    case "Cathedral Cellar": //start of game zone
      return -1;
    
    //Main Cathedral areas
    case "Dormitory":
    case "Shrine of Ritisu":
    case "Initiates' Classroom":
    case "Father Charis's Study":
    case "Irohill Cathedral":
    case "Kitchen":
    case "Laboratory":
    case "Armory":
      return 1;
      
    //Stone dungeons
    case "The West Cellar":
    case "Old Well":
      return 2;
      
    //Irohill forest & outdoor areas
    case "Irohill Forest":
    case "Looted Village":
    case "Honeydell":
      return 3;
      
    //Irohill city / Gullhaven village
    case "Irohill":
    case "Irohill Inn":
    case "Irohill Garrison":
    case "Irohill Town Hall":
    case "Hideout":
    case "Gullhaven":
    case "Barn":
    case "Bathhouse":
      return 4;
      
    //Baron's Field
    case "Baron's Field":
      return 5;
      
    //Baron's Field (inside)
    case "Tomb of Alar the Champion":
    case "Tomb of Corel the Beast":
    case "Tomb of Ruath the Pure":
    case "Tomb of Zan the Invincible":
    case "Tomb of Ivy the Wise":
    case "Tomb of Erar Thundercaller":
    case "Gravekeeper's Hut":
    case "Mausoleum":
    case "Cenotaph":
    case "Catacombs":
    case "Silent Path":
      return 7;
      
    //Library / honeydell manor
    case "Irohill Library":
    case "Honeydell Manor":
    case "Honeydell Tunnel":
    case "Honeydell Bedroom":
    case "Honeydell Kitchen":
    case "Honeydell Library":
    case "Honeydell Dining Hall":
    case "Honeydell Larder":
    case "Attic":
      return 8;
      
    //Barracuda Queen
    case " Ship's Office ":  //coming out of the chest
      SFX[1].play();
    case "Ship's Office":
    case "The Barracuda Queen":
    case "Forecastle Deck":
    case "Main Deck":
    case "Lower Deck":
    case "Quartereck":
    case "Captain's Cabin":
    case "Wardroom":
    case "Galley":
    case "Chain Locker":
    case "Your Cabin":
    case "Kat's Cabin":
    case "Officer's Cabin":
    case "Sail Locker":
    case "Hold":
      return 9;
      
    //Caves (brown)
    case "Cenote":
      return 10;
      
    //Bee Cave
    case "Sea Road Tunnel":
    case "Outer Hive":
    case "Central Hive":
      return 11;
      
    //Waraka Outdoors
    case "Waraka Sea Road":
      return 12;
      
    //Temples of Ritisu
    case "Temple of Ritisu":
    case "Forecastle":
      return 6;
      
    //Underground River
    case "Subterranean River":
      return 13;
      
    //Silent Zones
    default: return 0;
  }
}

public String jobToString( Job j )
{
  switch(j)
  {
    case KNIGHT:    return "Knight";
    case BARBARIAN: return "Barbarian";
    case SAURIAN:   return "Saurian";
    case KARATE:    return "Martial Artist";
    case BARD:      return "Bard";
    case THIEF:     return "Thief";
    case DRUID:     return "Druid";
    case PRIEST:    return "Priest";
    case MAGE:      return "Mage";
    default: return "Unemployed";
  }
}

public String bombName( int bombType )
{
  switch( bombType )
  {
    case 5: return " Flame";
    case 6: return "n Ice";
    case 7: return "n Acid";
    case 8: return " Thunder";
    default: return " UNKNOWN";
  }
}

public int bombCost( int type )
{
  switch(type)
  {
    case 5: return 1;
    case 6: return 2;
    case 7: return 3;
    case 8: return 5;
    default: return 99;
  }
}
  
Input appropriateInputMode()
{
  if( party.hero[battle.turn].skill[skillSelection].healing )
    return Input.BATTLE_HEAL_TARGET;
  return Input.BATTLE_SKILL_TARGET;
}

boolean mouseInTextBox()
{
  return mouseX > 25 && mouseX < 725 && mouseY > 625 && mouseY < 725;
}

//void handleSliders()  //DEFUNCT?
//{
  
//}

void keyPressed()
{
  if( debugMode && key == 'y' ) //DEBUG
    dangerMapOn = true;
  if( noClip && key == 'F' ) //DEBUG (change floors)
    party.floor++;
  if( noClip && key == 'U' ) //DEBUG (change floors)
    party.floor--;
  if( debugMode && key == 'u' )
    locationMapOn = true;
  if( debugMode && key == 'N' )
    noClip = !noClip;
  if( debugMode && key == 'O' )
    animations.add( new Animation( 2, 1, 1, 4 ) );
  if( debugMode && key == 'P' )
    animations.add( new Animation( 9, 0, 4 ) );
  //if( debugMode && key == 'r' )
  //  party.reagents--;
  //if(key == '1')
  //  beep1.play();
  //if(key =='2')
  //  beep2.play();
  //if(key == '3')
  //  beep3.play();
  
  if(input == Input.EXPLORING && display == Display.MAP)
  {
    if(key == ' ') //Needs to come first to avoid strange errors
    {              //This is a bit of a mess. could improve
      int lootIndex = max(squareHasLoot(party.X,party.Y),squareHasKey(party.X,party.Y));
      if(lootIndex>=0)
      {
        if( party.addToInventory(lootList[party.floor][lootIndex].item) ) //checks for full inventory
        {
          clearLoot(lootIndex);
          flipItemSwitch(lootIndex);
        }
      }
      //else
      //  advanceText("Nothing found.");
      
    }
    if(key == 'a' || keyCode == LEFT || key == '4')
      if(!attemptMove("left")&&display!=Display.BATTLE)displayTextLine(bonkText('l'));
    if(key == 'd' || keyCode == RIGHT || key == '6')
      if(!attemptMove("right")&&display!=Display.BATTLE)displayTextLine(bonkText('r'));
    if(key == 's' || keyCode == DOWN || key == '5')
      if(!attemptMove("down")&&display!=Display.BATTLE)displayTextLine(bonkText('d'));
    if(key == 'w' || keyCode == UP || key == '8')
      if(!attemptMove("up")&&display!=Display.BATTLE)displayTextLine(bonkText('u'));
    
    if(key == '>' || key == '9') //Changing floors
      if(m[party.floor].isStair(party.X,party.Y))
      //if(m[party.floor].tiles[party.X][party.Y].type==TileType.STAIR || m[party.floor].tiles[party.X][party.Y].type==TileType.STAIR_DOOR)
        changeMap();
        
    if( key == '1' ) heroDataDisplayed[0]=true;
    if( key == '2' ) heroDataDisplayed[1]=true;
    if( key == '3' ) heroDataDisplayed[2]=true;
    
    //Moved into a boss space
    if(currentBoss != -1)
    {  
      vanGogh.beginBattleAnimation();
      display = Display.BATTLE;
      input = Input.NONE;
      battle = new Battle( party.hero, 0, currentBoss );
    }
      
    if( ( key == 'o' || key == '7' ) && m[party.floor].tiles[party.X][party.Y].interactive) //open
      if(m[party.floor].tiles[party.X][party.Y].interact(party.keyInventory))
      {
        m[party.floor].openDoorsAround(party.X,party.Y);
        //openDoorSound.rewind();
      }

    if(key == 'E') //eat consumable
    {
      if(!party.hasFood())
        advanceText("You're all out of food.");
      else
      {
        display = Display.FOOD_MENU;
        input = Input.ITEM_USE;
      }
    }
    if(key == 'D') //drink potion
    {
      if(!party.hasPotion())
        advanceText("You have no magic potions.");
      else
      {
        display = Display.POTION_MENU;
        input = Input.ITEM_USE;
      }
    }
    if(key == 'S' && m[party.floor].tiles[party.X][party.Y].isSavePoint())
    {
      advanceText("Press (ENTER) to confirm save.");
      confirmSave = true;
    }
    else if(key == ENTER && confirmSave)
    {
      advanceText("GAME SAVED");
      confirmSave = false;
      SFX[6].play();
      saveGame(saveFileName+".txt");
    }
    else if (key == '\u0007')  // ASCII bell character — not typable
    {
      advanceText("GAME SAVED");
      SFX[6].play();
      saveGame(saveFileName+".txt");
    }
    else if(confirmSave)
    {
      advanceText("Save aborted");
      confirmSave = false;
    }
    if(display == Display.MAP && key == 'R' && ( m[party.floor].tiles[party.X][party.Y].obj == Object.TENT || m[party.floor].tiles[party.X][party.Y].obj == Object.BED ) ) //rest
    { //<>// //<>//
      if(party.needsRest())
      { //<>// //<>// //<>//
        input = Input.NONE;
        vanGogh.beginRestFadeout();
      }
      else
        displayTextLine("You don't need to sleep right now.");
    }
    if(display == Display.MAP && key == 'B' ) //buy/sell
    {
      if( m[party.floor].tiles[party.X][party.Y].type == TileType.SHOP ) //buy
      {
        if( party.gold >= m[party.floor].tiles[party.X][party.Y].itemPrice ) //party has enough gold
        {
          if( party.addToInventory(m[party.floor].tiles[party.X][party.Y].itemForSale) ) //should take care of full inventory
            party.gold -= m[party.floor].tiles[party.X][party.Y].itemPrice;
        } //<>// //<>//
        else
          displayTextLine( "You cannot afford the " + m[party.floor].tiles[party.X][party.Y].itemForSale.name +"." ); //party does not have enough gold //<>// //<>// //<>//
      }
      else if( m[party.floor].tiles[party.X][party.Y].type == TileType.SELL ) //sell
      {
        int moneyGained = party.sellItems();
        if( moneyGained > 0 )
        {
          party.gold += moneyGained;
          displayTextLine("You sell your loot for " + moneyGained + " gold.");
        }
        else
          displayTextLine("You have nothing to sell.");
      }
    }
    if(display == Display.MAP && key == 'k') //keys
    {
      previousDisplay = display;
      display = Display.KEY_LIST;
    }
    if(display == Display.MAP && key == 'i') //inventory
    {
      previousDisplay = display;
      display = Display.ITEM_LIST;
    }
    if(display == Display.MAP && key == 'h') //help menu
    {
      previousDisplay = display;
      display = Display.HELP_MENU;
    }
    if(display == Display.MAP && key == '`') //credits
    {
      previousDisplay = display;
      display = Display.CREDITS;
    }
    
    /*
    if(display == Display.MAP && key == 'z') //testing
    {
      party.hero[0].takeDamage(5,true);
      party.hero[1].takeDamage(5,true);
      party.hero[2].takeDamage(5,true);
    }
    */
  }
  //ITEM USE INPUT
  else if(input == Input.ITEM_USE)
  {
    //if(key == 'a') key = 49; //convert      this causes
    //if(key == 's') key = 50; //to           issues when trying
    //if(key == 'd') key = 51; //numbers      to move quickly
    //if(key == 'f') key = 52;                and using stairs/doors //<>// //<>//
    
    if(key == ' ') //<>// //<>// //<>//
    {
      display = Display.MAP;
      input = Input.EXPLORING;
    } //<>// //<>//
    else if(key > 48 && key < 53)
    { //<>// //<>// //<>//
      if(display == Display.FOOD_MENU && party.hasFood(key-48))
      {
        consumableValue = (key-48)*10;
        reason = HeroSelectReason.EAT;
        display = Display.HERO_SELECT;
        input = Input.HERO_SELECT;
      }
      if(display == Display.POTION_MENU && party.hasPotion(key-48))
      {
        consumableValue = (key-48)*12;
        reason = HeroSelectReason.DRINK;
        vanGogh.randomizeColors();
        display = Display.HERO_SELECT;
        input = Input.HERO_SELECT;
      }
    }
  }
  
  //BATTLE OPTIONS
  else if(display == Display.BATTLE)
  {
    if(input == Input.BATTLE_MENU && battle.turn >=0 && battle.turn < 3) //Top menu - (A)ttack, (D)efend, (S)kill/(S)pell, (X)-item
    {
      if(key == 'a')
        input = Input.BATTLE_ATTACK_TARGET;

      if( key == 'd')
      {
        displayTextLine( party.hero[battle.turn].name + " defends!");
        party.hero[battle.turn].defending = true;
        //vanGogh.addAnimation( "block", battle.turn, battle.turn, battleTextSpeed/2 );
        animations.add( new Animation( 1, battle.turn, battle.turn, battleTextSpeed/2 ) );
        battle.setBattleDelay(battleTextSpeed/2);
        battle.resumeInitiative();
      }
      
      if( key == 's')
        input = Input.BATTLE_SKILL;
        
      if( key == 'x')
        input = Input.BATTLE_ITEM;
        
      //Hero info
      if( key == '1' ) heroDataDisplayed[0]=true;
      if( key == '2' ) heroDataDisplayed[1]=true;
      if( key == '3' ) heroDataDisplayed[2]=true;
    }
    else if(input == Input.BATTLE_ATTACK_TARGET)
    {
      if( ( key == 'a' || key == 'A' || key == '1' ) && battle.list[3].active )
        battle.beginAttack( battle.turn, 3);

      else if( ( key == 's' || key == 'S' || key == '2' ) && battle.list[4].active )
        battle.beginAttack( battle.turn, 4);

      else if( ( key == 'd' || key == 'D' || key == '3' ) && battle.list[5].active )
        battle.beginAttack( battle.turn, 5);

      else if( key == 'x' || key == ' ' ) //cancel and return to battle menu
        input = Input.BATTLE_MENU;
    }
    else if(input == Input.BATTLE_SKILL)
    {
      if( key == 'x' || key == ' ' ) //cancel and return to battle menu
        input = Input.BATTLE_MENU;
        
      if( ( key == 'q' || key == '1' ) && party.hero[battle.turn].canAffordSkill(0) )                                        { skillSelection = 0; input = appropriateInputMode(); }
      if( ( key == 'w' || key == '2' ) && party.hero[battle.turn].level >= 5  && party.hero[battle.turn].canAffordSkill(1) ) { skillSelection = 1; input = appropriateInputMode(); }
      if( ( key == 'e' || key == '3' ) && party.hero[battle.turn].level >= 10 && party.hero[battle.turn].canAffordSkill(2) ) { skillSelection = 2; input = appropriateInputMode(); }
      if( ( key == 'r' || key == '4' ) && party.hero[battle.turn].level >= 15 && party.hero[battle.turn].canAffordSkill(3) ) { skillSelection = 3; input = appropriateInputMode(); }
      if( ( key == 'a' || key == '5' ) && party.hero[battle.turn].level >= 20 && party.hero[battle.turn].canAffordSkill(4) ) { skillSelection = 4; input = appropriateInputMode(); }
      if( ( key == 's' || key == '6' ) && party.hero[battle.turn].level >= 25 && party.hero[battle.turn].canAffordSkill(5) ) { skillSelection = 5; input = appropriateInputMode(); }
      if( ( key == 'd' || key == '7' ) && party.hero[battle.turn].level >= 30 && party.hero[battle.turn].canAffordSkill(6) ) { skillSelection = 6; input = appropriateInputMode(); }
      if( ( key == 'f' || key == '8' ) && party.hero[battle.turn].level >= 35 && party.hero[battle.turn].canAffordSkill(7) ) { skillSelection = 7; input = appropriateInputMode(); }
      
      //Skips next step for targetAll skills
      if( ( input == Input.BATTLE_SKILL_TARGET || input == Input.BATTLE_HEAL_TARGET ) && party.hero[battle.turn].skill[skillSelection].targetAll )
        battle.beginAttack( battle.turn, 4 );
    }
    else if(input == Input.BATTLE_SKILL_TARGET) //Choose target of attack skill
    {
      if(      ( key == 'a' || key == 'A' || key == '1' ) && battle.list[3].active )
        battle.beginAttack( battle.turn, 3);
      else if( ( key == 's' || key == 'S' || key == '2' ) && battle.list[4].active )
        battle.beginAttack( battle.turn, 4);
      else if( ( key == 'd' || key == 'D' || key == '3' ) && battle.list[5].active )
        battle.beginAttack( battle.turn, 5);
        
      else if( key == 'x' || key == ' ' ) //cancel and return to skill menu
      {
        input = Input.BATTLE_SKILL;
        skillSelection = -1;
      }
    }
    else if(input == Input.BATTLE_HEAL_TARGET ) //Choose target of heal
    {
      if(      ( key == 'a' || key == 'A' || key == '1' )  )
        battle.beginAttack( battle.turn, 3);
      else if( ( key == 's' || key == 'S' || key == '2' ) )
        battle.beginAttack( battle.turn, 4);
      else if( ( key == 'd' || key == 'D' || key == '3' ) )
        battle.beginAttack( battle.turn, 5);
        
      else if( key == 'x' || key == ' ' ) //cancel and return to skill menu
        input = Input.BATTLE_SKILL;
    }
    else if(input == Input.BATTLE_ITEM)
    {
      if( key == 'a' ) key = '1';  if( key == 'h' ) key = '5';
      if( key == 's' ) key = '2';  if( key == 'j' ) key = '6';
      if( key == 'd' ) key = '3';  if( key == 'k' ) key = '7';
      if( key == 'f' ) key = '4';  if( key == 'l' ) key = '8';
      if( ( key == '1' || key == '2' || key == '3' || key == '4' ) && party.hasPotion(key-48) ) //used health potion and has at least one of that potion
      {
        if( key == '3' )
        {
          SFX[3].play();
          potionIndex++;
          if(potionIndex>19)potionIndex=12;
          if( party.consume(36,0) )
          {
            input = Input.BATTLE_MENU;
            battle.setBattleDelay();
            battle.resumeInitiative();
            displayTextLine("The vapors heal the party.");
          }
        }
        else
        {
          input = Input.BATTLE_ITEM_HERO_CHOICE;
          potionType = key-48;
          println("Potion Type: " + potionType);
        }
      }
      if( ( key == '5' || key == '6' || key == '7' || key == '8' ) && party.reagents >= bombCost(key-48) ) //Use Bomb
      {
        input = Input.BATTLE_ITEM_TARGET;
        potionType = key-48;
        skillSelection = potionType+3; // 8 - flame,  9 - ice, 10 - acid, 11 - thunder
        println("Potion Type: " + potionType);
      }
      if( key == 'x' || key == ' ' ) //cancel and return to battle menu
        input = Input.BATTLE_MENU;
    }
    else if(input == Input.BATTLE_ITEM_HERO_CHOICE) //choosing target hero for item
    {
      if( key == ' ' )
        input = Input.BATTLE_ITEM;
      if( key == 'a' ) key = '1'; if( key == 's' ) key = '2'; if( key == 'd' ) key = '3';
      if( key == '1' || key == '2' || key == '3' )
      {
        SFX[3].play();
        potionIndex++;
        if(potionIndex>19)potionIndex=12;
        if( party.consume(potionType*12,key-49) ) //-49 to account for array index offset
        {
          input = Input.BATTLE_MENU;
          battle.setBattleDelay();
          battle.resumeInitiative();
        }
      }
    }
    else if(input == Input.BATTLE_ITEM_TARGET) //choosing bomb
    {
      if(      ( key == 'a' || key == 'A' || key == '1' ) && battle.list[3].active )
        battle.throwBomb( battle.turn, 3);
      else if( ( key == 's' || key == 'S' || key == '2' ) && battle.list[4].active )
        battle.throwBomb( battle.turn, 4);
      else if( ( key == 'd' || key == 'D' || key == '3' ) && battle.list[5].active )
        battle.throwBomb( battle.turn, 5);
        
      else if( key == 'x' || key == ' ' ) //cancel and return to skill menu
      {
        input = Input.BATTLE_ITEM;
        potionType = -1;
      }
    }
  }
  
  //FOUND OR BOUGHT A WEAPON OR ARMOR
  else if( display == Display.EQUIP )
  {
    if( key == '1' && newEquip.usableBy(party.hero[0].job) ) //equipped to hero 1
    {
      if( newEquip.isWeapon ) //Change weapon
      {
        oldEquip = new Equipment(party.hero[0].weapon);
        party.hero[0].weapon = new Equipment( newEquip );
      }
      else                    //Change armor
      {
        oldEquip = new Equipment(party.hero[0].armor);
        party.hero[0].armor = new Equipment( newEquip );
      }
      party.inventory[newEquipIndex] = new Equipment( oldEquip );
      display = Display.MAP;
      input = input.EXPLORING;
    }
    if( key == '2' && newEquip.usableBy(party.hero[1].job) ) //equipped to hero 2
    {
      if( newEquip.isWeapon ) //Change weapon
      {
        oldEquip = new Equipment(party.hero[1].weapon);
        party.hero[1].weapon = new Equipment( newEquip );
      }
      else                    //Change armor
      {
        oldEquip = new Equipment(party.hero[1].armor);
        party.hero[1].armor = new Equipment( newEquip );
      }
      party.inventory[newEquipIndex] = new Equipment( oldEquip );
      display = Display.MAP;
      input = input.EXPLORING;
    }
    if( key == '3' && newEquip.usableBy(party.hero[2].job) ) //equipped to hero 3
    {
      if( newEquip.isWeapon ) //Change weapon
      {
        oldEquip = new Equipment(party.hero[2].weapon);
        party.hero[2].weapon = new Equipment( newEquip );
      }
      else                    //Change armor
      {
        oldEquip = new Equipment(party.hero[2].armor);
        party.hero[2].armor = new Equipment( newEquip );
      }
      party.inventory[newEquipIndex] = new Equipment( oldEquip );
      display = Display.MAP;
      input = input.EXPLORING;
    }
    if( key == 'X' ) //not equipped - left in bag
    {
      display = Display.MAP;
      input = input.EXPLORING;
    }
  }
  
  //REASONS FOR SELECTING A HERO
  else if(display == Display.HERO_SELECT && input == Input.HERO_SELECT)
  {
    //USING AN ITEM
    if( key == 'a' ) key = 49;
    if( key == 's' ) key = 50;
    if( key == 'd' ) key = 51;
    if( key == 'f' ) key = 52;
    if(consumableValue > 0)
    {
      if(key == ' ') //Return to food/potion menu
      {
        if(reason == HeroSelectReason.EAT)
          display = Display.FOOD_MENU;
        if(reason == HeroSelectReason.DRINK)
          display = Display.POTION_MENU;
        input = Input.ITEM_USE;
      }
      else if( key > 48 && key < 52 ) //eat/drink and return to map
      {
        if(reason == HeroSelectReason.EAT)
         SFX[4].play(); //foodBiteSound.rewind(); }
         
        if(reason == HeroSelectReason.DRINK)
          SFX[3].play();
        potionIndex++;
        if(potionIndex>19)potionIndex=12;
        
        party.consume(consumableValue,key-49); //-49 to account for array index offset
        consumableValue = 0;
        display = Display.MAP;
        input = Input.EXPLORING;
        reason = HeroSelectReason.NONE;
      }
    }
  }
  
  if(input == Input.TYPING) //Keys pressed are used to type a name
  {
    if(keyCode == BACKSPACE && textBuffer.length()>0 )
      textBuffer = textBuffer.substring(0,textBuffer.length()-1);
    else if(keyCode == ENTER || keyCode == RETURN)
    {
      tempName = inputText(); //takes care of changing states
      textBuffer = ""; //clears buffer
    }
    else if(key != CODED)
    {
      if(textBuffer.length()>=10)
        textBuffer = textBuffer.substring(0,9);
      textBuffer += key;
    }
  }
  if(input == Input.ADVANCE_TEXT) //waiting for player to hit space
  {
    if( key == ' ' )
      advanceNextTextLine();
  }
  
  if(key == '`') //for placing a break point
  {
    println("DEBUG"); //<>// //<>// //<>//
    println(party.X + " " + party.Y);
    println(dm[party.floor].dangerValueChar(party.X,party.Y));
  }
  
  //if(key == 'u') //for testing
    //vanGogh.startScreenShake(40,true);
  //if(key == 'l') //for testing
    //vanGogh.startScreenShake(40,false);
    //floatingNumbers.add( new GhostNumber(140,320,color(255),12345678) );
}

void keyReleased()
{ //<>//
  if( key == '1' )heroDataDisplayed[0]=false;
  if( key == '2' )heroDataDisplayed[1]=false;
  if( key == '3' )heroDataDisplayed[2]=false;
  
  if( key == 'y' )
    dangerMapOn = false;
  if( key == 'u' )
    locationMapOn = false;
  
  if( display == Display.ITEM_LIST && key == 's' )
    party.sortInventory();
  else if( previousDisplay != Display.NONE && (key == 'k' || key == 'i' || key == 'h'|| key == '`' ) )
  {
    display = previousDisplay;
    previousDisplay = Display.NONE;
  }
}

void mouseClicked()
{
  if(step==HeroCreationStep.JOB)
  {
    if     (dist(mouseX,mouseY,210+frameX,160+frameY)<62) tempJob = Job.KNIGHT;
    else if(dist(mouseX,mouseY,350+frameX,160+frameY)<62) tempJob = Job.BARBARIAN;
    else if(dist(mouseX,mouseY,490+frameX,160+frameY)<62) tempJob = Job.SAURIAN;
    
    else if(dist(mouseX,mouseY,210+frameX,300+frameY)<62) tempJob = Job.KARATE;
    else if(dist(mouseX,mouseY,350+frameX,300+frameY)<62) tempJob = Job.BARD;
    else if(dist(mouseX,mouseY,490+frameX,300+frameY)<62) tempJob = Job.THIEF;
    
    else if(dist(mouseX,mouseY,210+frameX,440+frameY)<62) tempJob = Job.DRUID;
    else if(dist(mouseX,mouseY,350+frameX,440+frameY)<62) tempJob = Job.PRIEST;
    else if(dist(mouseX,mouseY,490+frameX,440+frameY)<62) tempJob = Job.MAGE;
    
    else tempJob = Job.NONE;

    if(tempJob!=Job.NONE)
    {
      advanceText("What is "+tempName+"'s favorite color?");
      step = HeroCreationStep.COLOR;
      input = Input.HERO_COLOR_CHOICE;
    }
  }
  else if( step == HeroCreationStep.COLOR )
  {
    if( mouseX > 500+frameX && mouseX < 600+frameX && mouseY > 400+frameY && mouseY < 500+frameY ) //confirm button
    {
      tempColor = color(tempRed,tempGreen,tempBlue);
      tempInverseColor = color(tempRed2,tempGreen2,tempBlue2);
      party.hero[currentHero]=new Hero(tempName,tempJob,tempColor,tempInverseColor,tempHair,tempSkin);
      tempRed = tempGreen = tempBlue = 80;
      tempRed2 = tempGreen2 = tempBlue2 = 40;
      tempSkin = 150;
      currentHero++; 
      tempHair = currentHero+1;
      if(currentHero<3) //more heroes to create
      {
        input = Input.TYPING;
        step = HeroCreationStep.NAME;
        advanceText("What is your " + ordinalNumber(currentHero) + " hero's name?");
      }
      else  //creating heroes finished
      {
        setNameDependentText();
        vanGogh.startLocationTitleCard("Cathedral Cellar");
        step = HeroCreationStep.DONE;
        //pushTextLine("Our heroes are assembled!");
        //pushTextLine("Let the adventure begin!");
        //pushTextLine("Use (w)(a)(s)(d) or arrows to move.");
        displayTextLine("You finish intoning your prayers to the Black Vanguard. His altars are found only in dark and hidden places such as this. It is he who carries souls across the Veil, and so you ask that he treat Father Charis well when his time to depart comes. The Cathedral bells echo from above. It is time for the morning meal. Use the (w)(a)(s)(d) or arrow keys to move.");
        display = Display.MAP;
        previous = Input.EXPLORING;
        advanceNextTextLine();
      }
    }
  }
  else if( display == Display.FOOD_MENU || display == Display.POTION_MENU )
  {
     if( mouseX-frameX > 205 && mouseX-frameX < 520 && mouseY-frameY > 185 && mouseY-frameY < 230 )
     { key = '1'; keyPressed(); }
     if( mouseX-frameX > 205 && mouseX-frameX < 520 && mouseY-frameY > 265 && mouseY-frameY < 310 )
     { key = '2'; keyPressed(); }
     if( mouseX-frameX > 205 && mouseX-frameX < 520 && mouseY-frameY > 345 && mouseY-frameY < 390 )
     { key = '3'; keyPressed(); }
     if( mouseX-frameX > 205 && mouseX-frameX < 520 && mouseY-frameY > 425 && mouseY-frameY < 470 )
     { key = '4'; keyPressed(); }
     if( mouseX > 630 && mouseX < 730 && mouseY > 530 && mouseY < 630 )
     { key = ' '; keyPressed(); }
  }
}

void mousePressed()
{
  if( step == HeroCreationStep.NAME && !awaitingFileName )
  {
    if( dist(mouseX-frameX,mouseY-frameY,525-25,575-25) < 27 ) //Accept name button (realisitcally, random name button)
    {
      tempName = inputText(); //takes care of changing states
      textBuffer = ""; //clears buffer
    }
  }
  else if( step == HeroCreationStep.JOB )
  {
    if( dist(mouseX-frameX,mouseY-frameY,40,40) < 27 ) //back button
    {
      input = Input.TYPING;
      step = HeroCreationStep.NAME;
      advanceText("What is your " + ordinalNumber(currentHero) + " hero's name?");
    }
  }
  else if( step == HeroCreationStep.COLOR ) //for selecting hero colors
  {
    if( dist(mouseX-frameX,mouseY-frameY,40,40) < 27 ) //back button
    {
      advanceText("What is "+tempName+"'s Job");
      step = HeroCreationStep.JOB;
    }
    if( mouseX > 100 && mouseX < 350 && mouseY > 87.5  && mouseY < 112.5 )
      slider[0]=true;
    if( mouseX > 100 && mouseX < 350 && mouseY > 137.5 && mouseY < 162.5 )
      slider[1]=true;
    if( mouseX > 100 && mouseX < 350 && mouseY > 187.5 && mouseY < 247.5 )
      slider[2]=true;
    if( mouseX > 100 && mouseX < 350 && mouseY > 272.5 && mouseY < 297.5 )
      slider[3]=true;
    if( mouseX > 100 && mouseX < 350 && mouseY > 323.5 && mouseY < 347.5 )
      slider[4]=true;
    if( mouseX > 100 && mouseX < 350 && mouseY > 372.5 && mouseY < 397.5 )
      slider[5]=true;
    if( mouseX > 75  && mouseX < 375 && mouseY > 575   && mouseY < 600 )
      slider[6]=true;
    for(int i = 0; i < 6; i++)
    {
      if( dist( mouseX, mouseY, 62.5+75*i, 487.5 ) < 13 )
        tempHair = i;
    }
  }
  if( input == Input.HERO_SELECT || input == Input.BATTLE_ITEM_HERO_CHOICE ) //clicked on hero
  {
    if(dist( mouseX,mouseY, 150+frameX,320+frameY)<37.5) { key='1'; keyPressed(); } //<>// //<>//
    if(dist( mouseX,mouseY, 350+frameX,320+frameY)<37.5) { key='2'; keyPressed(); }
    if(dist( mouseX,mouseY, 550+frameX,320+frameY)<37.5) { key='3'; keyPressed(); }
    if( mouseX > 630 && mouseX < 730 && mouseY > 430 && mouseY < 530 ) { key=' '; keyPressed(); }
  }
  else if( display == Display.EQUIP ) //For red exit arrow - putting equipment aside for sale
  {
    if( mouseX > 630 && mouseX < 730 && mouseY > 430 && mouseY < 530 ) { key='X'; keyPressed(); }
  }
  else if( input == Input.BATTLE_SKILL ) //clicked on skill or cancel
  {
    if( mouseInBox(party.heroX(battle.turn)+75,545) ) { key = 'x'; keyPressed(); }
    if( mouseInBox(140,280) ) { key = 'q'; keyPressed(); }
    if( mouseInBox(280,280) ) { key = 'w'; keyPressed(); }
    if( mouseInBox(420,280) ) { key = 'e'; keyPressed(); }
    if( mouseInBox(560,280) ) { key = 'r'; keyPressed(); }
    if( mouseInBox(140,430) ) { key = 'a'; keyPressed(); }
    if( mouseInBox(280,430) ) { key = 's'; keyPressed(); }
    if( mouseInBox(420,430) ) { key = 'd'; keyPressed(); }
    if( mouseInBox(560,430) ) { key = 'f'; keyPressed(); }
  }
  else if( input == Input.BATTLE_SKILL_TARGET || input == Input.BATTLE_ATTACK_TARGET || input == Input.BATTLE_ITEM_TARGET ) //attacked or skill used or cancelled
  {
    if( mouseX > 40+frameX  && mouseX < 240+frameX && mouseY > 180+frameY && mouseY < 380+frameY ) { key = 'a'; keyPressed(); }
    if( mouseX > 250+frameX && mouseX < 450+frameX && mouseY > 180+frameY && mouseY < 380+frameY ) { key = 's'; keyPressed(); }
    if( mouseX > 460+frameX && mouseX < 660+frameX && mouseY > 180+frameY && mouseY < 380+frameY ) { key = 'd'; keyPressed(); }
    
    if( mouseInBox(party.heroX(battle.turn)+75,545) ) { key = 'x'; keyPressed(); }
  }
  else if( input == Input.BATTLE_HEAL_TARGET ) //heal used or cancelled
  {
    if( mouseX > 40+frameX  && mouseX < 240+frameX && mouseY > 450+frameY && mouseY < 600+frameY ) { key = 'a'; keyPressed(); }
    if( mouseX > 250+frameX && mouseX < 450+frameX && mouseY > 450+frameY && mouseY < 600+frameY ) { key = 's'; keyPressed(); }
    if( mouseX > 460+frameX && mouseX < 660+frameX && mouseY > 450+frameY && mouseY < 600+frameY ) { key = 'd'; keyPressed(); }
    
    if( mouseInBox(party.heroX(battle.turn)+75,545) ) { key = 'x'; keyPressed(); }
  }
  else if( input == Input.BATTLE_ITEM ) //clicked on potion in battle
  {
    if( mouseInBox(140,350) ) { key = '1'; keyPressed(); } //health
    if( mouseInBox(280,350) ) { key = '2'; keyPressed(); } //mana
    if( mouseInBox(420,350) ) { key = '3'; keyPressed(); } //vapor
    if( mouseInBox(560,350) ) { key = '4'; keyPressed(); } //elixir
    if( mouseInBox(210,450) ) { key = '5'; keyPressed(); } //flame
    if( mouseInBox(350,450) ) { key = '6'; keyPressed(); } //ice
    if( mouseInBox(490,450) ) { key = '7'; keyPressed(); } //acid
    if( mouseInBox(630,450) ) { key = '8'; keyPressed(); } //thunder
    if( mouseInBox(party.heroX(battle.turn)+75,545) ) { key = 'x'; keyPressed(); } 
  }
  else if( input == Input.BATTLE_MENU ) //main battle menu
  {
    float baseX = party.heroX(battle.turn);
    if( mouseInBox(baseX-75,455) ) { key = 'a'; keyPressed(); }
    if( mouseInBox(baseX+75,455) ) { key = 'd'; keyPressed(); }
    if( mouseInBox(baseX-75,545) ) { key = 's'; keyPressed(); }
    if( mouseInBox(baseX+75,545) ) { key = 'x'; keyPressed(); }
  }
  else if(input == Input.ADVANCE_TEXT && mouseInTextBox() ) //waiting for player to hit space
  {
    advanceNextTextLine();
  }
  else if( input == Input.EXPLORING )//Mouse-click controls for map exploration
  {
    switch( mouseInZone() )
    {
      case 1: showUX = !showUX; break;
      
      case 2: key = 'w'; keyPressed(); break;
      case 3: key = 'a'; keyPressed(); break;
      case 4: key = 's'; keyPressed(); break;
      case 5: key = 'd'; keyPressed(); break;
      
      case 6:
      if( m[party.floor].tiles[party.X][party.Y].obj == Object.TENT || m[party.floor].tiles[party.X][party.Y].obj == Object.BED )
        key = 'R';
      else key = 'E'; keyPressed(); break;
      case 7: key = 'D'; keyPressed(); break;
      case 8: key = 'o'; keyPressed(); break;
      case 9: key = '>'; keyPressed(); break;
      case 10:
      if( m[party.floor].tiles[party.X][party.Y].type == TileType.SHOP || m[party.floor].tiles[party.X][party.Y].type == TileType.SELL )
        key = 'B';
      else if( m[party.floor].tiles[party.X][party.Y].obj == Object.SAVEPOINT )
        key = '\u0007';
      else key = ' '; keyPressed(); break;
    }
  }
  
  //This displays hero stats if their boxes are clicked
  if( (display == Display.MAP || display == Display.BATTLE )
   && (input == Input.EXPLORING || input == Input.BATTLE_MENU ) )
  {
    if(mouseX > 4+frameX   && mouseX < 198+frameX && mouseY > 4+frameY && mouseY < 150+frameY)
      heroDataDisplayed[0]=true;
    if(mouseX > 252+frameX && mouseX < 447+frameX && mouseY > 4+frameY && mouseY < 150+frameY)
      heroDataDisplayed[1]=true;
    if(mouseX > 500+frameX && mouseX < 694+frameX && mouseY > 4+frameY && mouseY < 150+frameY)
      heroDataDisplayed[2]=true;
  }
  
  //Testing
  if(debugMode)
    println(mouseX + " " + mouseY + " " + display);
  //println("Bard:" + party.hero[1].bardBonus);
  //party.hero[2].energize(1);
  //party.hero[0].bardBonus++;
  //floatingNumbers.add( new GhostNumber( mouseX, mouseY, color(255), 888888888 ) );
}

void mouseReleased()
{
  heroDataDisplayed[0]=heroDataDisplayed[1]=heroDataDisplayed[2]=false;
  slider[0]=slider[1]=slider[2]=slider[3]=slider[4]=slider[5]=slider[6]=false;
  UIButtonClicked = -1;
}

public enum Input
{
  NONE, ADVANCE_TEXT, TYPING, EXPLORING, ITEM_USE,
  HERO_SELECT,
  BATTLE_MENU, BATTLE_ATTACK_TARGET, BATTLE_SKILL, BATTLE_SKILL_TARGET, BATTLE_HEAL_TARGET, BATTLE_ITEM, BATTLE_ITEM_HERO_CHOICE, BATTLE_ITEM_TARGET,
  HERO_JOB_CHOICE, HERO_COLOR_CHOICE
}

public enum HeroCreationStep //for the initial setup
{
  NAME, JOB, COLOR, DONE
}

public enum Display
{
  MAIN_MENU, MAP, BATTLE, KEY_LIST, ITEM_LIST, 
  FOOD_MENU, POTION_MENU, HELP_MENU, HERO_SELECT, EQUIP,
  CREDITS, NONE
}

public enum HeroSelectReason
{
  EAT, DRINK,
  NONE
}

//****************************************************************************//
//**************************************//
/*
public void changeTrack( int zone )
{
  music[currentMusic].stop();
  switch(zone)
  {
    case -1:
      nextMusic = 1;
      break;
    case 1:
      nextMusic = 6;
      break;
    case 2:
    case 8:
    case 10:
      nextMusic = 2;
      break;
    case 3:
      nextMusic = 3;
      break;
    case 4:
      nextMusic = 4;
      break;
    case 5:
      nextMusic = 5;
      break;
    case 6:
      nextMusic = 7;
      break;
    default:
      nextMusic = -1;
  }
  if(nextMusic>=0)
    music[nextMusic].loop();
  currentMusic = nextMusic;
}
*/
/*
public void beginCrossFade( int zone )
{
  crossFading = true;
  nextMusic = zone;
}

public void crossFade()
{
  if(crossFading)
  {
    volume-=.09;
    if( volume <= 0.01 )
    {
      
    }
  }
}
*/
//****************************************************************************//
//**************************************//
///Save / Load///

public void saveGame( String fileName )
{
  saveOutput = createWriter(fileName); 
  
  for (int i = 0; i < 3; i++) //Writes Hero data
  {
    saveOutput.println(party.hero[i].name);
    saveOutput.println(party.hero[i].job);
    saveOutput.println(red(party.hero[i].favColor));
    saveOutput.println(green(party.hero[i].favColor));
    saveOutput.println(blue(party.hero[i].favColor));
    saveOutput.println(red(party.hero[i].inverseColor));
    saveOutput.println(green(party.hero[i].inverseColor));
    saveOutput.println(blue(party.hero[i].inverseColor));
    saveOutput.println(party.hero[i].hairColor);
    saveOutput.println(party.hero[i].skinColor);
    saveOutput.println(party.hero[i].level);
    saveOutput.println(party.hero[i].nextLevel);
    saveOutput.println(party.hero[i].exp);
    saveOutput.println(party.hero[i].hp);
    saveOutput.println(party.hero[i].mp);
    saveOutput.println(party.hero[i].weapon.name);
    saveOutput.println(party.hero[i].weapon.imageName);
    saveOutput.println(party.hero[i].weapon.value);
    saveOutput.println(party.hero[i].weapon.power);
    saveOutput.println(party.hero[i].armor.name);
    saveOutput.println(party.hero[i].armor.imageName);
    saveOutput.println(party.hero[i].armor.value);
    saveOutput.println(party.hero[i].armor.power);
    saveOutput.println();
  } 
  
  for(int i = 0; i < savePoints.length; i++) //Writes current save point
    if(party.X==savePoints[i].X && party.Y == savePoints[i].Y)
    {
      saveOutput.println(i);
      saveOutput.println();
      break;
    }
    
  saveOutput.println(party.gold); //Writes the party's gold
  saveOutput.println(party.reagents); //Writes the party's reagents
  
  for(int i = 0; i < party.inventory.length; i++) //Writes inventory
  {
    if(party.inventory[i].value>0)
    {
      saveOutput.println(party.inventory[i].name);
      saveOutput.println(party.inventory[i].value);
    }
  }
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < party.keyInventory.length; i++) //Writes keys
    if(party.keyInventory[i]!=Key.NONE)
      saveOutput.println(party.keyInventory[i]);
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < itemSwitches.length; i++) //Writes item switches
  {
    if(itemSwitches[i]==null)
      saveOutput.println(false);
    else
      saveOutput.println(itemSwitches[i].active);
  }
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < doorSwitches.length; i++) //Writes door switches
  {
    if(doorSwitches[i]==null)
      saveOutput.println(false);
    else
      saveOutput.println(doorSwitches[i].active);
  }
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < bossSwitches.length; i++) //Writes boss switches
  {
    if(bossSwitches[i]==null)
      saveOutput.println(false);
    else
      saveOutput.println(bossSwitches[i].active);
  }
  saveOutput.println("XX");
  
  saveOutput.flush(); // Writes the remaining data to the file
  saveOutput.close(); // Finishes the file
}

public void loadFile( String fileName )
{
  String [] saveFileText;
  try
  {
    saveFileText = loadStrings(fileName+".txt");
    
    println("Loading file: "+fileName);
    
    //load hero data
    for (int i = 0, offset; i < 3; i++) 
    {
      offset = i*24;
      party.hero[i] = new Hero(saveFileText[0+offset],
                               stringToJob(saveFileText[1+offset]),
                               color(int(saveFileText[2+offset]),int(saveFileText[3+offset]),int(saveFileText[4+offset])),
                               color(int(saveFileText[5+offset]),int(saveFileText[6+offset]),int(saveFileText[7+offset])),
                               int(saveFileText[8+offset]),
                               int(saveFileText[9+offset]) );
      party.hero[i].level = int(saveFileText[10+offset]);
      party.hero[i].nextLevel = int(saveFileText[11+offset]);
      party.hero[i].exp = int(saveFileText[12+offset]);
      party.hero[i].hp = int(saveFileText[13+offset]);
      party.hero[i].mp = int(saveFileText[14+offset]);
      party.hero[i].weapon = new Equipment(saveFileText[15+offset],saveFileText[16+offset],int(saveFileText[17+offset]),true,float(saveFileText[18+offset]));
      party.hero[i].armor = new Equipment(saveFileText[19+offset],saveFileText[20+offset],int(saveFileText[21+offset]),false,int(saveFileText[22+offset]));
      party.hero[i].adjustStats(false);
      //party.hero[i].assignSkills();
    }
    
    println("Hero data loaded.");
    
    setNameDependentText();
    
    //load save point
    if(debugMode)
      println("Save point # " + int(saveFileText[72]));
    party.setPosition(savePoints[int(saveFileText[72])]); //line 54, will be based on list
    zoneNumber = savePoints[int(saveFileText[72])].zone;
    
    party.gold = int(saveFileText[74]);
    party.reagents = int(saveFileText[75]);
    
    //load inventory items
    createInventories(); //zeros out inventories - may be redundant in final version
    int fileLine = 76; //first line of inventory data
    while(!saveFileText[fileLine].equals("XX"))
    {
      party.addToInventory(new Item(saveFileText[fileLine],int(saveFileText[fileLine+1])),true);
      fileLine+=2;
    }
    fileLine+=2;
    while(!saveFileText[fileLine].equals("XX"))
    {
      party.addToInventory(new Item( stringToKey(saveFileText[fileLine])),true);
      fileLine++;
    }
    
    println("Inventory loaded.");
    
    //Set progress switches
    
    //Item switches
    fileLine+=2;
    int switchIndex=0;
    while(!saveFileText[fileLine].equals("XX"))
    {
      if(itemSwitches[switchIndex]!=null)
          itemSwitches[switchIndex].active = boolean(saveFileText[fileLine]);
      else
        itemSwitches[switchIndex].active = false;
       
      switchIndex++;
      fileLine++;
    }
    println("Item switches loaded.");
      
    //Door switches
    fileLine+=2;
    switchIndex=0;
    while(!saveFileText[fileLine].equals("XX"))
    {
      if(doorSwitches[switchIndex]!=null)
        doorSwitches[switchIndex].active = boolean(saveFileText[fileLine]);
        
      switchIndex++;
      fileLine++;
    }
    println("Door switches loaded.");
 
    //Boss switches
    fileLine+=2;
    switchIndex=0;
    while(!saveFileText[fileLine].equals("XX"))
    {
      if(bossSwitches[switchIndex]!=null)
        bossSwitches[switchIndex].active = boolean(saveFileText[fileLine]);
        
      switchIndex++;
      fileLine++;
    }
    println("Boss switches loaded.");
      
    //switchIndex=0;
    //fileLine+=2;
    //while(!saveFileText[fileLine].equals("XX") && doorSwitches[switchIndex]!=null)
    //  doorSwitches[switchIndex++].active = boolean(saveFileText[fileLine++]);
      
    //switchIndex=0;
    //fileLine+=2;
    //while(!saveFileText[fileLine].equals("XX") && bossSwitches[switchIndex]!=null)
    //  bossSwitches[switchIndex++].active = boolean(saveFileText[fileLine++]);
    
    //interacts with all progress switches
    flipSwitches(); // <- Empty switches must be NULL
    
    println("Data switched on/off.");
    
    //After load is finished, resume game
    display = Display.MAP;
    step = HeroCreationStep.DONE;
    input = Input.EXPLORING;
    //changeTrack(zoneNumber);
    println("SAVE FILE LOADED");
    advanceText("SAVE FILE LOADED");
    advanceText("Welcome back " + party.hero[0].name + ", "+party.hero[1].name+", and "+party.hero[2].name);
    //m.tiles[party.X][party.Y].obj = Object.SAVEPOINT; // <- WHY IS LOADING A SAVE FILE DELETING MY SAVE POINTS!?!? //solved
  }
  catch(Exception e)
  {
    println("SAVE FILE NOT FOUND");
    pushTextLine("New file " + fileName + " will be created.");
    pushTextLine("The Riddle of Iron begins.");
    pushTextLine("What is your first hero's name?");
    
    party.addToInventory( new Item( Key.CHARIS ) );
    
    //Begin normal character creation
    display = Display.NONE;
    step = HeroCreationStep.NAME;
    newGame = true;
    //input = Input.TYPING;
    previous = Input.TYPING;
  }
}

void flipSwitches()
{
  for(int i = 0; i < itemSwitches.length; i++)//min(itemSwitches.length,lootList[0].length); i++)
    if(itemSwitches[i]!=null && !itemSwitches[i].active) //switch has been deactivated
    {
      clearLoot(itemSwitches[i].floor,itemSwitches[i].X,itemSwitches[i].Y,i);
      if(debugMode)
        println("Item switched: "+i);
    }
  println("Item switches flipped.");
  for(int i = 0; i < doorSwitches.length; i++)
    if(doorSwitches[i]!=null && !doorSwitches[i].active) //switch has been deactivated
    {
      m[doorSwitches[i].floor].openDoorsAround(doorSwitches[i].X,doorSwitches[i].Y);
      m[doorSwitches[i].floor].tiles[doorSwitches[i].X][doorSwitches[i].Y].interactive=false; //had to add this because the interact() method normally handles it
    }
  println("Door switches flipped.");
  for(int i = 0; i < bossSwitches.length; i++)
    if(bossSwitches[i]!=null && !bossSwitches[i].active)
      m[bossSwitches[i].floor].removeBoss(bossSwitches[i].X,bossSwitches[i].Y);
  println("Boss switches flipped.");
}
