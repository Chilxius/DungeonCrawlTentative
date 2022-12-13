//Basic Dungeon Crawl Game
//Bennett Ritchie

/*TO FIX:
  Single-line message signs force player to search
*/

import processing.sound.*;

Map [] m = new Map[3];
DangerMap dm;

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
//String [] textQueue = new String[50]; //Does Processing have a Queue structure?
String textBuffer = ""; //For when something is being typed in (character limit 10).

//Hero Data
//Hero [] hero = {new Hero(false),new Hero(false),new Hero(false)};
int currentHero = 0; //0,1,2
String tempName;
Job tempJob = Job.NONE;
color tempColor, tempInverseColor;
float tempRed=0,tempGreen=0,tempBlue=0;
boolean heroDataDisplayed[] = {false,false,false};

//Exploration Data
Party party = new Party( new Hero(false), new Hero(false), new Hero(false));

//UI data
Artist vanGogh = new Artist();

//Image data
PImage tileImage[] = new PImage[48];

//Sound data - still testing
public SoundFile beep1,beep2,beep3;
public SoundFile openDoorSound, openChestSound, lockedDoorSound, potionDrinkSound, foodBiteSound;

//Item data
Loot [][] lootTable = new Loot[1][50];
Loot emptyChest = new Loot(0,0,new Item(),"EMPTY CHEST ERROR");
int consumableValue = 0;

//Save data
String saveFileName = "";
boolean awaitingFileName = true;
boolean newGame = false;
SavePoint [] savePoints = new SavePoint[10]; //10 is temporary
SavePoint lastSave = new SavePoint(); //should defalt to starting position
boolean confirmSave = false;
//boolean [] progressSwitch = new boolean[100]; //don't know how big this will get
ProgressSwitch itemSwitches[] = new ProgressSwitch[100]; //don't know how big this will get
ProgressSwitch doorSwitches[] = new ProgressSwitch[100]; //or this
static int itemSwitchCount = 0;
static int doorSwitchCount = 0;

//Battle Data
Battle battle;
Beastiary zoo;// = new Beastiary();
int randomBattleCounter = 0;
Monster battleMonsters[];// = new Monster[3];
int potionType = 0; //potion being drunk

PrintWriter saveOutput;

void setup()
{
  size(700,700);
  
  zoo = new Beastiary();
  
  //Setting up image files
  tileImage[0] = loadImage("wall.png"); tileImage[0].resize(30,0);
  tileImage[1] = loadImage("tree.png"); tileImage[1].resize(40,40);
  tileImage[2] = loadImage("darkTree.png"); tileImage[2].resize(40,40);
  tileImage[3] = loadImage("flower.png"); tileImage[3].resize(30,0);
  for(int i = 1; i <= 16; i++)
  {  tileImage[3+i] = loadImage("water"+i+".png"); tileImage[3+i].resize(30,0);}
  for(int i = 1; i <= 8; i++)
  {  tileImage[19+i] = loadImage("save"+i+".png"); tileImage[19+i].resize(40,0);}
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
  
  beep1 = new SoundFile(this, "Beep1.mp3"); //Short high
  beep2 = new SoundFile(this, "Beep2.mp3"); //Short low
  beep3 = new SoundFile(this, "Beep3.mp3"); //Long high
  beep3.cue(5.0);
  // .amp(1.0) for volume
  openDoorSound = new SoundFile(this, "lock.mp3");
  openChestSound = new SoundFile(this, "chest.mp3");
  lockedDoorSound = new SoundFile(this, "jiggle.mp3");
  foodBiteSound = new SoundFile(this, "bite.mp3");
  potionDrinkSound = new SoundFile(this, "gulp.mp3");

  createInventories();
  setUpLootTable();
    
  //party.keyInventory[0] = Key.SKELETON_KEY;
  
  party.inventory[0] = new Item( "Potion", 12 );
  party.inventory[4] = new Item( "Bread", 10 );
  party.inventory[6] = new Item( "Pork", 20 );
  party.inventory[14] = new Item( "Bread", 10 );
  party.inventory[20] = new Item( "Bread", 10 );
  party.inventory[15] = new Item( "Fruit", 30 );
  party.inventory[25] = new Item( "Crab", 40 );
  party.inventory[10] = new Item( "Health Potion", 12 );
  party.inventory[21] = new Item( "Mana Potion", 24 );
  party.inventory[13] = new Item( "Vapor Potion", 36 );
  party.inventory[8] = new Item( "Elixer", 48 );
  
  party.setPosition(2,1);
  
  //Key:  D-dark tree    T-tree    t-secret tree    #-wall    =-chest    ?-sign    *-save crystal
  //      +-locked door  .-safe path  w-water       g-grave   &-stained glass
  //      c-copper key   i-iron key

  //String testMapString = "#####################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  ##########################################################################################################################################################################################################                                                                                                  ######################################################################################################                                                                                                  #####################################################################################################";
  String testMapString = "";
  testMapString += "D########T~~tt~~t~~~~T~~~~~~~~~~~~~~~~~~~~~~~TTTTT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "##.?.?.?############~~~%%%%%%%%%~~~~~~~~###~~~TTTT#######                                          ~";
  testMapString += "#.....?*.#.....=.==#~~~%%%www%%%~~~~T~~~#=#~~~~TTT#&&&&&#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#?.......###.#######~~~%%%%%%%%%~~~~~~~~#+#~~T~~TT############~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#..........?......c+......~?~............c.......i+       s+=                                      ~";
  testMapString += "#=.?.=..........?.?#~~~~~.....~~~~~~~~~~%.%~T~~~TT############~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "####################%~~~~~~~~~~~g%~~~~T~%.%~~~~~TT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~TTTTTTTTTTTT~~~~~~%~~~~~~~~~~g~~~~~~~~~%.%~~~~TTT#                                                ~";
  testMapString += "~TTtttttttttt~~~~~%~~%~%%www~~~~~g~~%~~~%*%~T~TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#TTtTTTTTTTTTT~~~~~%~~~~~wDw~~~%~~~~~~T~%%%~~TTT~T~TT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#TTtttttttTTTTT~~~~~%~~~%www~~~~~~~~~~~~~~~~TTT~T~TTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~TTTTTTTTtTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTTT";
  testMapString += "~TTTTT=tttTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#TTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~TTTTTTTTTTTTTTTTTTTTTTTTTTwwwwTTTTTTTTTTTTTTTTTTTTTTTT                                            ~";
  testMapString += "~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#TTTTTTTTTTTTTTTTTTTTTTTTTTTTwwwTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                 wwwww                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~         ~                                       T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  testMapString += "~                                                 T                                                ~";
  testMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  testMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  m[0] = new Map(testMapString);
  
  m[0].tiles[10][0].placeOccupant( color(150,150,250), "- You found one of my hiding spots!" );
  m[0].tiles[10][2].placeOccupant( color(255,0,0), "- I think I dropped a key in the flower garden." );
  m[0].tiles[16][2].placeOccupant( color(255,150,0), "- I love hiding things in chests!");
  m[0].tiles[22][0].placeOccupant( color(120,120,250), "- Where did my sister go?");
  
  m[0].tiles[11][4].createEvent(true,"- Walk into people to talk to them.");
  m[0].tiles[1][3].createEvent(true,"- Press (space) to search your current square. You can open chests this way, and also find items dropped by clumsy monsters.");
  m[0].tiles[3][1].createEvent(true,"- Press (i) to view your inventory. You can hold up to thirty items. While viewing, press (s) to sort.");
  m[0].tiles[5][1].createEvent(true,"- Press (E) to eat something. There are only four kinds of food on the planet.");
  m[0].tiles[7][1].createEvent(true,"- Press (D) to use magic potions. These are better than food items, but more expensive. We blame prohibition.");
  m[0].tiles[3][5].createEvent(true,"- This sign paid for by a generous donation from the sign foundation. And viewers like you.");
  m[0].tiles[6][2].createEvent(true,"- This is a save crystal. Step on it and type capital (S) to activate it. Press (ENTER) to confirm or any other key to abort.");
  m[0].tiles[18][5].createEvent(true,"- Press (k) to view your Keys. This door requires a Copper Key");
  m[0].tiles[16][5].createEvent(true,"- Press (o) to attempt to open a door. If you have the right key, it will be used up.");
  m[0].tiles[27][4].createEvent(true,"- Please do not step on the flowers.");
  //m.tiles[6][1].createEvent(false,"Event C","Three lines of text","Only happens once");

  String testDangerMap = "";
  testDangerMap += "A000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";

  testDangerMap += "B000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "0000000000000000000000000000000000000000000000000011111111111111111111111111111111111111111111111111";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Cxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Dxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  
  testDangerMap += "Exxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  
  testDangerMap += "Fxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Gxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Hxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Ixxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";

  testDangerMap += "Jxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  testDangerMap += "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx";
  dm = new DangerMap(testDangerMap);
  
  String tempMapString = "";
  tempMapString += "D########T~~tt~~t~~~~T~~~~~~~~~~~~~~~~~~~~~~~TTTTT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "##.?.?.?############~~~%%%%%%%%%~~~~~~~~###~~~TTTT#                                                ~";
  tempMapString += "#.....?*.#.....=.==#~~~%%%www%%%~~~~T~~~#=#~~~~TTT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#?.......###.#######~~~%%%%%%%%%~~~~~~~~#+#~~T~~TT############~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#..........?......c+......~?~............c......i+        s+=                                      ~";
  tempMapString += "#=.?.=..........?.?#~~~~~.....~~~~~~~~~~%.%~T~~~TT############~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "####################%~~~~~~~~~~~~%~~~~T~%.%~~~~~TT#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~TTTTTTTTTTTT~~~~~~%~~~~~~~~~~~~~~~~~~~~%.%~~~~TTT#                                                ~";
  tempMapString += "~TTtttttt~ttt~~~~~%~~%~%%www~~~~~~~~%~~~%*%~T~TTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#TTtTTTTTTTTTT~~~~~%~~~~~wDw~~~%~~~~~~T~%%%~~TTT~T~TT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#TTtt~ttttTTTTT~~~~~%~~~%www~~~~~~~~~~~~~~~~TTT~T~TTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~TTTTTTTTtTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTTTTTT                                            ~";
  tempMapString += "~TTTTT=~ttTTTTTTTTTTTTTTTTwwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#TTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~TTTTTTTTTTTTTTTTTTTTTTTTTTwwwwTTTTTTTTTTTTTTTTTTTTTTTT                                            ~";
  tempMapString += "~TTTTTTTTTTTTTTTTTTTTTTTTTTTTTwTTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#TTTTTTTTTTTTTTTTTTTTTTTTTTTTwwwTTTTTTTTTTTTTTTTTTTTTTT~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                 wwwww                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~wwwww~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~T~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~         ~                                       T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";
  tempMapString += "~                                                 T                                                ~";
  tempMapString += "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~";
  tempMapString += "#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#";

  for(int i = 0; i < savePoints.length; i++)
    savePoints[i]=new SavePoint();
  savePoints[0] = new SavePoint(7,2,0);
  savePoints[1] = new SavePoint(41,8,0);
  
  battleMonsters = new Monster[3];
  battleMonsters[0] = new Monster();
  battleMonsters[1] = new Monster();
  battleMonsters[2] = new Monster();
}

void draw()
{
  background(0);
  if(display == Display.MAIN_MENU)
    vanGogh.drawMainMenu();

  vanGogh.drawTextBoxes(input,textBuffer,textLine1,textLine2);
  vanGogh.drawHeroBoxes( party.hero );
  drawConditions();
  if(step == HeroCreationStep.JOB)
    vanGogh.drawJobChoices(currentHero);
  else if(step == HeroCreationStep.COLOR)
    vanGogh.drawColorBars(tempRed,tempGreen,tempBlue);
    
  if(display == Display.MAP)
    m[0].drawMapOnPosition(party.X,party.Y,party.hero(0).getColor(),party.hero(1).getColor(),party.hero(2).getColor());
  else if(display == Display.KEY_LIST)
    vanGogh.drawKeys(party.keyInventory);
  else if(display == Display.ITEM_LIST)
    vanGogh.drawItems(party.inventory);
  else if(display == Display.FOOD_MENU)
    vanGogh.drawFoodMenu(party.inventory);
  else if(display == Display.POTION_MENU)
    vanGogh.drawPotionMenu(party.inventory);
  else if(display == Display.HERO_SELECT)
    vanGogh.drawHeroSelectScreen();
  else if(display == Display.BATTLE)
  {
    if(vanGogh.battleWindowOpening)
      m[0].drawMapOnPosition(party.X,party.Y,party.hero(0).getColor(),party.hero(1).getColor(),party.hero(2).getColor());
    else
      battle.runBattle(); //don't begin initiative until battle is loaded
      
    vanGogh.drawBattleWindow();
    //if(battle.turn == 0 || battle.turn == 1 || battle.turn == 2)
    //  vanGogh.drawBattleIcons(battle.turn);
    
    //if(input == Input.BATTLE_ITEM)
    //{
    //  println("ENTERED ITEM MODE");
    //  vanGogh.drawBattleItems( battle.turn, party.inventory );
    //}
    
    int partWhereBattleLoopHappens; //I NEED TO FIX THE TEXT PUSH
  }
  
  if(heroDataDisplayed[0]||heroDataDisplayed[1]||heroDataDisplayed[2])
  {
    if(heroDataDisplayed[0])
      vanGogh.drawHeroData(0);
    else if(heroDataDisplayed[1])
      vanGogh.drawHeroData(1);
    else if(heroDataDisplayed[2])
      vanGogh.drawHeroData(2);
  }

  if(input==Input.ADVANCE_TEXT)
    vanGogh.drawAdvanceTextPrompt();
  
  //Advance any animations
  vanGogh.animate();
  
  //println(input);
}

void drawConditions()
{
  for(int h = 0; h < 3; h++)
    for(int i = 0; i < 5; i++)
      if(party.hero(h).hasCondition(i))
        vanGogh.drawCondition(i,h);
}

public String keyName( Key k )
{
  switch(k)
  {
    case COPPER_KEY: return "Copper Key";
    case SKELETON_KEY: return "Skeleton Key";
    case IRON_KEY: return "Iron Key";
    default: return "";
  }
}
  
Key stringToKey( String s )
{
  switch(s)
  {
    case "COPPER_KEY": return Key.COPPER_KEY;
    case "SKELETON_KEY": return Key.SKELETON_KEY;
    case "IRON_KEY": return Key.IRON_KEY;
    default: return Key.NONE;
  }
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
      input = Input.HERO_JOB_CHOICE;
      advanceText("Select "+textBuffer+"'s Job");
    }
  }
  
  return textBuffer;
}


void advanceText( String s ) //usually for specific edge cases. most text should use pushTextLine()
{
  textLine1 = textLine2;
  textLine2 = s;
}

void advanceNextTextLine() //pops the queue (do you pop queues? I don't recall)
{
  advanceText(log.message());
  if( log.isEmpty() ) //<>//
    input = previous;
}

void displayTextLine( String s )
{
  pushTextLine( s );
  key = ' '; keyPressed();
}

void pushTextLine( String s ) //Add a line to the queue
{
  previous = input;
  input = Input.ADVANCE_TEXT; //forces text advance prompt for more than two lines 
  key = ' ';
  log.addMessage(s);
}

void createInventories()
{
  for(int i = 0; i < party.keyInventory.length; i++)
    party.keyInventory[i] = Key.NONE;
  for(int i = 0; i < party.inventory.length; i++)
    party.inventory[i] = new Item();
}

void setUpLootTable()
{
  //Zeros out loot tables with worthless keys at 0,0
  for(int i = 0; i < lootTable.length; i++)
    for(int j = 0; j < lootTable[0].length; j++)
      lootTable[i][j] = new Loot(0,0,Key.NONE);
  
  //Sets up first floor's loot
  createLoot(0,0,15,2,Key.COPPER_KEY);
  createLoot(0,1,1,5,new Item("Red Crystal",75));
  createLoot(0,2,5,5,new Item("Orange Crystal",75));
  createLoot(0,3,30,2,Key.COPPER_KEY);
  createLoot(0,4,41,2,Key.IRON_KEY);
  createLoot(0,5,6,12,Key.SKELETON_KEY);
  createLoot(0,6,60,4,new Item("Win Crystal",1000));
  createLoot(0,7,2,3,new Item("Gold Coin",1));
  
  //fill empty progressSwitches
  for(int i = 0; i < itemSwitches.length; i++)
    if(itemSwitches[i]==null)
      itemSwitches[i]=new ProgressSwitch();
}

//Gets floor, x, y, and key type. Adds to the loot table and progress switches
void createLoot( int fl, int serial, int xP, int yP, Key k )
{
  lootTable[fl][serial] = new Loot(xP,yP,k);
  itemSwitches[itemSwitchCount++] = new ProgressSwitch( SwitchType.CHEST, xP, yP );
}

//Gets floor, x, y, and item details. Adds to the loot table and progress switches
void createLoot( int fl, int serial, int xP, int yP, Item i )
{
  lootTable[fl][serial] = new Loot(xP,yP,i);
  itemSwitches[itemSwitchCount++] = new ProgressSwitch( SwitchType.CHEST, xP, yP );
}

String ordinalNumber( int num ) //for indecies
{
  if(num==0) return "first";
  if(num==1) return "second";
  if(num==2) return "third";
  return "?????";
}

String indefArticle( String word )
{
  if( isVowel( word.toLowerCase().charAt(0) ) )
    return "an";
  return "a";
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
  
  if(checkForBattle())
  {
    triggerBattle(dm.dangerValueChar(party.X,party.Y));
  }
  
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
    randomBattleCounter = 0;
    return true;
  }
  
  println(randomBattleCounter);
  randomBattleCounter++;
  return false;
}

String bonkText( char direction ) //for when the heroes run into obstacles
{
  int x = party.X, y = party.Y;
  if( direction == 'l'){ x--; if(x<0)return"BONK";}
  else if( direction == 'r'){ x++; if(x>=m[0].tiles.length)return"BONK";}
  else if( direction == 'u'){ y--; if(y<0)return"BONK";}
  else if( direction == 'd'){ y++; if(y>=m[0].tiles[0].length)return"BONK";}
  
  switch( m[party.floor].tiles[x][y].type )
  {
    case WALL: return "Solid stone";
    case WATER: return "You never learned how to swim";
    case TREE: case DARK_TREE: return "A tree";
    case DOOR: return m[party.floor].tiles[party.X][party.Y].keyMessage();
  }
  
  if(m[party.floor].tiles[x][y].occupied)
    return m[party.floor].tiles[x][y].occupantText;
    
  return "Bonk";
}

int squareHasLoot( int x, int y ) //-1 if nothing
{
  for(int i = 0; i < lootTable[party.floor].length; i++)
    if(lootTable[party.floor][i].xPos == x
    && lootTable[party.floor][i].yPos == y
    && lootTable[party.floor][i].item.keyType == Key.NONE )
      return i;
  return -1;
}

int squareHasKey( int x, int y )
{
  for(int i = 0; i < lootTable[party.floor].length; i++)
    if(lootTable[party.floor][i].xPos == x
    && lootTable[party.floor][i].yPos == y
    && lootTable[party.floor][i].item.keyType != Key.NONE )
      return i;
  return -1;
  
}

//This assumes the party is standing on the loot to be cleared
void clearLoot( int index )
{
  lootTable[party.floor][index] = emptyChest;
  if(m[party.floor].tiles[party.X][party.Y].obj == Object.CHEST)
    openChestSound.play();
  m[party.floor].tiles[party.X][party.Y].obj = Object.NONE;
}

//For loading from files - fixes disappearing save point problem (I hope)
void clearLoot( int floor, int xPos, int yPos, int index )
{
  lootTable[floor][index] = emptyChest;
  m[party.floor].tiles[xPos][yPos].obj = Object.NONE;
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

void triggerBattle( char danger )
{
  if( danger == '0' || danger > 119 || m[0].tiles[party.X][party.Y].type == TileType.SAFE )
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
    battle = new Battle(party.hero,dm.dangerValueChar(party.X,party.Y));
  }
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
    if(key == 'a' || keyCode == LEFT)
      //if(!attemptMove("left"))advanceText("Bonk");
      if(!attemptMove("left"))advanceText(bonkText('l'));
    if(key == 'd' || keyCode == RIGHT)
      if(!attemptMove("right"))advanceText(bonkText('r'));
    if(key == 's' || keyCode == DOWN)
      if(!attemptMove("down"))advanceText(bonkText('d'));
    if(key == 'w' || keyCode == UP)
      if(!attemptMove("up"))advanceText(bonkText('u'));
    if(key == 'o' && m[party.floor].tiles[party.X][party.Y].interactive) //open
      if(m[party.floor].tiles[party.X][party.Y].interact(party.keyInventory))
      {
        m[party.floor].openDoorsAround(party.X,party.Y);
      }
    if(key == ' ')
    {  //this is a bit of a mess. could improve
      int lootIndex = max(squareHasLoot(party.X,party.Y),squareHasKey(party.X,party.Y));
      if(lootIndex>=0)
      {
        party.addToInventory(lootTable[party.floor][lootIndex].item);
        clearLoot(lootIndex);
        flipItemSwitch(lootIndex);
      }
      else
        advanceText("Nothing found.");
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
    if(display == Display.MAP && key == 'k')
    {
      previousDisplay = display;
      display = Display.KEY_LIST;
    }
    if(display == Display.MAP && key == 'i')
    {
      previousDisplay = display;
      display = Display.ITEM_LIST;
    }
    
    if(display == Display.MAP && key == 'z')
      party.hero[0].takeDamage(5);
  }
  //ITEM USE INPUT
  else if(input == Input.ITEM_USE)
  {
    if(key == ' ')
    {
      display = Display.MAP;
      input = Input.EXPLORING;
    }
    else if(key > 48 && key < 53)
    {
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
      {
        int randomTarget = int(random(3)); //FOR TESTING
        pushTextLine( party.hero[battle.turn].name + " attacks!");
        key = ' '; keyPressed(); //Force text to advance
        battle.waitingForText=true;
        delay(500);
        pushTextLine( battleMonsters[randomTarget].name + " is dealt " + party.hero[battle.turn].str + " damage.");
        battleMonsters[randomTarget].takeDamage(party.hero[battle.turn].str);
        battle.waitingForText=false;
        delay(300);
        battle.resumeInitiative();
      }
      if( key == 'd')
      {
        pushTextLine( party.hero[battle.turn].name + " defends!");
        key = ' '; keyPressed(); //Force text to advance
        party.hero[battle.turn].defending = true;
        battle.setBattleDelay(1);
        battle.resumeInitiative();
      }
      if( key == 's')
      {
        input = Input.BATTLE_SKILL;
      }
      if( key == 'x')
      {
        displayTextLine( "Selcet a potion to drink.");
        input = Input.BATTLE_ITEM;
      }
    }
    else if(input == Input.BATTLE_SKILL)
    {
      if( key == 'x' || key == ' ' )
      {
        input = Input.BATTLE_MENU;
      }
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
          potionDrinkSound.play();
          if( party.consume(36,0) )
          {
            input = Input.BATTLE_MENU;
            battle.setBattleDelay(1);
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
      if( key == 'x' || key == ' ' )
      {
        input = Input.BATTLE_MENU;
      }
    }
    else if(input == Input.BATTLE_ITEM_HERO_CHOICE) //choosing target hero for item
    {
      if( key == ' ' )
        input = Input.BATTLE_ITEM;
      if( key == 'a' ) key = '1'; if( key == 's' ) key = '2'; if( key == 'd' ) key = '3';
      if( key == '1' || key == '2' || key == '3' )
      {
        potionDrinkSound.play();
        if( party.consume(potionType*12,key-49) ) //-49 to account for array index offset
        {
          input = Input.BATTLE_MENU;
          battle.setBattleDelay(1);
          battle.resumeInitiative();
        }
      }
    }
  }
  //else if(display == Display.BATTLE_ITEM)
  
  //REASONS FOR SELECTING A HERO
  else if(display == Display.HERO_SELECT && input == Input.HERO_SELECT)
  {
    //USING AN ITEM
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
          foodBiteSound.play();
         
        if(reason == HeroSelectReason.DRINK)
          potionDrinkSound.play();
         
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
    println("DEBUG"); //<>//
    println(party.X + " " + party.Y);
    println(dm.dangerValueChar(party.X,party.Y));
  }
}

void keyReleased()
{
  if( display == Display.ITEM_LIST && key == 's' )
    party.sortInventory();
  else if( previousDisplay != Display.NONE && (key == 'k' || key == 'i') )
  {
    display = previousDisplay;
    previousDisplay = Display.NONE;
  }
}

void mouseClicked()
{
  if(step==HeroCreationStep.JOB)
  {
    if(dist(mouseX,mouseY,150,200)<37.5) tempJob = Job.KNIGHT;
    else if(dist(mouseX,mouseY,350,200)<37.5) tempJob = Job.BARBARIAN;
    else if(dist(mouseX,mouseY,550,200)<37.5) tempJob = Job.KARATE;
    else if(dist(mouseX,mouseY,150,400)<37.5) tempJob = Job.THIEF;
    else if(dist(mouseX,mouseY,350,400)<37.5) tempJob = Job.PRIEST;
    else if(dist(mouseX,mouseY,550,400)<37.5) tempJob = Job.MAGE;

    if(tempJob!=Job.NONE)
    {
      advanceText("What is "+tempName+"'s favorite color?");
      step = HeroCreationStep.COLOR;
      input = Input.HERO_COLOR_CHOICE;
    }
  }
  else if( step == HeroCreationStep.COLOR )
  {
    if( mouseX > 300 && mouseX < 400 && mouseY >362.5 && mouseY < 437.5 )
    {
      tempColor = color(tempRed,tempGreen,tempBlue);
      tempInverseColor = color(255-tempRed,255-tempGreen,255-tempBlue);
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
        step = HeroCreationStep.DONE;
        pushTextLine("Our heroes are assembled!");
        pushTextLine("Let the adventure begin!");
        pushTextLine("Use (w)(a)(s)(d) or arrows to move.");
        display = Display.MAP;
        previous = Input.EXPLORING;
        advanceNextTextLine();
      }
    }
  }
}

void mousePressed()
{
  if( step == HeroCreationStep.COLOR ) //for selecting hero colors
  {
    if( mouseX > 100 && mouseX < 600 && mouseY >190 && mouseY < 210 )
      tempRed = (mouseX-100)/2;
    if( mouseX > 100 && mouseX < 600 && mouseY >240 && mouseY < 260 )
      tempGreen = (mouseX-100)/2;
    if( mouseX > 100 && mouseX < 600 && mouseY >290 && mouseY < 310 )
      tempBlue = (mouseX-100)/2;
  }
  if( input == Input.HERO_SELECT )  //THIS WORKS!?!?
  {
    if(dist( mouseX,mouseY, 150,320)<37.5)
    {
      key='1';
      keyPressed();
    }
    if(dist( mouseX,mouseY, 350,320)<37.5)
    {
      key='2';
      keyPressed();
    }
    if(dist( mouseX,mouseY, 550,320)<37.5)
    {
      key='3';
      keyPressed();
    }
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

  println(mouseX + " " + mouseY);
}

void mouseReleased()
{
  heroDataDisplayed[0]=heroDataDisplayed[1]=heroDataDisplayed[2]=false;
}

public enum Input
{
  NONE, ADVANCE_TEXT, TYPING, EXPLORING, ITEM_USE,
  HERO_SELECT,
  BATTLE_MENU, BATTLE_SKILL, BATTLE_ITEM, BATTLE_ITEM_HERO_CHOICE,
  HERO_JOB_CHOICE, HERO_COLOR_CHOICE
}

public enum HeroCreationStep //for the initial setup
{
  NAME, JOB, COLOR, DONE
}

public enum Display
{
  MAIN_MENU, MAP, BATTLE, KEY_LIST, ITEM_LIST, 
  FOOD_MENU, POTION_MENU, HERO_SELECT, NONE
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
  
  for (int i = 0; i < 3; i++) 
  {
    saveOutput.println(party.hero[i].name);
    saveOutput.println(party.hero[i].job);
    saveOutput.println(red(party.hero[i].favColor));
    saveOutput.println(green(party.hero[i].favColor));
    saveOutput.println(blue(party.hero[i].favColor));
    saveOutput.println(party.hero[i].level);
    saveOutput.println(party.hero[i].nextLevel);
    saveOutput.println(party.hero[i].exp);
    saveOutput.println(party.hero[i].weapon.name);
    saveOutput.println(party.hero[i].weapon.value);
    saveOutput.println(party.hero[i].weapon.power);
    saveOutput.println(party.hero[i].armor.name);
    saveOutput.println(party.hero[i].armor.value);
    saveOutput.println(party.hero[i].armor.power);
    saveOutput.println();
  } 
  
  for(int i = 0; i < savePoints.length; i++)
    if(party.X==savePoints[i].X && party.Y == savePoints[i].Y)
    {
      saveOutput.println(i);
      saveOutput.println();
      break;
    }
  
  for(int i = 0; i < party.inventory.length; i++)
  {
    if(party.inventory[i].value>0)
    {
      saveOutput.println(party.inventory[i].name);
      saveOutput.println(party.inventory[i].value);
    }
  }
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < party.keyInventory.length; i++)
    if(party.keyInventory[i]!=Key.NONE)
      saveOutput.println(party.keyInventory[i]);
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < itemSwitches.length; i++)
  {
    if(itemSwitches[i]==null)
      saveOutput.println(false);
    else
      saveOutput.println(itemSwitches[i].active);
  }
  saveOutput.println("XX");
  saveOutput.println();
  
  for(int i = 0; i < doorSwitches.length; i++)
  {
    if(doorSwitches[i]==null)
      saveOutput.println(false);
    else
      saveOutput.println(doorSwitches[i].active);
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
    
    //load hero data
    for (int i = 0, offset; i < 3; i++) 
    {
      offset = i*15;
      party.hero[i] = new Hero(saveFileText[0+offset],
                               stringToJob(saveFileText[1+offset]),
                               color(int(saveFileText[2+offset]),int(saveFileText[3+offset]),int(saveFileText[4+offset])),
                               color(255-int(saveFileText[2+offset]),255-int(saveFileText[3+offset]),255-int(saveFileText[4+offset])));
      //party.hero[i].setStatsToLevel(saveFileText[5+offset]);
      party.hero[i].nextLevel = int(saveFileText[6+offset]);
      party.hero[i].exp = int(saveFileText[7+offset]);
      
      party.hero[i].weapon = new Equipment(saveFileText[8+offset],int(saveFileText[9+offset]),true,int(saveFileText[10+offset]));
      party.hero[i].armor = new Equipment(saveFileText[11+offset],int(saveFileText[12+offset]),false,int(saveFileText[13+offset]));
    }  
    
    //load save point
    println("Save point # " + int(saveFileText[45]));
    party.setPosition(savePoints[int(saveFileText[45])]); //line 45, will be based on list
    //AT THIS POINT, SAVE POINT IS DELETED
    
    //load inventory items
    createInventories(); //zeros out inventories - may be redundant in final version
    int fileLine = 47; //first line of inventory data
    while(!saveFileText[fileLine].equals("XX"))
    {
      party.addToInventory(new Item(saveFileText[fileLine],int(saveFileText[fileLine+1])));
      fileLine+=2;
    }
    fileLine+=2;
    while(!saveFileText[fileLine].equals("XX"))
    {
      party.addToInventory(new Item( stringToKey(saveFileText[fileLine])));
      fileLine++;
    }
    
    //set progress switches
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
      
    switchIndex=0;
    fileLine+=2;
    while(!saveFileText[fileLine].equals("XX") && doorSwitches[switchIndex]!=null)
      doorSwitches[switchIndex++].active = boolean(saveFileText[fileLine++]);
    
    //interacts with all progress switches
    flipSwitches();
    
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
    pushTextLine("Welcome to Ritchie's Dungeon Crawl!");
    pushTextLine("What is your first hero's name?");
    
    //Begin normal character creation
    display = Display.NONE; //<>//
    step = HeroCreationStep.NAME;
    newGame = true;
    //input = Input.TYPING;
    previous = Input.TYPING;
  }
}

void flipSwitches()
{
  for(int i = 0; i < min(itemSwitches.length,lootTable[0].length); i++) //**only checking one floor**
    if(itemSwitches[i]!=null && !itemSwitches[i].active) //switch has been deactivated
      clearLoot(party.floor,itemSwitches[i].X,itemSwitches[i].Y,i);
  for(int i = 0; i < doorSwitches.length; i++)
    if(doorSwitches[i]!=null && !doorSwitches[i].active) //switch has been deactivated
    {
      m[doorSwitches[i].floor].openDoorsAround(doorSwitches[i].X,doorSwitches[i].Y);
      m[doorSwitches[i].floor].tiles[doorSwitches[i].X][doorSwitches[i].Y].interactive=false; //had to add this because the interact() method normally handles it
    }
}
