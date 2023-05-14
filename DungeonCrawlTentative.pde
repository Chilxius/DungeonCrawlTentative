//Dungeon Crawl Game
//Bennett Ritchie

//PROBLEMS:
//Fix lineLength error and problem with not printing entire line
//Fix objects getting strange tile colors
//Boss didn't drop money when killed by poison
//Improve armor pierce abilities (wow, razor is crazy)

//TO DO:
//Skills: animation system
//Make battles stop triggering on spaces with events
//Fix text in Charis's study
//Add a "holding on" mechanic to stay alive after critical damage
//animate bard bonus
//make ostinato bonus adjust well at higher levels
//add glow for regen and magic buff

//IMPROVEMENT:
//Have inns charge money?
//Delay before "vanquished" line where enemy vanishes
//Character Backs: Knight helmet/neck, Barbarian axe/legs, Karate hair, Thief cowl, Priest hair, saurian head, druid antler/staff
//Tone fixes for random text
//More random names

//IMAGES I NEED:
//skills

//NOTES:
//I edited the log class to remove spaces in text - might cause errors downstream
//I edited the log class again to not add text from an empty string
//Poison seems to be killing heroes properly
//poison dealt 1 but removed 2 (couldn't reproduce)
//I cut the value of armor in half in the code to normalize damage - might need to re-test earlier levels

//Turned sound off for the time being. Will include later with Beads
//import processing.sound.*;

int mapCount = 10;
Map [] m = new Map[mapCount];
DangerMap [] dm = new DangerMap[mapCount];

//Game begins waiting for a typed input, which will be stored as the save file name
Input input = Input.TYPING;
Input previous = Input.NONE; //Attempt to make new system work
Display display = Display.MAIN_MENU;
Display previousDisplay = Display.NONE;
HeroCreationStep step = HeroCreationStep.NAME;
HeroSelectReason reason = HeroSelectReason.NONE;

//NEW LOG SYSTEM
Logbook log = new Logbook(40);

//The text to be displayed in the box
String textLine1 = " ";
String textLine2 = " ";
String textBuffer = ""; //For when something is being typed in (character limit 10).

//Game data limits
int itemCount = 100;
int doorCount = 100;
int bossCount = 100;

//Hero Data
int currentHero = 0; //0,1,2
String tempName;
Job tempJob = Job.NONE;
color tempColor, tempInverseColor;
float tempRed=0,tempGreen=0,tempBlue=0;
boolean heroDataDisplayed[] = {false,false,false};

//Exploration Data
Party party = new Party( new Hero(false), new Hero(false), new Hero(false));
ArrayList<Portal> exits = new ArrayList<Portal>();
int zoneNumber = 1; //type of zone the party is in (mostly for music)

//UI data
Artist vanGogh;// = new Artist();
ArrayList<GhostNumber> floatingNumbers = new ArrayList<GhostNumber>();
int windowX, windowY;

//Test files
//SoundFile beep1,beep2,beep3;

//Sound effects
//SoundFile openDoorSound, openChestSound, lockedDoorSound, potionDrinkSound, foodBiteSound;

//Music
//NONE YET

//Image data
PImage tileImage[] = new PImage[100]; //I've since used this for more than just tiles
PImage battleBack[] = new PImage[10]; //Backgrounds for battles
PImage iconImage[] = new PImage[50];  //Icons for buttons, need to move some items from tileImage

//Item data
Loot [][] lootList = new Loot[4][itemCount]; //UPDATE AS FLOORS ARE ADDED!!
Loot emptyChest = new Loot(0,0,new Item(),"EMPTY CHEST ERROR");
int consumableValue = 0;
Equipment newEquip, oldEquip; //for switching in new equipment
int newEquipIndex = -1;
LootTable theStuff = new LootTable();

//Save data
String saveFileName = "";
boolean awaitingFileName = true;
boolean newGame = false;
SavePoint [] savePoints = new SavePoint[10]; //10 is temporary
SavePoint lastSave = new SavePoint(); //should defalt to starting position
boolean confirmSave = false;
ProgressSwitch itemSwitches[] = new ProgressSwitch[itemCount]; //don't know how big this will get
ProgressSwitch doorSwitches[] = new ProgressSwitch[doorCount]; //or this
ProgressSwitch bossSwitches[] = new ProgressSwitch[bossCount];  //or, in fact, this
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

PrintWriter saveOutput;

boolean gameover = false;

void setup()
{
  //fullScreen();
  size(700,700);
  frameRate(60);
  surface.setTitle("THE RIDDLE OF IRON");
  vanGogh = new Artist();
  windowX = displayWidth/2-width/2;
  windowY = displayHeight/2-height/2;
  surface.setLocation(windowX, windowY);
  
  newEquip = new Equipment();
  oldEquip = new Equipment();
  
  zoo = new Beastiary();
  
  //Setting up image files (MOVE THIS TO Artist)
  tileImage[0] = loadImage("wall.png"); tileImage[0].resize(30,0);
  tileImage[1] = loadImage("tree.png"); tileImage[1].resize(40,40);
  tileImage[2] = loadImage("darkTree.png"); tileImage[2].resize(40,40);
  tileImage[3] = loadImage("flower.png"); tileImage[3].resize(30,0);
  for(int i = 1; i <= 16; i++)
  { tileImage[3+i] = loadImage("water"+i+".png"); tileImage[3+i].resize(30,0); }
  for(int i = 1; i <= 8; i++)
  { tileImage[19+i] = loadImage("save"+i+".png"); tileImage[19+i].resize(40,0); }
  tileImage[28] = loadImage("barrel.png"); tileImage[28].resize(30,0);
  tileImage[29] = loadImage("barrelEmpty.png"); tileImage[29].resize(30,0);
  tileImage[30] = loadImage("chest.png"); tileImage[30].resize(30,0);
  tileImage[31] = loadImage("chestBone.png"); tileImage[31].resize(30,0);
  tileImage[32] = loadImage("chestDark.png"); tileImage[32].resize(30,0);
  tileImage[33] = loadImage("chestGold.png"); tileImage[33].resize(30,0);
  tileImage[34] = loadImage("chestSilver.png"); tileImage[34].resize(30,0);
  tileImage[35] = loadImage("chestSnow.png"); tileImage[35].resize(30,0);
  tileImage[36] = loadImage("sign.png"); tileImage[36].resize(30,0);
  tileImage[37] = loadImage("signUsed.png"); tileImage[37].resize(30,0);
  tileImage[38] = loadImage("door.png"); tileImage[38].resize(30,0);
  tileImage[39] = loadImage("doorDouble.png"); tileImage[39].resize(30,0);
  tileImage[40] = loadImage("portcullis.png"); tileImage[40].resize(30,0);
  tileImage[41] = loadImage("gateCemetery.png"); tileImage[41].resize(30,0);
  tileImage[42] = loadImage("grave.png"); tileImage[42].resize(30,0);
  tileImage[43] = loadImage("stainedGlass.png"); tileImage[43].resize(30,0);
  tileImage[44] = loadImage("treeDead.png"); tileImage[44].resize(45,40);
  tileImage[45] = loadImage("wallDark.png"); tileImage[45].resize(30,0);
  tileImage[46] = loadImage("wallSand.png"); tileImage[46].resize(30,0);
  tileImage[47] = loadImage("treePath.png"); tileImage[47].resize(40,40);
  tileImage[48] = loadImage("merchant.png"); tileImage[48].resize(30,0);
  tileImage[49] = loadImage("wallDark.png"); tileImage[49].resize(30,0);
  tileImage[50] = loadImage("wallSand.png"); tileImage[50].resize(30,0);
  tileImage[51] = loadImage("StoneGargoyle.png"); tileImage[51].resize(30,0);
  tileImage[52] = loadImage("BlackGargoyle.png"); tileImage[52].resize(30,0);
  tileImage[53] = loadImage("JadeGargoyle.png"); tileImage[53].resize(30,0);
  tileImage[54] = loadImage("portcullis.png"); tileImage[54].resize(30,0);
  tileImage[55] = loadImage("tent.png"); tileImage[55].resize(30,0);
  tileImage[56] = loadImage("stairs.png"); tileImage[56].resize(30,0);
  tileImage[57] = loadImage("wood.png"); tileImage[57].resize(30,0);
  tileImage[58] = loadImage("woodDark.png"); tileImage[58].resize(30,0);
  tileImage[59] = loadImage("woodLight.png"); tileImage[59].resize(30,0);
  tileImage[60] = loadImage("WhiteWerewolf.png"); tileImage[60].resize(30,0);
  tileImage[61] = loadImage("chestGold.png"); tileImage[61].resize(30,0);
  tileImage[62] = loadImage("chestDark.png"); tileImage[62].resize(30,0);
  tileImage[63] = loadImage("SignEquipment.png"); tileImage[63].resize(30,0);
  tileImage[64] = loadImage("SignFood.png"); tileImage[64].resize(30,0);
  tileImage[65] = loadImage("SignPotion.png"); tileImage[65].resize(30,0);
  tileImage[66] = loadImage("SignInn.png"); tileImage[66].resize(30,0);
  tileImage[67] = loadImage("rubble.png"); tileImage[67].resize(40,0);
  tileImage[68] = loadImage("Sack.png"); tileImage[68].resize(50,0);
  tileImage[69] = loadImage("caveBrown2.png"); tileImage[69].resize(30,0);
  tileImage[70] = loadImage("caveGray.png"); tileImage[70].resize(30,0);
  tileImage[71] = loadImage("treeDead4.png"); tileImage[71].resize(45,40);
  tileImage[72] = loadImage("TileRoof3.png"); tileImage[72].resize(30,34);
  tileImage[73] = loadImage("crops.png"); tileImage[73].resize(30,30);
  tileImage[74] = loadImage("TileRoofBlue.png"); tileImage[74].resize(30,34);
  tileImage[75] = loadImage("bookshelf2.png"); tileImage[75].resize(30,30);
  tileImage[76] = loadImage("bookshelfEmpty.png"); tileImage[76].resize(30,30);
  tileImage[77] = loadImage("bed2.png"); tileImage[77].resize(30,30);
  tileImage[78] = loadImage("blackBook.png"); tileImage[78].resize(20,0);
  tileImage[79] = loadImage("chestBone.png"); tileImage[79].resize(30,0);
  tileImage[80] = loadImage("blueBook.png"); tileImage[80].resize(20,0);
  tileImage[81] = loadImage("brokenGlass.png"); tileImage[81].resize(90,0);
  tileImage[82] = loadImage("Bread.png"); tileImage[82].resize(30,0);
  tileImage[83] = loadImage("Meat.png"); tileImage[83].resize(30,0);
  tileImage[84] = loadImage("Fruit.png"); tileImage[84].resize(30,0);
  tileImage[85] = loadImage("Crab.png"); tileImage[85].resize(30,0);
  tileImage[86] = loadImage("wallDarkCracked.png"); tileImage[86].resize(30,0);
  tileImage[87] = loadImage("stairsWood.png"); tileImage[87].resize(30,0);
  tileImage[88] = loadImage("crate2.png"); tileImage[88].resize(30,0);
  tileImage[89] = loadImage("crate.png"); tileImage[89].resize(30,0);
  tileImage[90] = loadImage("potionGreen.png");  tileImage[90].resize(56,0);
  tileImage[91] = loadImage("potionBlue.png");   tileImage[91].resize(56,0);
  tileImage[92] = loadImage("potionYellow.png"); tileImage[92].resize(56,0);
  tileImage[93] = loadImage("potionRed.png");    tileImage[93].resize(56,0);
  
  iconImage[0] = loadImage("buckler_main.png");     iconImage[0].resize(56,0);
  iconImage[1] = loadImage("buckler_color.png");    iconImage[1].resize(58,0);
  iconImage[2] = loadImage("heater_main2.png");     iconImage[2].resize(56,0);
  iconImage[3] = loadImage("heater_primary.png");   iconImage[3].resize(58,0);
  iconImage[4] = loadImage("heater_secondary.png"); iconImage[4].resize(58,0);
  iconImage[5] = loadImage("scale_primary.png");    iconImage[5].resize(56,0);
  iconImage[6] = loadImage("scale_secondary.png");  iconImage[6].resize(56,0);
  
  battleBack[0] = loadImage("forest5.png"); //resize?esize(56,0);
  battleBack[1] = loadImage("stoneWall.png"); //resize?
  battleBack[2] = loadImage("graveyard4.png"); //resize?
  battleBack[3] = loadImage("cave.png"); //resize?
  
  //Test sounds
  //beep1 = new SoundFile(this, "Beep1.mp3"); //Short high
  //beep2 = new SoundFile(this, "Beep2.mp3"); //Short low
  //beep3 = new SoundFile(this, "Beep3.mp3"); //Long high
  //beep3.cue(5.0);
  
  //Sound effects
  //openDoorSound = new SoundFile(this, "lock.mp3");
  //openChestSound = new SoundFile(this, "chest.mp3");
  //lockedDoorSound = new SoundFile(this, "jiggle.mp3");
  //foodBiteSound = new SoundFile(this, "bite.mp3");
  //potionDrinkSound = new SoundFile(this, "gulp.mp3");

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
}


void draw()
{
  if(vanGogh.screenShaking)
    vanGogh.shakeScreen();
  
  background(0);
  if(display == Display.MAIN_MENU)
    vanGogh.drawMainMenu();

  vanGogh.drawTextBoxes(input,textBuffer,textLine1,textLine2);
  
  if( step == HeroCreationStep.DONE || step == HeroCreationStep.NAME )
  {
    vanGogh.drawHeroBoxes( party.hero );
    drawConditions(); // <- move to drawHeroBoxes
  }
  
  //Hero creation process only
  if(step == HeroCreationStep.JOB)
    vanGogh.drawJobChoices(currentHero);
  else if(step == HeroCreationStep.COLOR)
    vanGogh.drawColorBars(tempRed,tempGreen,tempBlue);
    
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
  
  if(heroDataDisplayed[0]||heroDataDisplayed[1]||heroDataDisplayed[2])
  {
    if     (heroDataDisplayed[0]) vanGogh.drawHeroData(0);
    else if(heroDataDisplayed[1]) vanGogh.drawHeroData(1);
    else if(heroDataDisplayed[2]) vanGogh.drawHeroData(2);
  }

  if(input==Input.ADVANCE_TEXT)
    vanGogh.drawAdvanceTextPrompt();
    
  if(vanGogh.resting)
    vanGogh.drawRestFadeout();
  
  //Advance any animations
  vanGogh.animate();
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
    { //<>// //<>//
      step = HeroCreationStep.JOB;
      input = Input.HERO_JOB_CHOICE; //<>// //<>// //<>//
      if(textBuffer.equals(""))
        textBuffer = randomName();
      advanceText("Select "+textBuffer+"'s Job");
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
      if(party.X > 0 && m[party.floor].tilePathable(party.X-1,party.Y))
      {  party.X--; checkEvent(); result = true; } break;
    case "right":
      if(party.X < 99 && m[party.floor].tilePathable(party.X+1,party.Y))
      {  party.X++; checkEvent(); result = true; } break;
    case "up":
      if(party.Y > 0 && m[party.floor].tilePathable(party.X,party.Y-1))
      { party.Y--; checkEvent(); result = true; } break;
    case "down":
      if(party.Y < 99 && m[party.floor].tilePathable(party.X,party.Y+1))
      {  party.Y++; checkEvent(); result = true; } break;
  }
  
  vanGogh.checkLocationForTitleCard( party.floor, party.X, party.Y );
  
  if( result && checkForBattle() )
    triggerBattle(dm[party.floor].dangerValueChar(party.X,party.Y));
  
  return result;
}

void checkEvent()
{
  if(m[party.floor].tileHasEvent(party.X,party.Y))
  {
    println("PLAY EVENT");
    m[party.floor].tiles[party.X][party.Y].playEvent();
  }
}

boolean checkForBattle()
{
  if(random(100)<randomBattleCounter)
  {
    randomBattleCounter = -10;
    return true;
  }
  
  println(zoneNumber);
  //println(randomBattleCounter + "  DL:" +dm[party.floor].dangerValueChar(party.X,party.Y));
  //println(m[1].tiles[40][4].occupantText);
  randomBattleCounter++;
  
  if(randomBattleCounter > 0 && randomBattleCounter % 5 == 0)
    party.tickDownPoisons();
  
  return false;
}
  
public String randomName()
{
  switch( int(random(52)) )
  {
    case 1: return "Angel";    case 26: return "Alex";     case 42: return "Ash";
    case 2: return "Björn";    case 27: return "Briar";
    case 3: return "Cadell";   case 28: return "Colette";
    case 4: return "Darya";    case 29: return "Draco";    case 51: return "Dirk";
    case 5: return "Enyo";     case 30: return "Elwyn";
    case 6: return "Fritjof";  case 31: return "Faith";
    case 7: return "Gunhild";  case 32: return "Gale";
    case 8: return "Homer";    case 33: return "Hana";
    case 9: return "Inola";    case 34: return "Ivan";
    case 10: return "Joy";     case 35: return "Jazz";
    case 11: return "Kai";     case 36: return "Kim";
    case 12: return "Leocadia";case 37: return "Law";
    case 13: return "Marc";    case 38: return "Misty";
    case 14: return "Nadya";   case 39: return "Neon";
    case 15: return "Orion";   case 40: return "Olga";
    case 16: return "Phoenix"; case 41: return "Penelope";
    case 17: return "Quinn";   
    case 18: return "Raven";   case 43: return "Rook";
    case 19: return "Sky";     case 44: return "Spike";
    case 20: return "Tybalt";  case 45: return "Tabitha";
    case 21: return "Ursa";    case 46: return "Ulric";
    case 22: return "Vela";    case 47: return "Vulcan";
    case 23: return "Wystan";  case 48: return "Willow";
    case 24: return "Xena";    case 49: return "Xia";
    case 25: return "Yoko";    case 50: return "Yin";
    default: return "Zazi";
  }
}

String bonkText( char direction ) //for when the heroes run into obstacles
{                                  //also handles boss activation
  int x = party.X, y = party.Y;
  
  //party tried to move off the map
  if( direction == 'l'){ x--; if(x<0)return"BONK";}
  else if( direction == 'r'){ x++; if(x>=m[0].tiles.length)return"BONK";}
  else if( direction == 'u'){ y--; if(y<0)return"BONK";}
  else if( direction == 'd'){ y++; if(y>=m[0].tiles[0].length)return"BONK";}
  
  switch( m[party.floor].tiles[x][y].type )
  {
    case WALL:
    case SAND_WALL:
    case DARK_WALL: return "Solid stone";
    case WATER: return "You never learned how to swim";
    case TREE: case DARK_TREE: return "A tree";
    case PORTCULLIS:
    case DOOR_GATE:
    case DOOR: return m[party.floor].tiles[party.X][party.Y].keyMessage();
    case BLACK_WALL: return "An unlit wall";
    case GARGOYLE_JADE: return "A gargoyle carved of jade";
    case GARGOYLE_DARK: return "An image of the Black Vanguard";
    case GARGOYLE: return "A beautiful gargoyle statue";
    case WEREWOLF_WHITE: return "A gargoyle statue...?";
    case S_GLASS: return "A beautiful stained glass window";
    case RUBBLE_OBJ: return "Rubble blocks the way";
    case CRATE_OBJ: return "A heavy crate";
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
  //if(m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST)
  //  openChestSound.play();
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
    println("BATTLE NOT TRIGGERED");
    println("Danger Rating: " + danger);
    println("Tile Type: " + m[party.floor].tiles[party.X][party.Y].type);
  }
  else
  {
    vanGogh.beginBattleAnimation();
    display = Display.BATTLE;
    input = Input.NONE;
    battle = new Battle(party.hero,dm[party.floor].dangerValueChar(party.X,party.Y),-1);
  }
}

public void changeMap()
{
  for(int i = 0; i < exits.size(); i++)
    if(exits.get(i).originX == party.X
    && exits.get(i).originY == party.Y 
    && exits.get(i).originFloor == party.floor )
    {
      party.X = exits.get(i).destinationX;
      party.Y = exits.get(i).destinationY;
      party.floor = exits.get(i).destinationFloor;
      vanGogh.startLocationTitleCard(exits.get(i).title);
      return;
    }
  println("ERROR: NO EXIT FOUND");
}

boolean mouseInBox( float boxX, float boxY ) //assumes boxes are 70x70
{
  if( mouseX > boxX-35 && mouseX < boxX+35 && mouseY > boxY-35 && mouseY < boxY+35 )
    return true;
  return false;
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
      
    //First rat dungeon
    case "The West Cellar":
      return 2;
      
    //Irohill forest and well cave
    case "Irohill Forest":
      return 3;
      
    //Irohill city
    case "Irohill":
    case "Irohill Inn":
    case "Irohill Garrison":
    case "Irohill Town Hall":
    case "Hideout":
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
      return 7;
      
    //Library
    case "Irohill Library":
      return 8;
      
    //Barracuda Queen
    case "The Barracuda Queen":
    case "Forecastle Deck":
    case "Main Deck":
    case "Quartereck":
    case "Captain's Cabin":
    case "Wardroom":
    case "Forecastle":
      return 9;
      
    //Caves
    case "Cenote":
      return 10;
      
    //Temples of Ritisu
    case "Temple of Ritisu":
      return 6;
      
    //Silent Zones
    default: return 0;
  }
}
  
Input appropriateInputMode()
{
  if( party.hero[battle.turn].skill[skillSelection].healing )
    return Input.BATTLE_HEAL_TARGET;
  return Input.BATTLE_SKILL_TARGET;
}

void keyPressed()
{
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
    if(key == 's' || keyCode == DOWN || key == '5' || key == '2')
      if(!attemptMove("down")&&display!=Display.BATTLE)displayTextLine(bonkText('d'));
    if(key == 'w' || keyCode == UP || key == '8')
      if(!attemptMove("up")&&display!=Display.BATTLE)displayTextLine(bonkText('u'));
    
    if(key == '>' || key == '9') //Changing floors
      if(m[party.floor].isStair(party.X,party.Y))
      //if(m[party.floor].tiles[party.X][party.Y].type==TileType.STAIR || m[party.floor].tiles[party.X][party.Y].type==TileType.STAIR_DOOR)
        changeMap();
    
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
    
    if(display == Display.MAP && key == 'z') //testing
    {
      party.hero[0].takeDamage(5,true);
      party.hero[1].takeDamage(5,true);
      party.hero[2].takeDamage(5,true);
    }
  }
  //ITEM USE INPUT
  else if(input == Input.ITEM_USE)
  {
    if(key == 'a') key = 49; //convert
    if(key == 's') key = 50; //to
    if(key == 'd') key = 51; //numbers
    if(key == 'f') key = 52; //<>// //<>//
    
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
        battle.setBattleDelay();
        battle.resumeInitiative();
      }
      
      if( key == 's')
        input = Input.BATTLE_SKILL;
        
      if( key == 'x')
        input = Input.BATTLE_ITEM;
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
        
      if( ( key == 'q' || key == '1' ) && party.hero[battle.turn].canAffordSkill(0) )                                       { skillSelection = 0; input = appropriateInputMode(); }
      if( ( key == 'w' || key == '2' ) && party.hero[battle.turn].canAffordSkill(1) && party.hero[battle.turn].level >= 5 ) { skillSelection = 1; input = appropriateInputMode(); }
      if( ( key == 'e' || key == '3' ) && party.hero[battle.turn].canAffordSkill(2) && party.hero[battle.turn].level >= 10 ){ skillSelection = 2; input = appropriateInputMode(); }
      if( ( key == 'r' || key == '4' ) && party.hero[battle.turn].canAffordSkill(3) && party.hero[battle.turn].level >= 15 ){ skillSelection = 3; input = appropriateInputMode(); }
      if( ( key == 'a' || key == '5' ) && party.hero[battle.turn].canAffordSkill(4) && party.hero[battle.turn].level >= 20 ){ skillSelection = 4; input = appropriateInputMode(); }
      if( ( key == 's' || key == '6' ) && party.hero[battle.turn].canAffordSkill(5) && party.hero[battle.turn].level >= 25 ){ skillSelection = 5; input = appropriateInputMode(); }
      if( ( key == 'd' || key == '7' ) && party.hero[battle.turn].canAffordSkill(6) && party.hero[battle.turn].level >= 30 ){ skillSelection = 6; input = appropriateInputMode(); }
      if( ( key == 'f' || key == '8' ) && party.hero[battle.turn].canAffordSkill(7) && party.hero[battle.turn].level >= 35 ){ skillSelection = 7; input = appropriateInputMode(); }
      
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
      if( key == 'a' ) key = '1';
      if( key == 's' ) key = '2';
      if( key == 'd' ) key = '3';
      if( key == 'f' ) key = '4';
      if( ( key == '1' || key == '2' || key == '3' || key == '4' ) && party.hasPotion(key-48) ) //used health potion and has at least one of that potion
      {
        if( key == '3' )
        {
          //potionDrinkSound.play();
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
          //println("Potion Type: " + potionType);
        }
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
        //potionDrinkSound.play();
        if( party.consume(potionType*12,key-49) ) //-49 to account for array index offset
        {
          input = Input.BATTLE_MENU;
          battle.setBattleDelay();
          battle.resumeInitiative();
        }
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
        //if(reason == HeroSelectReason.EAT)
          //foodBiteSound.play();
         
        //if(reason == HeroSelectReason.DRINK)
          //potionDrinkSound.play();
         
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
    println(party.X + " " + party.Y); //<>//
    println(dm[party.floor].dangerValueChar(party.X,party.Y));
  }
  
  //if(key == 'u') //for testing
    //vanGogh.startScreenShake(40,true);
  //if(key == 'l') //for testing
    //vanGogh.startScreenShake(40,false);
    //floatingNumbers.add( new GhostNumber(140,320,color(255),12345678) );
}
 //<>//
void keyReleased()
{ //<>// //<>//
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
    if     (dist(mouseX,mouseY,210,160)<62) tempJob = Job.KNIGHT;
    else if(dist(mouseX,mouseY,350,160)<62) tempJob = Job.BARBARIAN;
    else if(dist(mouseX,mouseY,490,160)<62) tempJob = Job.SAURIAN;
    
    else if(dist(mouseX,mouseY,210,300)<62) tempJob = Job.KARATE;
    else if(dist(mouseX,mouseY,350,300)<62) tempJob = Job.BARD;
    else if(dist(mouseX,mouseY,490,300)<62) tempJob = Job.THIEF;
    
    else if(dist(mouseX,mouseY,210,440)<62) tempJob = Job.DRUID;
    else if(dist(mouseX,mouseY,350,440)<62) tempJob = Job.PRIEST;
    else if(dist(mouseX,mouseY,490,440)<62) tempJob = Job.MAGE;
    
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
    if( mouseX > 300 && mouseX < 400 && mouseY > 462.5 && mouseY < 537.5 )
    {
      tempColor = color(tempRed,tempGreen,tempBlue);
      tempInverseColor = color((255-tempRed)*.65,(255-tempGreen)*.65,(255-tempBlue)*.65);
      party.hero[currentHero]=new Hero(tempName,tempJob,tempColor,tempInverseColor);
      tempRed = tempGreen = tempBlue = 0;
      currentHero++; 
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
        displayTextLine("You finish intoning your prayers to the Black Vanguard. His altars are found only in hidden and dark places such as this. It is he who carries souls across the Veil, and so you ask that he treat Father Charis well when his time to depart comes. The Cathedral bells echo from above. It is time for the morning meal. Use the (w)(a)(s)(d) or arrow keys to move.");
        display = Display.MAP;
        previous = Input.EXPLORING;
        advanceNextTextLine();
      }
    }
  }
  else if( display == Display.FOOD_MENU || display == Display.POTION_MENU )
  {
     if( mouseX > 205 && mouseX < 520 && mouseY > 185 && mouseY < 230 )
     { key = '1'; keyPressed(); }
     if( mouseX > 205 && mouseX < 520 && mouseY > 265 && mouseY < 310 )
     { key = '2'; keyPressed(); }
     if( mouseX > 205 && mouseX < 520 && mouseY > 345 && mouseY < 390 )
     { key = '3'; keyPressed(); }
     if( mouseX > 205 && mouseX < 520 && mouseY > 425 && mouseY < 470 )
     { key = '4'; keyPressed(); }
  }
}

void mousePressed()
{
  if( step == HeroCreationStep.COLOR ) //for selecting hero colors
  {
    if( mouseX > 100 && mouseX < 600 && mouseY >290 && mouseY < 310 )
      tempRed = (mouseX-100)/2;
    if( mouseX > 100 && mouseX < 600 && mouseY >340 && mouseY < 360 )
      tempGreen = (mouseX-100)/2;
    if( mouseX > 100 && mouseX < 600 && mouseY >390 && mouseY < 410 )
      tempBlue = (mouseX-100)/2;
  }
  if( input == Input.HERO_SELECT || input == Input.BATTLE_ITEM_HERO_CHOICE ) //clicked on hero
  {
    if(dist( mouseX,mouseY, 150,320)<37.5) { key='1'; keyPressed(); }
    if(dist( mouseX,mouseY, 350,320)<37.5) { key='2'; keyPressed(); }
    if(dist( mouseX,mouseY, 550,320)<37.5) { key='3'; keyPressed(); }
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
  else if( input == Input.BATTLE_SKILL_TARGET || input == Input.BATTLE_HEAL_TARGET ||input == Input.BATTLE_ATTACK_TARGET ) //attacked or healed or skill used or cancelled
  {
    if( mouseX > 40 && mouseX < 240 && mouseY > 180 && mouseY < 380 ) { key = 'a'; keyPressed(); }
    if( mouseX > 250 && mouseX < 450 && mouseY > 180 && mouseY < 380 ) { key = 's'; keyPressed(); }
    if( mouseX > 460 && mouseX < 660 && mouseY > 180 && mouseY < 380 ) { key = 'd'; keyPressed(); }
    
    if( mouseInBox(party.heroX(battle.turn)+75,545) ) { key = 'x'; keyPressed(); }
  }
  else if( input == Input.BATTLE_ITEM ) //clicked on potion in battle
  {
    if( mouseInBox(140,380) ) { key = '1'; keyPressed(); }
    if( mouseInBox(280,380) ) { key = '2'; keyPressed(); }
    if( mouseInBox(420,380) ) { key = '3'; keyPressed(); }
    if( mouseInBox(560,380) ) { key = '4'; keyPressed(); }
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
  
  //This displays hero stats if their boxes are clicked
  if( (display == Display.MAP || display == Display.BATTLE )
   && (input == Input.EXPLORING || input == Input.BATTLE_MENU ) )
  {
    if(mouseX > 4 && mouseX < 198 && mouseY > 4 && mouseY < 150)
      heroDataDisplayed[0]=true;
    if(mouseX > 252 && mouseX < 447 && mouseY > 4 && mouseY < 150)
      heroDataDisplayed[1]=true;
    if(mouseX > 500 && mouseX < 694 && mouseY > 4 && mouseY < 150)
      heroDataDisplayed[2]=true;
  }

  //Testing
  println(mouseX + " " + mouseY);
  //println("Bard:" + party.hero[1].bardBonus);
  //party.hero[2].energize(1);
  //floatingNumbers.add( new GhostNumber( mouseX, mouseY, color(255), 888888888 ) );
}

void mouseReleased()
{
  heroDataDisplayed[0]=heroDataDisplayed[1]=heroDataDisplayed[2]=false;
}

public enum Input
{
  NONE, ADVANCE_TEXT, TYPING, EXPLORING, ITEM_USE,
  HERO_SELECT,
  BATTLE_MENU, BATTLE_ATTACK_TARGET, BATTLE_SKILL, BATTLE_SKILL_TARGET, BATTLE_HEAL_TARGET, BATTLE_ITEM, BATTLE_ITEM_HERO_CHOICE,
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
      offset = i*19;
      party.hero[i] = new Hero(saveFileText[0+offset],
                               stringToJob(saveFileText[1+offset]),
                               color(int(saveFileText[2+offset]),int(saveFileText[3+offset]),int(saveFileText[4+offset])),
                               color(255-int(saveFileText[2+offset]),255-int(saveFileText[3+offset]),255-int(saveFileText[4+offset])));
      party.hero[i].level = int(saveFileText[5+offset]);
      party.hero[i].nextLevel = int(saveFileText[6+offset]);
      party.hero[i].exp = int(saveFileText[7+offset]);
      party.hero[i].hp = int(saveFileText[8+offset]);
      party.hero[i].mp = int(saveFileText[9+offset]);
      party.hero[i].weapon = new Equipment(saveFileText[10+offset],saveFileText[11+offset],int(saveFileText[12+offset]),true,float(saveFileText[13+offset]));
      party.hero[i].armor = new Equipment(saveFileText[14+offset],saveFileText[15+offset],int(saveFileText[16+offset]),false,int(saveFileText[17+offset]));
      party.hero[i].adjustStats(false);
      //party.hero[i].assignSkills();
    }
    
    println("Hero data loaded.");
    
    setNameDependentText();
    
    //load save point
    println("Save point # " + int(saveFileText[57]));
    party.setPosition(savePoints[int(saveFileText[57])]); //line 54, will be based on list
    zoneNumber = savePoints[int(saveFileText[57])].zone;
    
    party.gold = int(saveFileText[59]);
    
    //load inventory items
    createInventories(); //zeros out inventories - may be redundant in final version
    int fileLine = 60; //first line of inventory data
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
